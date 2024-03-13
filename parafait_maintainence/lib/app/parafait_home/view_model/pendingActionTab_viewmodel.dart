import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/lookupRules/MaintainanceLookupsAndRulesBL.dart';
import 'package:parafait_maintainence/app/parafait_home/route/module.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/bl/maintainence_bl.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/maintainence_service_dto.dart';
import 'package:semnox_core/semnox_core.dart';

class PendingAction {
  DateTime? dateTime;
  int? taskgroupid, tabindex;

  PendingAction({this.dateTime, this.taskgroupid, this.tabindex});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PendingAction &&
        o.dateTime == dateTime &&
        o.taskgroupid == taskgroupid &&
        o.tabindex == tabindex;
  }

  @override
  int get hashCode =>
      dateTime.hashCode ^ taskgroupid.hashCode ^ tabindex.hashCode;
}

class PendingActionTabViewModel extends ChangeNotifier {
  static final provider = ChangeNotifierProvider.autoDispose
      .family<PendingActionTabViewModel, PendingAction>((ref, params) {
    return PendingActionTabViewModel(
        params.dateTime, params.taskgroupid, params.tabindex);
  });

  ExecutionContextDTO? _executionContext;
  // ActionCount? action;

  // final BehaviorSubject<ActionCount?> _action =
  //     BehaviorSubject.seeded(ActionCount(0, 0, 0));
  // ValueStream<ActionCount?> get action => _action.stream;

  final StreamController<ActionCount?> _streamController = StreamController();
  Stream<ActionCount?> get streamController => _streamController.stream;
  Stream<ActionCount?> get pendingController => _streamController.stream;

  DateTime? dateTime;
  int? taskgroupid, tabindex, taskClosedStatusId, srClosedStatusId;
  Color? color;

  // final DataProvider<bool> stateupdate = DataProvider<bool>(initial: false);
  // ValueStream<DataState<bool>> get loadstates => stateupdate.dataStream;
  MaintainanceLookupsAndRulesBL? maintainanceLookupsAndRulesRepository;

  PendingActionTabViewModel(this.dateTime, this.taskgroupid, this.tabindex) {
    getPendingCount();
  }

  // Stream<ActionCount?> getCount(Duration refreshTime) async* {
  //   Timer.periodic(Duration(seconds: 3), (timer) {
  //     getPendingCount();
  //   });
  //   // while (true) {
  //   //   await Future.delayed(refreshTime);
  //   //   yield await getPendingCount();
  //   // }
  // }

  Future<void> getPendingCount() async {
    // stateupdate.startLoading();
    _executionContext = await ExecutionContextProvider().getExecutionContext();
    maintainanceLookupsAndRulesRepository =
        MaintainanceLookupsAndRulesBL(_executionContext!);

    CheckListDetailsListBL checkListDetailsListBL =
        CheckListDetailsListBL(_executionContext!);
    Map<CheckListDetailSearchParameter, dynamic> checkListDetailssearchParams =
        {
      CheckListDetailSearchParameter.SITEID: _executionContext?.siteId,
      CheckListDetailSearchParameter.ISACTIVE: 1,
      CheckListDetailSearchParameter.ASSIGNEDUSERID:
          _executionContext?.userPKId,
      CheckListDetailSearchParameter.ChklstScheduleTime: dateTime != null
          ? DateFormat("yyyy-MM-dd").format(dateTime!)
          : DateFormat("yyyy-MM-dd").format(DateTime.now()),
      CheckListDetailSearchParameter.ACTIVITYTYPE:
          tabindex == 0 ? "MAINTENANCEJOBDETAILS" : "MAINTENANCEREQUESTS",
    };

    taskClosedStatusId = await MaintainanceLookupsAndRulesBL(_executionContext!)
        .getTaskClosedStatusId();

    srClosedStatusId = await MaintainanceLookupsAndRulesBL(_executionContext!)
        .getserviceClosedStatusId();

    // if (taskgroupid != null) {
    //   if (taskgroupid != -1) {
    //     _streamController.sink.add(
    //         await checkListDetailsListBL.getactionitem(
    //             checkListDetailssearchParams, taskClosedStatusId, srClosedStatusId,taskgroupid: taskgroupid));
    //   } else {
    //     _streamController.sink.add(
    //         await checkListDetailsListBL.getactionitem(
    //             checkListDetailssearchParams, taskClosedStatusId, srClosedStatusId,taskgroupid: taskgroupid));
    //   }
    // } else {
    //   _streamController.sink.add(await checkListDetailsListBL.getactionitem(
    //       checkListDetailssearchParams, taskClosedStatusId, srClosedStatusId));
    // }

    _streamController.sink.add(await checkListDetailsListBL.getactionitem(
        checkListDetailssearchParams, taskClosedStatusId, srClosedStatusId,
        taskgroupid: taskgroupid));
  }

  Future<void> navigatetopendinglayout() async {
    Modular.to
        .pushNamed("./${HomeModule.pendingactionlayout}", arguments: null);
  }

  @override
  void dispose() {
    // _streamController.close();
    super.dispose();
  }
}
