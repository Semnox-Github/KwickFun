import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/lookupRules/MaintainanceLookupsAndRulesBL.dart';
import 'package:parafait_maintainence/app/service_request/view_model/service_request_viewmodel.dart';
import 'package:rxdart/streams.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/lookups/model/lookup_container_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/dataprovider/data_provider.dart';
import 'package:semnox_core/utils/dataprovider/data_state.dart';
import 'package:semnox_core/widgets/input_fields/date_field/properties.dart';

class ServiceData {
  final String? menuclick;
  final ServiceRequestViewModel? viewmodel;

  ServiceData({this.menuclick, this.viewmodel});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ServiceData &&
        o.menuclick == menuclick &&
        o.viewmodel == viewmodel;
  }

  @override
  int get hashCode => menuclick.hashCode ^ viewmodel.hashCode;
}

class ServiceRequestFilterViewmodel extends ChangeNotifier {
  static final provider = ChangeNotifierProvider.autoDispose
      .family<ServiceRequestFilterViewmodel, ServiceData>((ref, params) {
    return ServiceRequestFilterViewmodel(
        ref, params.menuclick, params.viewmodel);
  });

  late List<LookupValuesContainerDtoList> statuslist,
      prioritylist,
      requestlist,
      jobTypelist = [];

  // SemnoxDropdownProperties<LookupValuesContainerDtoList> statusField =
  //     SemnoxDropdownProperties<LookupValuesContainerDtoList>(items: []);

  // SemnoxDropdownProperties<LookupValuesContainerDtoList> priorityField =
  //     SemnoxDropdownProperties<LookupValuesContainerDtoList>(items: []);

  SemnoxDropdownProperties<LookupValuesContainerDtoList> requestField =
      SemnoxDropdownProperties<LookupValuesContainerDtoList>(items: []);

  DateFieldProperties scheduleFromDateField =
      DateFieldProperties(label: "Schedule From Date", initial: null);

  DateFieldProperties scheduleToDateField =
      DateFieldProperties(label: "Schedule To Date", initial: null);

  ExecutionContextDTO? _executionContextDTO;
  String? menuClick;
  ServiceRequestViewModel? viewmodel;

  MaintainanceLookupsAndRulesBL? maintainanceLookupsAndRulesRepository;

  ServiceRequestFilterViewmodel(this.ref, this.menuClick, this.viewmodel) {
    init();
  }

  late Ref? ref;

  final DataProvider<bool> stateupdate = DataProvider<bool>(initial: false);
  ValueStream<DataState<bool>> get loadstates => stateupdate.dataStream;

  void init() async {
    stateupdate.startLoading();
    _executionContextDTO =
        await ExecutionContextProvider().getExecutionContext();

    scheduleFromDateField.setInitialValue(DateTime.now());
    scheduleToDateField.setInitialValue(DateTime.now());

    maintainanceLookupsAndRulesRepository =
        MaintainanceLookupsAndRulesBL(_executionContextDTO!);

    // statuslist = (await maintainanceLookupsAndRulesRepository!
    //     .getservicerequeststatus(menuClick))!;

    // statusField = SemnoxDropdownProperties<LookupValuesContainerDtoList>(
    //     label: "Status",
    //     items: statuslist
    //         .map((e) => DropdownMenuItem<LookupValuesContainerDtoList>(
    //             value: e, child: SemnoxText(text: "${e.lookupValue}")))
    //         .toList(),
    //     enabled: true,
    //     validators: [
    //       (data) {
    //         if (data == null) {
    //           return "Select Any Site";
    //         }
    //         return null;
    //       }
    //     ]);
    // if (statuslist.isNotEmpty) {
    //   statusField.setInitialValue(statuslist.first);
    // }
    // prioritylist =
    //     (await maintainanceLookupsAndRulesRepository?.getJobPriority())!;

    // priorityField = SemnoxDropdownProperties<LookupValuesContainerDtoList>(
    //     label: "Priority",
    //     items: prioritylist
    //         .map((e) => DropdownMenuItem<LookupValuesContainerDtoList>(
    //             value: e, child: SemnoxText(text: "${e.lookupValue}")))
    //         .toList(),
    //     enabled: true,
    //     validators: [
    //       (data) {
    //         if (data == null) {
    //           return "Select Any Priority";
    //         }
    //         return null;
    //       }
    //     ]);
    // if (prioritylist.isNotEmpty) {
    //   priorityField.setInitialValue(prioritylist.first);
    // }

    requestlist =
        (await maintainanceLookupsAndRulesRepository?.getRequestType())!;

    requestField = SemnoxDropdownProperties<LookupValuesContainerDtoList>(
        label: "Request",
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
      requestField.setInitialValue(requestlist.first);
    }

    stateupdate.updateData(true);
  }
}
