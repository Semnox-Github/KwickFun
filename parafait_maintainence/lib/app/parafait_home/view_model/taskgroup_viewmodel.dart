import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:parafait_maintainence/app/lookupRules/MaintainanceLookupsAndRulesBL.dart';
import 'package:parafait_maintainence/app/parafait_home/route/module.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/streams.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/maintenance/task_group/bl/task_group_BL.dart';
import 'package:semnox_core/modules/maintenance/task_group/model/taskgroupsummary_dto.dart';
import 'package:semnox_core/utils/dataprovider/data_provider.dart';
import 'package:semnox_core/utils/dataprovider/data_state.dart';

class TaskGroupViewModel extends ChangeNotifier {
  static final provider =
      ChangeNotifierProvider.autoDispose<TaskGroupViewModel>(
    (ref) {
      return TaskGroupViewModel();
    },
  );
  ExecutionContextDTO? _executionContext;
  final DataProvider<bool> stateupdate = DataProvider<bool>(initial: false);
  ValueStream<DataState<bool>> get loadstates => stateupdate.dataStream;
  MaintainanceLookupsAndRulesBL? maintainanceLookupsAndRulesRepository;
  final StreamController<List<TaskGroupViewSummaryDTO>?>
      _taskgroupsummaryController = StreamController();
  Stream<List<TaskGroupViewSummaryDTO>?> get taskgroupsummaryController =>
      _taskgroupsummaryController.stream;

  TaskGroupViewModel() {
    getTaskSummary();
  }

  Future<void> getTaskSummary() async {
    _executionContext = await ExecutionContextProvider().getExecutionContext();
    maintainanceLookupsAndRulesRepository =
        MaintainanceLookupsAndRulesBL(_executionContext!);
    TaskGroupsListBL taskGroupsListRepository =
        TaskGroupsListBL(_executionContext!);
    Map<TaskGroupSummaryDTOSearchParameter, dynamic> taskGroupSearchParams = {
      TaskGroupSummaryDTOSearchParameter.SITE_ID: _executionContext?.siteId,
      TaskGroupSummaryDTOSearchParameter.ISACTIVE: 1,
      TaskGroupSummaryDTOSearchParameter.STATUS:
          await MaintainanceLookupsAndRulesBL(_executionContext!)
              .getTaskClosedStatusId(),
      TaskGroupSummaryDTOSearchParameter.CHKLSTSCHEDULETIME:
          DateFormat("yyyy-MM-dd").format(DateTime.now()),
      TaskGroupSummaryDTOSearchParameter.ASSIGNEDUSERID:
          _executionContext?.userPKId,
      TaskGroupSummaryDTOSearchParameter.MAINTJOBTYPE:
          await maintainanceLookupsAndRulesRepository?.getJobTypeId("Job"),
    };
    Timer.periodic(const Duration(seconds: 10), (timer) async {
      _taskgroupsummaryController.sink.add((await taskGroupsListRepository
          .getTaskgroupSummaryFromLocalDB(taskGroupSearchParams)));
    });
  }

  Future<void> navigatetopendinglayout([int? taskgroupId]) async {
    Modular.to.pushNamed("./${HomeModule.pendingactionlayout}",
        arguments: taskgroupId);
  }

  @override
  void dispose() {
    // _taskgroupsummaryController.close();
    super.dispose();
  }
}
