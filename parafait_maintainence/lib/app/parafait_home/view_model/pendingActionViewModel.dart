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

class PendingActionViewModel extends ChangeNotifier {
  static final provider =
      ChangeNotifierProvider.autoDispose<PendingActionViewModel>((ref) {
    return PendingActionViewModel();
  });

  ExecutionContextDTO? _executionContext;
  final StreamController<ActionCount?> _streamController = StreamController();
  Stream<ActionCount?> get streamController => _streamController.stream;
  Stream<ActionCount?> get pendingController => _streamController.stream;

  DateTime? dateTime;
  int? taskgroupid, taskClosedStatusId, srClosedStatusId;
  Color? color;
  MaintainanceLookupsAndRulesBL? maintainanceLookupsAndRulesRepository;

  PendingActionViewModel() {
    getPendingCount();
  }

  Future<void> getPendingCount() async {
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
          : DateFormat("yyyy-MM-dd").format(DateTime.now())
    };

    taskClosedStatusId = await MaintainanceLookupsAndRulesBL(_executionContext!)
        .getTaskClosedStatusId();

    srClosedStatusId = await MaintainanceLookupsAndRulesBL(_executionContext!)
        .getserviceClosedStatusId();

    Timer.periodic(const Duration(seconds: 10), (timer) async {
      _streamController.sink.add(await checkListDetailsListBL.getactionitem(
          checkListDetailssearchParams, taskClosedStatusId, srClosedStatusId));
    });
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
