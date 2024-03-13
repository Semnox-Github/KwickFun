import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/lookupRules/MaintainanceLookupsAndRulesBL.dart';
import 'package:parafait_maintainence/app/parafait_home/route/module.dart';
import 'package:parafait_maintainence/app/tasks/view_model/taskdetails_viewmodel.dart';
import 'package:rxdart/streams.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/hr/bl/user_container_bl.dart';
import 'package:semnox_core/modules/hr/model/user_container_dto.dart';
import 'package:semnox_core/modules/hr/model/users_dto.dart';
import 'package:semnox_core/modules/lookups/model/lookup_container_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/bl/assets_bl.dart';
import 'package:semnox_core/modules/maintenance/assets/model/asset_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/bl/maintainence_bl.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/maintainence_service_dto.dart';
import 'package:semnox_core/utils/dataprovider/data_provider.dart';
import 'package:semnox_core/utils/dataprovider/data_state.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:semnox_core/widgets/elements/text.dart';
import 'package:semnox_core/widgets/input_fields/date_field/properties.dart';
import 'package:semnox_core/widgets/input_fields/properties/dropdown_field_properties.dart';
import 'package:semnox_core/widgets/input_fields/properties/text_field_properties.dart';

class ServiceRequestDetailViewmodel extends ChangeNotifier {
  static final provider = ChangeNotifierProvider.autoDispose
      .family<ServiceRequestDetailViewmodel, TaskDetailData>(
    (ref, params) {
      return ServiceRequestDetailViewmodel(
          params.checkListDetailDTO, params.menuClick);
    },
  );

  // Variable initialize //
  ExecutionContextDTO? _executionContextDTO;
  CheckListDetailDTO? checkListDetailDTO;
  String? menuClick;

  final DataProvider<bool> stateupdate = DataProvider<bool>(initial: false);

  bool? setEnabled = false;
  ValueStream<DataState<bool>> get loadstates => stateupdate.dataStream;
  MaintainanceLookupsAndRulesBL? maintainanceLookupsAndRulesRepository;

  late List<LookupValuesContainerDtoList> statuslist,
      prioritylist,
      requestlist,
      jobTypelist = [];

  List<GenericAssetDTO>? assetsList = [];

  List<UserContainerDto>? userList = [];

  SemnoxDropdownProperties<LookupValuesContainerDtoList> statusField =
      SemnoxDropdownProperties<LookupValuesContainerDtoList>(items: []);

  // late StreamSubscription<LookupValuesContainerDtoList> _statussubscription;

  SemnoxDropdownProperties<LookupValuesContainerDtoList> priorityField =
      SemnoxDropdownProperties<LookupValuesContainerDtoList>(items: []);

  SemnoxDropdownProperties<LookupValuesContainerDtoList> requestField =
      SemnoxDropdownProperties<LookupValuesContainerDtoList>(items: []);

  SemnoxDropdownProperties<GenericAssetDTO> assetField =
      SemnoxDropdownProperties<GenericAssetDTO>(items: []);

  SemnoxDropdownProperties<UserContainerDto> assigneduserField =
      SemnoxDropdownProperties<UserContainerDto>(items: []);

  DateFieldProperties requestDateField =
      DateFieldProperties(initial: null, label: "Request Date", pickTime: true);

  DateFieldProperties scheduledatetimeField = DateFieldProperties(
      initial: null, label: "Schedule Date", pickTime: true);

  SemnoxTextFieldProperties requestTitleField =
      SemnoxTextFieldProperties(label: "Request Title *", validators: [
    (value) {
      if (value?.isEmpty ?? true) return "Request Title is required";
      return null;
    }
  ]);

  SemnoxTextFieldProperties requestDetailsField =
      SemnoxTextFieldProperties(label: "Request Details *", validators: [
    (value) {
      if (value?.isEmpty ?? true) return "Request Details is required";
      return null;
    }
  ]);

  SemnoxTextFieldProperties requestNoField =
      SemnoxTextFieldProperties(label: "Request Number");

  SemnoxTextFieldProperties gamenameField =
      SemnoxTextFieldProperties(label: "Game Name");

  SemnoxTextFieldProperties contactPersonField =
      SemnoxTextFieldProperties(label: "Contact Person *", validators: [
    (value) {
      if (value?.isEmpty ?? true) return "Contact Person is required";
      return null;
    }
  ]);

  SemnoxTextFieldProperties phoneField = SemnoxTextFieldProperties(
      label: "Phone",
      inputType: TextInputType.number,
      validators: [
        (value) {
          if (value?.isEmpty ?? true) return "Phone is required";
          return null;
        }
      ]);

  SemnoxTextFieldProperties emailField =
      SemnoxTextFieldProperties(label: "Email");

  bool isVisible = false;

  SemnoxTextFieldProperties resolutionField =
      SemnoxTextFieldProperties(label: "Resolution Details");

  SemnoxTextFieldProperties repaircostField =
      SemnoxTextFieldProperties(label: "Repair Cost");

  late BuildContext context;

  final formKey = GlobalKey<FormState>();

  ServiceRequestDetailViewmodel(this.checkListDetailDTO, this.menuClick) {
    init();
  }

  void init() async {
    stateupdate.startLoading();
    setEnabled = checkListDetailDTO?.status != null
        ? await Utils().operationMatrix(checkListDetailDTO?.status!)
        : false;
    gamenameField.setInitialValue("Game Name");
    _executionContextDTO =
        await ExecutionContextProvider().getExecutionContext();
    maintainanceLookupsAndRulesRepository =
        MaintainanceLookupsAndRulesBL(_executionContextDTO!);
    jobTypelist = (await maintainanceLookupsAndRulesRepository?.getJobType())!;
    await semnoxdropdown();
    await semnoxtextfield();
    await semnoxdatetimefield();
    stateupdate.updateData(true);
    notifyListeners();
  }

  bool? updateresolutionview() {
    isVisible = !isVisible;
    notifyListeners();
    return isVisible;
  }

  void resolvesr() async {
    checkListDetailDTO!.status =
        await maintainanceLookupsAndRulesRepository?.getresolvedId();
    updateservicerequest();
  }

  Future<void> createServiceRequest(BuildContext context) async {
    checkListDetailDTO ??= CheckListDetailDTO();
    checkListDetailDTO?.maintJobName =
        checkListDetailDTO?.maintJobName ?? requestTitleField.value;
    checkListDetailDTO?.maintJobType =
        await maintainanceLookupsAndRulesRepository
            ?.getJobTypeId("Service Request");

    checkListDetailDTO?.chklstScheduleTime = scheduledatetimeField.value;
    checkListDetailDTO?.status = statusField.value?.lookupValueId;
    checkListDetailDTO?.assetId = assetField.value?.assetId;
    checkListDetailDTO?.assetName = assetField.value?.name;
    checkListDetailDTO?.requestType = requestField.value?.lookupValueId;
    checkListDetailDTO?.requestDetail = requestDetailsField.value;
    checkListDetailDTO?.priority = priorityField.value?.lookupValueId;
    checkListDetailDTO?.contactPhone = phoneField.value;
    checkListDetailDTO?.contactEmailId = emailField.value;
    checkListDetailDTO?.assignedTo = assigneduserField.value?.userName;
    checkListDetailDTO?.assignedUserId = _executionContextDTO?.userPKId;
    checkListDetailDTO?.repairCost = double.tryParse(repaircostField.value);
    checkListDetailDTO?.resolution = resolutionField.value;
    checkListDetailDTO?.requestedBy = _executionContextDTO?.loginId;
    checkListDetailDTO?.siteid = _executionContextDTO?.siteId;
    checkListDetailDTO?.isChanged = true;
    checkListDetailDTO?.serverSync = false;
    bool result = await updateservicerequest();
    if (result == true) {
      // ignore: use_build_context_synchronously
      Modular.to.pop(context);
    }
  }

  void saveServiceRequestDetails(BuildContext context) async {
    // if (statusField.value?.lookupValue == "DRAFT" ||
    //     statusField.value?.lookupValue == "ABANDONED") {
    //   if (requestTitleField.value.toString().isEmpty) {
    //     Utils().showSemnoxDialog(
    //         context, "Request title field is mandatory, please fill it.");
    //     return;
    //   }
    //   if (requestDetailsField.value.isEmpty) {
    //     Utils().showSemnoxDialog(
    //         context, "Request details field is mandatory, please fill it.");
    //     return;
    //   }
    //   if (contactPersonField.value.isEmpty) {
    //     Utils().showSemnoxDialog(
    //         context, "Contact person field is mandatory, please fill it.");
    //     return;
    //   }
    // }
    checkListDetailDTO ??= CheckListDetailDTO();
    checkListDetailDTO?.maintJobType =
        await maintainanceLookupsAndRulesRepository
            ?.getJobTypeId("Service Request");
    if (statusField.value?.lookupValue == "DRAFT") {
      checkListDetailDTO?.status =
          await maintainanceLookupsAndRulesRepository?.getserviceOpenStatusId();
    } else {
      checkListDetailDTO?.status = statusField.value?.lookupValueId;
    }
    checkListDetailDTO?.assetId = assetField.value?.assetId;
    checkListDetailDTO?.assetName = assetField.value?.name;
    checkListDetailDTO?.requestType = requestField.value?.lookupValueId;
    checkListDetailDTO?.requestDetail = requestDetailsField.value;
    checkListDetailDTO?.priority = priorityField.value?.lookupValueId;
    checkListDetailDTO?.contactPhone = phoneField.value;
    checkListDetailDTO?.contactEmailId = emailField.value;
    checkListDetailDTO?.assignedTo = assigneduserField.value?.userName;
    checkListDetailDTO?.repairCost = double.tryParse(repaircostField.value);
    checkListDetailDTO?.resolution = resolutionField.value;
    checkListDetailDTO?.requestedBy = _executionContextDTO?.loginId;
    checkListDetailDTO?.siteid = _executionContextDTO?.siteId;
    checkListDetailDTO?.isChanged = true;
    checkListDetailDTO?.serverSync = false;
    bool result = await updateservicerequest();
    if (result == true) {
      // ignore: use_build_context_synchronously
      Modular.to.pop(context);
    }
  }

  updateservicerequest() async {
    try {
      CheckListDetailsBL checkListDetailsRepository =
          CheckListDetailsBL.dto(_executionContextDTO!, checkListDetailDTO!);
      int status = await checkListDetailsRepository.updateCheckListDTO(context);
      if (status > 0) {
        await checkListDetailsRepository
            .saveRecentCheckListDTO(checkListDetailDTO);
        // ignore: use_build_context_synchronously
        Utils()
            .showSemnoxDialog(context, "Service Request Saved Successfully")
            .then((value) async {
          if (value!) {
            if (menuClick == 'Open') {
              if ((statusField.value?.lookupValue == 'OPEN' ||
                  statusField.value?.lookupValue == 'RESCHEDULE_NEXT_VISIT' ||
                  statusField.value?.lookupValue == 'UNDER_CHECKING' ||
                  statusField.value?.lookupValue == 'UNDER_PROGRESS' ||
                  statusField.value?.lookupValue == 'WAITING_FOR_SPARE')) {
                Modular.to.pushNamed(HomeModule.srtab, arguments: "Open");
              } else {
                Modular.to.pushNamed(HomeModule.srtab, arguments: "Resolved");
              }
            } else if (menuClick == 'Resolved') {
              if ((statusField.value?.lookupValue == 'REOPEN')) {
                Modular.to.pushNamed(HomeModule.srtab, arguments: "Open");
              } else {
                Modular.to.pushNamed(HomeModule.srtab, arguments: "Resolved");
              }
            } else if (menuClick == 'Draft') {
              Modular.to.pushNamed(HomeModule.srtab, arguments: "Draft");
            } else if (menuClick == 'Recent') {
              Modular.to.pushNamed(HomeModule.srtab, arguments: "Recent");
            } else {
              Modular.to.pop(context);
            }
          }
        });
      }
    } on Exception catch (e) {
      Utils().showSemnoxDialog(context, e.toString());
    } catch (error) {
      Utils().showSemnoxDialog(context, error.toString());
    }
  }

  semnoxdropdown() async {
    if (menuClick == 'Open') {
      statuslist = (await maintainanceLookupsAndRulesRepository?.getOpentab())!;
    } else if (menuClick == "Resolved") {
      statuslist =
          (await maintainanceLookupsAndRulesRepository?.getResolvedtab())!;
    } else if (menuClick == "Draft") {
      statuslist =
          (await maintainanceLookupsAndRulesRepository?.getDrafttab())!;
    } else {
      statuslist = (await maintainanceLookupsAndRulesRepository
          ?.getservicerequeststatus(menuClick))!;
    }

    statusField = SemnoxDropdownProperties<LookupValuesContainerDtoList>(
        label: "Status",
        items: statuslist
            .map((e) => DropdownMenuItem<LookupValuesContainerDtoList>(
                value: e, child: SemnoxText(text: "${e.lookupValue}")))
            .toList(),
        enabled: true,
        validators: [
          (data) {
            if (data == null) {
              return "Select Any Status";
            }
            return null;
          }
        ]);
    if (statuslist.isNotEmpty) {
      final initial = checkListDetailDTO != null
          ? statuslist.firstWhereOrNull(
              (element) => checkListDetailDTO?.status == element.lookupValueId)
          : statuslist.first;
      statusField.setInitialValue(initial ?? statuslist.first);
    }

    // _statussubscription = statusField.valueChangeStream.listen((event) async {
    //   statusField.onChange(event);
    // });

    checkFieldSetEnabed();

    prioritylist =
        (await maintainanceLookupsAndRulesRepository?.getJobPriority())!;

    priorityField = SemnoxDropdownProperties<LookupValuesContainerDtoList>(
        label: "Priority",
        items: prioritylist
            .map((e) => DropdownMenuItem<LookupValuesContainerDtoList>(
                value: e, child: SemnoxText(text: "${e.lookupValue}")))
            .toList(),
        enabled: true,
        validators: [
          (data) {
            if (data == null) {
              return "Select Any Priority";
            }
            return null;
          }
        ]);
    if (prioritylist.isNotEmpty) {
      final initial = checkListDetailDTO != null
          ? prioritylist.firstWhereOrNull((element) =>
              checkListDetailDTO?.priority == element.lookupValueId)
          : prioritylist.first;
      priorityField.setInitialValue(initial ?? prioritylist.first);
    }

    requestlist =
        (await maintainanceLookupsAndRulesRepository?.getRequestType())!;

    requestField = SemnoxDropdownProperties<LookupValuesContainerDtoList>(
        label: "Request Type",
        items: requestlist
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
    if (requestlist.isNotEmpty) {
      final initial = checkListDetailDTO != null
          ? requestlist.firstWhereOrNull((element) =>
              checkListDetailDTO?.requestType == element.lookupValueId)
          : requestlist.first;
      requestField.setInitialValue(initial ?? requestlist.first);
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
      final initial = checkListDetailDTO != null
          ? assetsList?.firstWhereOrNull(
              (element) => checkListDetailDTO?.assetId == element.assetId)
          : assetsList!.first;
      assetField.setInitialValue(initial ?? assetsList!.first);
    }

    Map<UserDTOSearchParameter, dynamic> userparams = {
      UserDTOSearchParameter.isActive: true,
    };

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
      final initial = checkListDetailDTO != null
          ? userList?.firstWhereOrNull(
              (element) => checkListDetailDTO?.assignedUserId == element.userId)
          : userList!.first;
      assigneduserField.setInitialValue(initial ?? userList!.first);
    }
  }

  semnoxtextfield() {
    requestNoField.setInitialValue(checkListDetailDTO?.maintJobNumber ?? "");
    requestTitleField.setInitialValue(checkListDetailDTO?.maintJobName ?? "");
    emailField
        .setInitialValue(checkListDetailDTO?.contactEmailId.toString() ?? "");
    repaircostField
        .setInitialValue(checkListDetailDTO?.repairCost.toString() ?? "");
    phoneField
        .setInitialValue(checkListDetailDTO?.contactPhone.toString() ?? "");
    contactPersonField
        .setInitialValue(checkListDetailDTO?.requestedBy.toString() ?? "");
    repaircostField
        .setInitialValue(checkListDetailDTO?.repairCost.toString() ?? "");
    requestDetailsField
        .setInitialValue(checkListDetailDTO?.requestDetail.toString() ?? "");
    resolutionField
        .setInitialValue(checkListDetailDTO?.resolution.toString() ?? "");
  }

  semnoxdatetimefield() {
    requestDateField
        .setInitialValue(checkListDetailDTO?.requestDate ?? DateTime.now());
    scheduledatetimeField.setInitialValue(
        checkListDetailDTO?.chklstScheduleTime ?? DateTime.now());
  }

  void checkFieldSetEnabed() {
    if ((statusField.value?.lookupValue == 'Draft') ||
        (statusField.value?.lookupValue == 'DRAFT')) {
      setEnabled = true;
    }
  }
}
