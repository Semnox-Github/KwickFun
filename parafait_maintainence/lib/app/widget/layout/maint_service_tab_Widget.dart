import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/service_request/view_model/service_request_viewmodel.dart';
import 'package:parafait_maintainence/app/tasks/view_model/tasks_viewmodel.dart';
import 'package:parafait_maintainence/app/widget/layout/maint_service_listview_widget.dart';
import 'package:parafait_maintainence/app/widget/layout/miant_service_request_expandablewidget.dart';

class MaintainenceRequestWidget extends ConsumerWidget {
  final DateTime? dateTime;
  final int? changeContents;
  const MaintainenceRequestWidget({
    Key? key,
    required this.dateTime,
    required this.changeContents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref
        .watch(ServiceRequestViewModel.provider(TabData(dateTime: dateTime)));
    viewModel.context = context;
    if (changeContents == 1) {
      return ServiceRequestListView(
        viewModel: viewModel,
      );
    } else {
      return MaintServiceRequestExpandableView(
        viewModel: viewModel,
      );
    }
  }
}
