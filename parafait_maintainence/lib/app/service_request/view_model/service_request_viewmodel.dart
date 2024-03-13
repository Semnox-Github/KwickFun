import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:parafait_maintainence/app/lookupRules/MaintainanceLookupsAndRulesBL.dart';
import 'package:parafait_maintainence/app/parafait_home/route/module.dart';
import 'package:parafait_maintainence/app/service_request/view_model/service_request_detail_viewmodel.dart';
import 'package:parafait_maintainence/app/tasks/view_model/taskdetails_viewmodel.dart';
import 'package:parafait_maintainence/app/tasks/view_model/tasks_viewmodel.dart';
import 'package:parafait_maintainence/app/widget/elements/service_request_modalsheet.dart';
import 'package:parafait_maintainence/app/widget/layout/maint_service_resolution_widget.dart';
import 'package:parafait_maintainence/routes.dart';
import 'package:rxdart/streams.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/hr/bl/user_container_bl.dart';
import 'package:semnox_core/modules/hr/model/user_container_dto.dart';
import 'package:semnox_core/modules/lookups/model/lookup_container_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/bl/maintainence_bl.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/maintainence_service_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/dataprovider/data_provider.dart';
import 'package:semnox_core/utils/dataprovider/data_state.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:semnox_core/widgets/buttons/semnox_circle_loader.dart';
import 'package:semnox_core/widgets/input_fields/date_field/properties.dart';

class ServiceRequestViewModel extends ChangeNotifier {
  static final provider = ChangeNotifierProvider.autoDispose
      .family<ServiceRequestViewModel, TabData>(
    (ref, params) {
      return ServiceRequestViewModel(params.menuclick, params.dateTime);
    },
  );

  ExecutionContextDTO? _executionContextDTO;
  String? menuclick, searchQuery = "";
  DateTime? dateTime;
  List<CheckListDetailDTO>? maintainenceservicedto = [];
  late BuildContext? context;

  int tabIndex = 0;
  List<String> menulist = ['Recent', 'Open', 'Resolved', 'Draft'];

  SlidableController? slidableController;
  MaintainanceLookupsAndRulesBL? maintainanceLookupsAndRulesRepository;
  String? jobStatusName;

  List<LookupValuesContainerDtoList>? statusList = [],
      priorityList = [],
      requestlist = [];

  DataProvider<bool> stateupdate = DataProvider<bool>(initial: false);
  ValueStream<DataState<bool>> get loadstates => stateupdate.dataStream;

  List<UserContainerDto>? userDTOList = [];

  SemnoxDropdownProperties<LookupValuesContainerDtoList> statusField =
      SemnoxDropdownProperties<LookupValuesContainerDtoList>(items: []);

  SemnoxDropdownProperties<LookupValuesContainerDtoList> priorityField =
      SemnoxDropdownProperties<LookupValuesContainerDtoList>(items: []);

  late StreamSubscription<LookupValuesContainerDtoList> _statussubscription;
  late StreamSubscription<LookupValuesContainerDtoList> _prioritysubscription;

  SemnoxDropdownProperties<LookupValuesContainerDtoList> requestField =
      SemnoxDropdownProperties<LookupValuesContainerDtoList>(items: []);

  DateFieldProperties scheduleFromDateField =
      DateFieldProperties(label: "Schedule From Date");

  DateFieldProperties scheduleToDateField =
      DateFieldProperties(label: "Schedule To Date");

  ServiceRequestViewModel(
    this.menuclick,
    this.dateTime,
  ) {
    init();
  }

  void init() async {
    maintainenceservicedto = [];
    slidableController = SlidableController(
      onSlideAnimationChanged: slideAnimationChanged,
      onSlideIsOpenChanged: slideIsOpenChanged,
    );
    try {
      stateupdate.startLoading();
      if (menuclick != null) {
        tabIndex = menulist.indexOf(menuclick.toString());
      }

      _executionContextDTO =
          await ExecutionContextProvider().getExecutionContext();

      maintainanceLookupsAndRulesRepository =
          MaintainanceLookupsAndRulesBL(_executionContextDTO!);

      statusList = await maintainanceLookupsAndRulesRepository!
          .getservicerequeststatus(menuclick);

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
        statusField.setInitialValue(statusList!.first);
      }

      requestlist =
          (await maintainanceLookupsAndRulesRepository?.getRequestType())!;

      requestField = SemnoxDropdownProperties<LookupValuesContainerDtoList>(
          label: "Request",
          items: requestlist!
              .map((e) => DropdownMenuItem<LookupValuesContainerDtoList>(
                  value: e, child: SemnoxText(text: "${e.lookupValue}")))
              .toList(),
          enabled: true,
          validators: [
            (data) {
              if (data == null) {
                return "Select Any Request";
              }
              return null;
            }
          ]);
      if (requestlist!.isNotEmpty) {
        requestField.setInitialValue(requestlist!.first);
      }

      priorityList =
          await maintainanceLookupsAndRulesRepository!.getJobPriorityDropdown();

      priorityField = SemnoxDropdownProperties<LookupValuesContainerDtoList>(
          label: "Priority",
          items: priorityList!
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
      if (priorityList!.isNotEmpty) {
        priorityField.setInitialValue(priorityList!.first);
      }

      userDTOList = await UserContainerListBL(_executionContextDTO)
          .getUserContainerDTOList();

      Map<CheckListDetailSearchParameter, dynamic>
          checkListDetailssearchParams = {
        CheckListDetailSearchParameter.SITEID: _executionContextDTO!.siteId,
        CheckListDetailSearchParameter.ISACTIVE: 1,
        CheckListDetailSearchParameter.STATUS: statusField.value?.lookupValueId,
        // CheckListDetailSearchParameter.ASSIGNEDUSERID:
        //     menuclick != 'Draft' ? _executionContextDTO!.userPKId : null,
        CheckListDetailSearchParameter.ASSIGNEDUSERID:
            _executionContextDTO?.userPKId,
        CheckListDetailSearchParameter.JOBTYPE:
            await maintainanceLookupsAndRulesRepository
                ?.getJobTypeId("Service Request"),
        CheckListDetailSearchParameter.SCHEDULEFROMDATE: dateTime != null
            ? DateFormat("yyyy-MM-dd").format(dateTime!)
            : null,
        CheckListDetailSearchParameter.SCHEDULETODATE: dateTime != null
            ? DateFormat("yyyy-MM-dd")
                .format(dateTime!.add(const Duration(days: 1)))
            : null,
        CheckListDetailSearchParameter.ACTIVITYTYPE: "MAINTENANCEREQUESTS",
      };

      CheckListDetailsListBL checkListDetailsListRepository =
          CheckListDetailsListBL(_executionContextDTO!);

      if (menuclick == "Recent") {
        var dto = await checkListDetailsListRepository.getRecentCheckListDTO(
            checkListDetailssearchParams, context);

        maintainenceservicedto?.addAll(dto.where((item) => statusList!
            .where((item2) => item.status == item2.lookupValueId)
            .isNotEmpty));
      } else {
        var dto = await checkListDetailsListRepository
            .getCheckListDetailsDTOList(checkListDetailssearchParams);

        maintainenceservicedto?.addAll(dto!.where((item) => statusList!
            .where((item2) => item.status == item2.lookupValueId)
            .isNotEmpty));
      }

      _statussubscription = statusField.valueChangeStream.listen((event) async {
        statusField.setInitialValue(event);
        dropFilter();
      });
      _prioritysubscription =
          priorityField.valueChangeStream.listen((event) async {
        priorityField.setInitialValue(event);
        dropFilter();
      });
      stateupdate.updateData(true);
      notifyListeners();
    } on UnauthorizedException catch (e) {
      SemnoxSnackbar.error(context!, e.message.toString());
      await ExecutionContextProvider().clearExecutionContext();
      Modular.to.navigate(AppRoutes.loginPage);
    } catch (e) {
      SemnoxSnackbar.error(context!, e.toString());
      Modular.to.navigate(AppRoutes.loginPage);
    }
  }

  String? getStatusName(int? statusId) {
    var index =
        statusList?.where((element) => element.lookupValueId == statusId);

    if (index!.isNotEmpty) {
      return index.first.lookupValue;
    }
    return null;
  }

  bool? swipeenabled(String? lookupValue) {
    if (lookupValue == 'CLOSED' ||
        lookupValue == 'Closed' ||
        lookupValue == 'RESOLVED' ||
        lookupValue == 'Resolved' ||
        lookupValue == 'Draft' ||
        lookupValue == 'DRAFT') {
      return false;
    }
    return true;
  }

  String? getPriorityName(int? priorityId) {
    var index =
        priorityList?.where((element) => element.lookupValueId == priorityId);

    if (index!.isNotEmpty) {
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

  void navigateToServicedetailScreen(
      CheckListDetailDTO checkListDetailDTO, String? menuclick) {
    Modular.to.pushNamed("./${HomeModule.srdetails}",
        arguments: TaskDetailData(
            menuClick: menuclick, checkListDetailDTO: checkListDetailDTO));
  }

  void showFilter(
      BuildContext context, ServiceRequestViewModel viewmodel) async {
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
        return ServiceRequestModalSheet(
            srViewModel: viewmodel, menuclick: menuclick);
      },
    );
  }

  getServiceSearchFilter() async {
    try {
      maintainenceservicedto = [];
      Map<CheckListDetailSearchParameter, dynamic>
          jobDetailsFilterSearchParams = {
        CheckListDetailSearchParameter.SITEID: _executionContextDTO!.siteId,
        CheckListDetailSearchParameter.ISACTIVE: 1,
        CheckListDetailSearchParameter.STATUS: statusField.value?.lookupValueId,
        CheckListDetailSearchParameter.PRIORITY:
            priorityField.value?.lookupValueId,
        CheckListDetailSearchParameter.REQUESTTYPE:
            requestField.value?.lookupValueId,
        CheckListDetailSearchParameter.ASSIGNEDUSERID:
            _executionContextDTO?.userPKId,
        CheckListDetailSearchParameter.JOBTYPE:
            await maintainanceLookupsAndRulesRepository
                ?.getJobTypeId("Service Request"),
        CheckListDetailSearchParameter.SCHEDULEFROMDATE:
            scheduleFromDateField.value != null
                ? DateFormat("yyyy-MM-dd").format(scheduleFromDateField.value!)
                : DateFormat("yyyy-MM-dd").format(DateTime.now()),
        CheckListDetailSearchParameter.SCHEDULETODATE:
            scheduleToDateField.value != null
                ? DateFormat("yyyy-MM-dd").format(
                    scheduleToDateField.value!.add(const Duration(days: 1)))
                : DateFormat("yyyy-MM-dd")
                    .format(DateTime.now().add(const Duration(days: 1))),
        CheckListDetailSearchParameter.ACTIVITYTYPE: "MAINTENANCEREQUESTS",
      };

      CheckListDetailsListBL checkListDetailsListRepository =
          CheckListDetailsListBL(_executionContextDTO!);
      var dto = await checkListDetailsListRepository
          .getCheckListDetailsDTOList(jobDetailsFilterSearchParams);

      maintainenceservicedto?.addAll(dto!.where((item) => statusList!
          .where((item2) => item.status == item2.lookupValueId)
          .isNotEmpty));

      notifyListeners();

      Navigator.of(context!).pop();
    } on Exception catch (exception) {
      Utils().showSemnoxDialog(context!, exception.toString());
    } catch (error) {
      Utils().showSemnoxDialog(context!, error.toString());
    }
  }

  void search(String value) {
    searchQuery = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _statussubscription.cancel();
    _prioritysubscription.cancel();
    super.dispose();
  }

  Future<void> showMarkasResolvedModalsheet(
      CheckListDetailDTO maintainenceservicedto) async {
    showDialog(
        context: context!,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter mystate) {
            return AlertDialog(
              scrollable: true,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SemnoxText.subtitle(
                    text: "Resolution Details",
                    style: TextStyle(
                      color: Color.fromRGBO(238, 134, 100, 1),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigateToServicedetailScreen(
                          maintainenceservicedto, menuclick);
                      Modular.to.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              content: Consumer(builder: (context, ref, child) {
                final viewmodel = ref.watch(
                    ServiceRequestDetailViewmodel.provider(TaskDetailData(
                        checkListDetailDTO: maintainenceservicedto,
                        menuClick: menuclick)));
                viewmodel.context = context;
                return DataProviderBuilder<bool>(
                    enableAnimation: false,
                    dataProvider: viewmodel.loadstates,
                    loader: (context) {
                      return const Center(
                        child: SemnoxCircleLoader(
                          color: Colors.red,
                        ),
                      );
                    },
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: 300.0,
                        height: 400.0,
                        child: ResolutionWidget(
                          resolvemodulevisible: true,
                          onresolve: () {
                            return viewmodel.resolvesr();
                          },
                          viewModel: viewmodel,
                        ),
                      );
                    });
              }),
            );
          });
        });
  }

  void dropFilter() async {
    maintainenceservicedto = [];
    Map<CheckListDetailSearchParameter, dynamic> checkListDetailssearchParams =
        {
      CheckListDetailSearchParameter.SITEID: _executionContextDTO!.siteId,
      CheckListDetailSearchParameter.ISACTIVE: 1,
      CheckListDetailSearchParameter.STATUS: statusField.value?.lookupValueId,
      CheckListDetailSearchParameter.PRIORITY:
          priorityField.value?.lookupValueId,
      CheckListDetailSearchParameter.ASSIGNEDUSERID:
          _executionContextDTO!.userPKId,
      CheckListDetailSearchParameter.JOBTYPE:
          await maintainanceLookupsAndRulesRepository
              ?.getJobTypeId("Service Request"),
      CheckListDetailSearchParameter.SCHEDULEFROMDATE:
          dateTime != null ? DateFormat("yyyy-MM-dd").format(dateTime!) : null,
      CheckListDetailSearchParameter.SCHEDULETODATE: dateTime != null
          ? DateFormat("yyyy-MM-dd")
              .format(dateTime!.add(const Duration(days: 1)))
          : null,
      CheckListDetailSearchParameter.ACTIVITYTYPE: "MAINTENANCEREQUESTS",
    };

    CheckListDetailsListBL checkListDetailsListRepository =
        CheckListDetailsListBL(_executionContextDTO!);

    if (menuclick == "Recent") {
      var dto = await checkListDetailsListRepository.getRecentCheckListDTO(
          checkListDetailssearchParams, context);

      maintainenceservicedto?.addAll(dto.where((item) => statusList!
          .where((item2) => item.status == item2.lookupValueId)
          .isNotEmpty));
    } else {
      var dto = await checkListDetailsListRepository
          .getCheckListDetailsDTOList(checkListDetailssearchParams);

      maintainenceservicedto?.addAll(dto!.where((item) => statusList!
          .where((item2) => item.status == item2.lookupValueId)
          .isNotEmpty));
    }
    notifyListeners();
  }
}
