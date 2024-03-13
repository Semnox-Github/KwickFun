import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/lookupRules/MaintainanceLookupsAndRulesBL.dart';
import 'package:rxdart/streams.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/hr/bl/user_container_bl.dart';
import 'package:semnox_core/modules/hr/model/user_container_dto.dart';
import 'package:semnox_core/modules/hr/model/users_dto.dart';
import 'package:semnox_core/modules/hr/provider/userrole_data_provider.dart';
import 'package:semnox_core/modules/lookups/model/lookup_container_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/bl/assets_bl.dart';
import 'package:semnox_core/modules/maintenance/assets/model/asset_dto.dart';
import 'package:semnox_core/modules/maintenance/task/bl/task_bl.dart';
import 'package:semnox_core/modules/maintenance/task/model/task_dto.dart';
import 'package:semnox_core/modules/parafait_defaults_configuration/provider/default_config.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/dataprovider/data_provider.dart';
import 'package:semnox_core/utils/dataprovider/data_state.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/widgets/input_fields/date_field/properties.dart';

class TaskFilterViewmodel extends ChangeNotifier {
  TaskFilterViewmodel(this.ref, this.menuClick) {
    init();
  }

  late Ref? ref;

  static final provider = ChangeNotifierProvider.autoDispose
      .family<TaskFilterViewmodel, String>((ref, params) {
    return TaskFilterViewmodel(ref, params);
  });
  SemnoxDropdownProperties<GenericAssetDTO> assetField =
      SemnoxDropdownProperties<GenericAssetDTO>(items: []);

  SemnoxDropdownProperties<TaskDto> taskField =
      SemnoxDropdownProperties<TaskDto>(items: []);

  SemnoxDropdownProperties<UserContainerDto> assigneduserField =
      SemnoxDropdownProperties<UserContainerDto>(items: []);

  SemnoxDropdownProperties<LookupValuesContainerDtoList> statusField =
      SemnoxDropdownProperties<LookupValuesContainerDtoList>(
          items: [], enabled: false);

  DateFieldProperties scheduleFromField = DateFieldProperties(
      label: "Schedule From", initial: null, pickTime: false);

  DateFieldProperties scheduleToField =
      DateFieldProperties(label: "Schedule To", initial: null, pickTime: false);

  SemnoxCheckBoxProperties jobpastDueDate =
      SemnoxCheckBoxProperties(label: "Jobs Past Due Date?");

  ExecutionContextDTO? _executionContextDTO;
  String? menuClick;

  MaintainanceLookupsAndRulesBL? maintainanceLookupsAndRulesRepository;

  List<LookupValuesContainerDtoList>? statusList = [];

  List<GenericAssetDTO>? assetsList = [];
  List<TaskDto>? tasksList = [];
  List<UserContainerDto>? userList = [];

  final DataProvider<bool> stateupdate = DataProvider<bool>(initial: false);
  ValueStream<DataState<bool>> get loadstates => stateupdate.dataStream;

  bool jobPastDueDate = false;

  var scheduleFromController = TextEditingController();

  var scheduleToController = TextEditingController();
  DateTime currentDateTime = DateTime.now();

  String? schedulefromdate, scheduletodate;

  late StreamSubscription<bool?> subscription;
  bool scheduleFromFieldenabled = true,
      scheduleToFieldenabled = true,
      assignedUserFielddropdown = true;

  void init() async {
    stateupdate.startLoading();
    _executionContextDTO =
        await ExecutionContextProvider().getExecutionContext();
    maintainanceLookupsAndRulesRepository =
        MaintainanceLookupsAndRulesBL(_executionContextDTO!);

    scheduleFromField.setInitialValue(DateTime.now());

    scheduleToField.setInitialValue(DateTime.now());

    statusList = await maintainanceLookupsAndRulesRepository!.getJobStatus();

    statusField = SemnoxDropdownProperties<LookupValuesContainerDtoList>(
        label: "Status",
        items: statusList!
            .map((e) => DropdownMenuItem<LookupValuesContainerDtoList>(
                value: e, child: SemnoxText(text: "${e.lookupValue}")))
            .toList(),
        enabled: true,
        validators: [
          (data) {
            if (data == null) {
              return "Select Any Site";
            }
            return null;
          }
        ]);
    if (statusList!.isNotEmpty) {
      final initial = menuClick != null
          ? statusList
              ?.firstWhereOrNull((element) => menuClick == element.lookupValue)
          : statusList?.first;
      statusField.setInitialValue(initial ?? statusList!.first);
    }

    Map<AssetsGenericDTOSearchParameter, dynamic> genericAssetsSearchParams = {
      AssetsGenericDTOSearchParameter.SITEID: _executionContextDTO!.siteId,
      AssetsGenericDTOSearchParameter.ISACTIVE: 1,
    };

    assetsList = await AssetsListBL(_executionContextDTO!)
        .getAssetsDTOList(genericAssetsSearchParams);

    assetField = SemnoxDropdownProperties<GenericAssetDTO>(
      label: "Assets",
      items: assetsList!
          .map((e) => DropdownMenuItem<GenericAssetDTO>(
              value: e, child: SemnoxText(text: "${e.name}")))
          .toList(),
    );
    if (assetsList!.isNotEmpty) {
      assetField.setInitialValue(assetsList!.first);
    }

    Map<TaskDTOSearchParameter, dynamic> taskSearchParams = {
      TaskDTOSearchParameter.SITEID: _executionContextDTO!.siteId,
      TaskDTOSearchParameter.ISACTIVE: 1,
    };

    tasksList = await TaskListBL(_executionContextDTO!)
        .getTaskDTOList(taskSearchParams);

    taskField = SemnoxDropdownProperties<TaskDto>(
      label: "Tasks",
      items: tasksList!
          .map((e) => DropdownMenuItem<TaskDto>(
              value: e, child: SemnoxText(text: "${e.taskName}")))
          .toList(),
    );
    if (tasksList!.isNotEmpty) {
      taskField.setInitialValue(tasksList!.first);
    }

    // Map<UserDTOSearchParameter, dynamic> userparams = {
    //   UserDTOSearchParameter.isActive: true,
    // };

    assignedUserFielddropdown = (await checkuserIsManager())!;

    if (assignedUserFielddropdown == true) {
      userList = await UserContainerListBL(_executionContextDTO)
          .getUserContainerDTOList();

      assigneduserField = SemnoxDropdownProperties<UserContainerDto>(
        label: "Assigned User",
        items: userList!
            .map((e) => DropdownMenuItem<UserContainerDto>(
                value: e, child: SemnoxText(text: "${e.userName}")))
            .toList(),
      );
      if (userList!.isNotEmpty) {
        assigneduserField.setInitialValue(userList!.first);
      }
    }

    subscription = jobpastDueDate.valueChangeStream.listen((event) {
      if (event == true) {
        scheduleFromFieldenabled = false;
        scheduleToFieldenabled = false;
      } else {
        scheduleFromFieldenabled = true;
        scheduleToFieldenabled = true;
      }
      notifyListeners();
    });

    stateupdate.updateData(true);
    notifyListeners();
  }

  Future<bool>? checkuserIsManager() async {
    var userroleDTO = UserRoleDataProvider.getuserroleDTO();
    if (userroleDTO.isNotEmpty) {
      if (userroleDTO.first.managerFlag == "Y") {
        return true;
      }
    }
    return false;
  }

  selectfromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 356)),
      builder: (context, child) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: SizedBox(
                height: 450,
                width: 700,
                child: child,
              ),
            ),
          ],
        );
      },
    );
    if (picked != null && picked != currentDateTime) {
      scheduleFromController.text =
          DateFormat(DefaultConfigProvider.getConfigFor("DATE_FORMAT"))
              .format(picked);
      schedulefromdate = DateFormat(Messages.defaultdateformat).format(picked);
      notifyListeners();
    }
  }

  selecttoDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 356)),
      builder: (context, child) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: SizedBox(
                height: 450,
                width: 700,
                child: child,
              ),
            ),
          ],
        );
      },
    );
    if (picked != null && picked != currentDateTime) {
      scheduleToController.text =
          DateFormat(DefaultConfigProvider.getConfigFor("DATE_FORMAT"))
              .format(picked);
      scheduletodate = DateFormat(Messages.defaultdateformat).format(picked);
      notifyListeners();
    }
  }
}
