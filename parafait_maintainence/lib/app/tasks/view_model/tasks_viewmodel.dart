import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:parafait_maintainence/app/lookupRules/MaintainanceLookupsAndRulesBL.dart';
import 'package:parafait_maintainence/app/parafait_home/route/module.dart';
import 'package:parafait_maintainence/app/tasks/view_model/taskdetails_viewmodel.dart';
import 'package:parafait_maintainence/app/tasks/view_model/tasks_filterviewmodel.dart';
import 'package:parafait_maintainence/app/widget/elements/task_modalsheet.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:rxdart/streams.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/hr/bl/user_container_bl.dart';
import 'package:semnox_core/modules/hr/model/user_container_dto.dart';
import 'package:semnox_core/modules/lookups/model/lookup_container_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/bl/maintainence_bl.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/maintainence_service_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/dataprovider/data_provider.dart';
import 'package:semnox_core/utils/dataprovider/data_state.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/widgets/elements/uihelper.dart';

class TabData {
  final String? menuclick;
  final DateTime? dateTime;
  final int? taskgroupid;

  TabData({this.menuclick, this.dateTime, this.taskgroupid});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TabData &&
        o.menuclick == menuclick &&
        o.dateTime == dateTime &&
        o.taskgroupid == taskgroupid;
  }

  @override
  int get hashCode =>
      menuclick.hashCode ^ dateTime.hashCode ^ taskgroupid.hashCode;
}

class CheckListData {
  CheckListDetailDTO? checkListDetailDTO;
  String? lookupvalue;
  CheckListData({
    required this.lookupvalue,
    this.checkListDetailDTO,
  });

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CheckListData &&
        o.checkListDetailDTO == checkListDetailDTO &&
        o.lookupvalue == lookupvalue;
  }

  @override
  int get hashCode => checkListDetailDTO.hashCode ^ lookupvalue.hashCode;
}

class TasksViewModel extends ChangeNotifier {
  static final provider =
      ChangeNotifierProvider.autoDispose.family<TasksViewModel, TabData>(
    (ref, params) {
      return TasksViewModel(
          params.menuclick, params.dateTime, params.taskgroupid);
    },
  );
  ExecutionContextDTO? _executionContextDTO;
  String? menuclick, searchQuery = "";
  DateTime? dateTime;
  List<CheckListDetailDTO>? maintainenceservicedto;
  late BuildContext? context;
  int tabIndex = 0;
  List<String> menulist = [];
  SlidableController? slidableController;
  MaintainanceLookupsAndRulesBL? maintainanceLookupsAndRulesRepository;
  List<LookupValuesContainerDtoList> jobstatusList = [];
  final DataProvider<bool> stateupdate = DataProvider<bool>(initial: false);
  ValueStream<DataState<bool>> get loadstates => stateupdate.dataStream;
  List<UserContainerDto>? userDTOList = [];
  SemnoxTextFieldProperties remarksField = SemnoxTextFieldProperties(
      label: "Remarks", hintText: "Enter The Remarks");
  SemnoxTextFieldProperties statusTextField = SemnoxTextFieldProperties(
      label: "Status", hintText: "Please Enter The Status");
  int? taskgroupid;

  TasksViewModel(this.menuclick, this.dateTime, this.taskgroupid) {
    menulist = ['Open', 'WFR', 'WIP', 'Closed'];
    init();
  }

  void init() async {
    stateupdate.startLoading();
    if (menuclick != null) {
      if (menuclick == "Open") menuclick = "Open";
      if (menuclick == "Waiting for Resources") menuclick = "WFR";
      if (menuclick == "Work in Progress") menuclick = "WIP";
      if (menuclick == "Closed") menuclick = "Closed";
      tabIndex = menulist.indexOf(menuclick.toString());
    }
    if (menuclick == "Open") menuclick = "Open";
    if (menuclick == "WFR") menuclick = "Waiting for Resources";
    if (menuclick == "WIP") menuclick = "Work in Progress";
    if (menuclick == "Closed") menuclick = "Closed";
    slidableController = SlidableController(
      onSlideAnimationChanged: slideAnimationChanged,
      onSlideIsOpenChanged: slideIsOpenChanged,
    );
    _executionContextDTO =
        await ExecutionContextProvider().getExecutionContext();
    maintainanceLookupsAndRulesRepository =
        MaintainanceLookupsAndRulesBL(_executionContextDTO!);
    jobstatusList = await maintainanceLookupsAndRulesRepository!.getJobStatus();
    userDTOList = await UserContainerListBL(_executionContextDTO)
        .getUserContainerDTOList();
    Map<CheckListDetailSearchParameter, dynamic> checkListDetailssearchParams =
        {
      CheckListDetailSearchParameter.SITEID: _executionContextDTO!.siteId,
      CheckListDetailSearchParameter.ISACTIVE: 1,
      CheckListDetailSearchParameter.STATUS: menuclick != null
          ? await maintainanceLookupsAndRulesRepository
              ?.getJobStatusId(menuclick)
          : taskgroupid == -1
              ? await maintainanceLookupsAndRulesRepository
                  ?.getJobStatusId('Closed')
              : null,
      CheckListDetailSearchParameter.ASSIGNEDTO: _executionContextDTO?.loginId,
      CheckListDetailSearchParameter.ASSIGNEDUSERID:
          _executionContextDTO?.userPKId,
      CheckListDetailSearchParameter.JOBTYPE:
          await maintainanceLookupsAndRulesRepository?.getJobTypeId("Job"),
      CheckListDetailSearchParameter.SCHEDULEFROMDATE:
          dateTime != null ? DateFormat("yyyy-MM-dd").format(dateTime!) : null,
      CheckListDetailSearchParameter.SCHEDULETODATE: dateTime != null
          ? DateFormat("yyyy-MM-dd")
              .format(dateTime!.add(const Duration(days: 1)))
          : null,
      CheckListDetailSearchParameter.ACTIVITYTYPE: "MAINTENANCEJOBDETAILS",
    };
    CheckListDetailsListBL checkListDetailsListRepository =
        CheckListDetailsListBL(_executionContextDTO!);
    if (taskgroupid != null) {
      maintainenceservicedto = await checkListDetailsListRepository
          .getCheckListDetailDTOListByTaskGroupId(
              checkListDetailssearchParams, taskgroupid);
    } else {
      maintainenceservicedto = await checkListDetailsListRepository
          .getCheckListDetailsDTOList(checkListDetailssearchParams);
    }
    stateupdate.updateData(true);
    notifyListeners();
  }

  String? getJobStatusName(int? statusId) {
    var index =
        jobstatusList.where((element) => element.lookupValueId == statusId);

    if (index.isNotEmpty) {
      return index.first.lookupValue;
    }
    return null;
  }

  String? getUserNamebyId(int userId) {
    var index = userDTOList?.where((element) => element.userId == userId);

    if (index!.isNotEmpty) {
      return index.first.userName;
    }
    return null;
  }

  void slideAnimationChanged(Animation<double>? slideAnimation) {
    notifyListeners();
  }

  void slideIsOpenChanged(bool? isOpen) {
    notifyListeners();
  }

  void updatetabindex(int value) {
    menuclick = menulist[value];
    init();
  }

  Future<void> showFilter(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.mapToIdealWidth(context)),
        topRight: Radius.circular(30.mapToIdealWidth(context)),
      )),
      builder: (context) {
        return TaskModalSheet(
          menuclick: menuclick,
          callback: (value) async {
            getJobUsingSearchFilter(value);
          },
        );
      },
    );
  }

  Future<void> showMarkasCheckedModalsheet(
      CheckListDetailDTO maintainenceservicedto) async {
    statusTextField.setInitialValue("Closed");
    await showModalBottomSheet(
      context: context!,
      isScrollControlled: false,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.mapToIdealWidth(context!)),
        topRight: Radius.circular(30.mapToIdealWidth(context!)),
      )),
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: const SemnoxText.subtitle(
                      text: 'Mark as Checked',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 5,
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      maintainenceservicedto.remarksMandatory == false
                          ? Container()
                          : SemnoxTextFormField(
                              position: LabelPosition.top,
                              properties: remarksField),
                      UIHelper.verticalSpaceMedium(),
                      SemnoxTextFormField(
                          enabled: false,
                          position: LabelPosition.top,
                          properties: statusTextField),
                      UIHelper.verticalSpaceMedium(),
                      Row(
                        children: [
                          Expanded(
                            child: SemnoxPopUpTwoButtons(
                              outlineButtonText: Messages.cancelButton,
                              filledButtonText: Messages.saveButton,
                              onFilledButtonPressed: () async {
                                await updateStatusAsChecked(
                                    maintainenceservicedto);
                              },
                              onOutlineButtonPressed: () {
                                Modular.to.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<int> updateStatusAsChecked(
      CheckListDetailDTO checkListDetailDTO) async {
    checkListDetailDTO.status =
        await maintainanceLookupsAndRulesRepository?.getJobStatusId("Closed");

    int? status = await updateTask(checkListDetailDTO);
    if (status! > 0) {
      Utils()
          .showSemnoxDialog(context!, "Job Details Saved Successfully")
          .then((exit) {
        if (exit == null) return;
        if (exit) {
          Modular.to.pop(context);
        }
      });
    }
    return status;
  }

  Future<int?> updateTask(CheckListDetailDTO checkListDetailDTO) async {
    try {
      CheckListDetailsBL checkListDetailsBL =
          CheckListDetailsBL.dto(_executionContextDTO!, checkListDetailDTO);
      int status = await checkListDetailsBL.updateCheckListDTO(context!);
      return status;
    } catch (e) {
      Utils().showSemnoxDialog(context!, e.toString());
    }
    return null;
  }

  getJobUsingSearchFilter(TaskFilterViewmodel viewModel) async {
    try {
      Map<CheckListDetailSearchParameter, dynamic>
          jobDetailsFilterSearchParams = {
        CheckListDetailSearchParameter.SITEID: _executionContextDTO!.siteId,
        CheckListDetailSearchParameter.ISACTIVE: 1,
        CheckListDetailSearchParameter.JOBTYPE:
            await maintainanceLookupsAndRulesRepository?.getJobTypeId("Job"),
        CheckListDetailSearchParameter.STATUS: await viewModel
            .maintainanceLookupsAndRulesRepository
            ?.getJobStatusId(viewModel.menuClick),
        CheckListDetailSearchParameter.ASSETID:
            viewModel.assetField.value?.assetId,
        CheckListDetailSearchParameter.ASSIGNEDUSERID:
            viewModel.assigneduserField.value?.userId,
        CheckListDetailSearchParameter.SCHEDULEFROMDATE:
            viewModel.jobPastDueDate == false
                ? viewModel.scheduleFromField.value != null
                    ? DateFormat("yyyy-MM-dd")
                        .format(viewModel.scheduleFromField.value!)
                    : DateFormat("yyyy-MM-dd").format(DateTime.now())
                : null,
        CheckListDetailSearchParameter.SCHEDULETODATE:
            viewModel.jobPastDueDate == false
                ? viewModel.scheduleToField.value != null
                    ? DateFormat("yyyy-MM-dd").format(
                        viewModel
                            .scheduleToField.value!
                            .add(const Duration(days: 1)))
                    : DateFormat("yyyy-MM-dd")
                        .format(DateTime.now().add(const Duration(days: 1)))
                : null,
        CheckListDetailSearchParameter.ACTIVITYTYPE: "MAINTENANCEJOBDETAILS",
        CheckListDetailSearchParameter.JOBSPASTDUEDATE: viewModel.jobPastDueDate
      };
      CheckListDetailsListBL checkListDetailsListRepository =
          CheckListDetailsListBL(_executionContextDTO!);
      maintainenceservicedto = await checkListDetailsListRepository
          .getCheckListDetailsDTOList(jobDetailsFilterSearchParams);
      notifyListeners();
      Navigator.of(context!).pop();
    } on Exception catch (exception) {
      Utils().showSemnoxDialog(context!, exception.toString());
    } catch (error) {
      Utils().showSemnoxDialog(context!, error.toString());
    }
  }

  void navigatetotaskdetail(
      CheckListDetailDTO checkListDetailDTO, String? menuclick) {
    Modular.to
        .pushNamed("./${HomeModule.taskdetails}",
            arguments: TaskDetailData(
                menuClick: menuclick, checkListDetailDTO: checkListDetailDTO))
        .then((value) => init());
  }

  void search(String value) {
    searchQuery = value;
    notifyListeners();
  }

  bool? swipeenabled(String? lookupValue) {
    if (lookupValue == 'CLOSED' ||
        lookupValue == 'Closed' ||
        lookupValue == 'RESOLVED' ||
        lookupValue == 'Resolved') {
      return false;
    }
    return true;
  }
}
