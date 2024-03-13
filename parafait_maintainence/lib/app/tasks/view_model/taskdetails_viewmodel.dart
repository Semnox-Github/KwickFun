import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/lookupRules/MaintainanceLookupsAndRulesBL.dart';
import 'package:rxdart/streams.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/hr/bl/user_container_bl.dart';
import 'package:semnox_core/modules/hr/model/user_container_dto.dart';
import 'package:semnox_core/modules/lookups/model/lookup_container_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/bl/assets_bl.dart';
import 'package:semnox_core/modules/maintenance/assets/model/asset_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/bl/maintainence_bl.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/maintainence_service_dto.dart';
import 'package:semnox_core/modules/maintenance/task/bl/task_bl.dart';
import 'package:semnox_core/modules/maintenance/task/model/task_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/dataprovider/data_provider.dart';
import 'package:semnox_core/utils/dataprovider/data_state.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:semnox_core/widgets/input_fields/nfc_reader/nfc_reader.dart';

class TaskDetailData {
  CheckListDetailDTO? checkListDetailDTO;
  String? menuClick;

  TaskDetailData({
    this.menuClick,
    this.checkListDetailDTO,
  });

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is TaskDetailData &&
        o.menuClick == menuClick &&
        o.checkListDetailDTO == checkListDetailDTO;
  }

  @override
  int get hashCode => menuClick.hashCode ^ checkListDetailDTO.hashCode;
}

class TaskDetailViewmodel extends ChangeNotifier {
  static final provider =
      ChangeNotifierProviderFamily<TaskDetailViewmodel, TaskDetailData>(
    (ref, params) {
      return TaskDetailViewmodel(
        params.checkListDetailDTO,
        params.menuClick,
      );
    },
  );
  CheckListDetailDTO? checkListDetailDTO;
  String? menuClick;
  final DataProvider<bool> stateupdate = DataProvider<bool>(initial: false);
  late BuildContext context;
  ValueStream<DataState<bool>> get loadstates => stateupdate.dataStream;
  MaintainanceLookupsAndRulesBL? maintainanceLookupsAndRulesRepository;
  ExecutionContextDTO? _executionContextDTO;
  List<LookupValuesContainerDtoList> jobstatusList = [];
  List<GenericAssetDTO>? assetsList = [];
  List<TaskDto>? tasksList = [];
  List<UserContainerDto>? userList = [];
  SemnoxDropdownProperties<LookupValuesContainerDtoList> statusField =
      SemnoxDropdownProperties<LookupValuesContainerDtoList>(items: []);
  SemnoxDropdownProperties<GenericAssetDTO> assetField =
      SemnoxDropdownProperties<GenericAssetDTO>(items: []);
  SemnoxDropdownProperties<TaskDto> taskField =
      SemnoxDropdownProperties<TaskDto>(items: []);
  SemnoxDropdownProperties<UserContainerDto> assigneduserField =
      SemnoxDropdownProperties<UserContainerDto>(items: []);
  SemnoxTextFieldProperties cardNoField =
      SemnoxTextFieldProperties(label: "Card Number");
  SemnoxTextFieldProperties remarksField =
      SemnoxTextFieldProperties(label: "Remarks");
  SemnoxNFCReaderProperties cardReader =
      SemnoxNFCReaderProperties(canReadBarcode: true);

  late StreamSubscription<String> _subscription;

  TaskDetailViewmodel(this.checkListDetailDTO, this.menuClick) {
    init();
  }

  void init() async {
    stateupdate.startLoading();
    _executionContextDTO =
        await ExecutionContextProvider().getExecutionContext();
    maintainanceLookupsAndRulesRepository =
        MaintainanceLookupsAndRulesBL(_executionContextDTO!);
    jobstatusList = await maintainanceLookupsAndRulesRepository!.getJobStatus();
    statusField = SemnoxDropdownProperties<LookupValuesContainerDtoList>(
        label: "Status",
        items: jobstatusList
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
    if (jobstatusList.isNotEmpty) {
      final initial = jobstatusList.firstWhereOrNull(
          (element) => checkListDetailDTO?.status == element.lookupValueId);
      statusField.setInitialValue(initial ?? jobstatusList.first);
    }
    Map<AssetsGenericDTOSearchParameter, dynamic> genericAssetsSearchParams = {
      AssetsGenericDTOSearchParameter.SITEID: _executionContextDTO!.siteId,
      AssetsGenericDTOSearchParameter.ISACTIVE: 1,
    };
    assetsList = await AssetsListBL(_executionContextDTO!)
        .getAssetsDTOList(genericAssetsSearchParams);
    assetField = SemnoxDropdownProperties<GenericAssetDTO>(
      label: "Asset Name",
      items: assetsList!
          .map((e) => DropdownMenuItem<GenericAssetDTO>(
              value: e, child: SemnoxText(text: "${e.name}")))
          .toList(),
    );
    if (assetsList!.isNotEmpty) {
      final initial = assetsList?.firstWhereOrNull(
          (element) => checkListDetailDTO?.assetId == element.assetId);
      assetField.setInitialValue(initial ?? assetsList!.first);
    }
    Map<TaskDTOSearchParameter, dynamic> taskSearchParams = {
      TaskDTOSearchParameter.SITEID: _executionContextDTO!.siteId,
      TaskDTOSearchParameter.ISACTIVE: 1,
    };
    tasksList = await TaskListBL(_executionContextDTO!)
        .getTaskDTOList(taskSearchParams);
    taskField = SemnoxDropdownProperties<TaskDto>(
      label: "Task Name",
      items: tasksList!
          .map((e) => DropdownMenuItem<TaskDto>(
              value: e, child: SemnoxText(text: "${e.taskName}")))
          .toList(),
    );
    if (tasksList!.isNotEmpty) {
      final initial = tasksList?.firstWhereOrNull(
          (element) => checkListDetailDTO?.jobTaskId == element.jobTaskId);
      taskField.setInitialValue(initial ?? tasksList!.first);
    }
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
      final initial = userList?.firstWhereOrNull(
          (element) => checkListDetailDTO?.assignedUserId == element.userId);
      assigneduserField.setInitialValue(initial ?? userList!.first);
    }
    remarksField.setInitialValue(checkListDetailDTO?.chklistRemarks ?? "");
    _subscription = cardReader.valueChangeStream.listen(_onCardRead);
    cardReader.startListening();
    cardNoField.setInitialValue(checkListDetailDTO?.cardNumber ?? "");
    stateupdate.updateData(true);
    notifyListeners();
  }

  _onCardRead(String cardNumber) {
    cardNoField.setInitialValue(cardNumber);
  }

  updateTaskDetails(BuildContext context) async {
    var checkListDetailDTO = await _buildCheckListDetailDTO();
    int? status = await updateTask(checkListDetailDTO!);
    if (status! > 0) {
      // ignore: use_build_context_synchronously
      Utils()
          .showSemnoxDialog(context, "Job Details Saved Successfully")
          .then((exit) {
        if (exit == null) return;
        if (exit) {
          Modular.to.pop(context);
        }
      });
    }
  }

  Future<CheckListDetailDTO?> _buildCheckListDetailDTO() async {
    checkListDetailDTO?.cardNumber = cardReader.value;
    checkListDetailDTO?.taskName = taskField.value?.taskName;
    checkListDetailDTO?.assetId = assetField.value?.assetId;
    checkListDetailDTO?.status = statusField.value?.lookupValueId;
    checkListDetailDTO?.assignedTo = assigneduserField.value?.loginId;
    checkListDetailDTO?.assignedUserId = assigneduserField.value?.userId;
    checkListDetailDTO?.chklistRemarks = remarksField.value;
    checkListDetailDTO?.siteid = _executionContextDTO?.siteId;
    checkListDetailDTO?.isChanged = true;
    checkListDetailDTO?.serverSync = false;
    checkListDetailDTO?.chklistValue =
        statusField.value?.lookupValue != 'Closed' ? false : true;
    return checkListDetailDTO;
  }

  Future<int?> updateTask(CheckListDetailDTO checkListDetailDTO) async {
    try {
      CheckListDetailsBL checkListDetailsBL =
          CheckListDetailsBL.dto(_executionContextDTO!, checkListDetailDTO);
      int status = await checkListDetailsBL.updateCheckListDTO(context);
      return status;
    } catch (e) {
      Utils().showSemnoxDialog(context, e.toString());
    }
    return null;
  }
}
