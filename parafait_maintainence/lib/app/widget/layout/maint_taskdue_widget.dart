import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/tasks/view_model/tasks_viewmodel.dart';
import 'package:parafait_maintainence/app/widget/layout/maint_task_listview_widget.dart';

class TaskDueWidget extends ConsumerWidget {
  DateTime? dateTime;
  int? changeContents;
  int? taskgroupid;

  TaskDueWidget(
      {Key? key,
      required this.dateTime,
      required this.changeContents,
      this.taskgroupid})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(TasksViewModel.provider(
        TabData(dateTime: dateTime, taskgroupid: taskgroupid)));
    viewModel.context = context;
    return TaskListView(
      viewModel: viewModel,
    );
  }
}
