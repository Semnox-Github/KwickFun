import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:parafait_maintainence/app/parafait_home/view/parafait_homescreen.dart';
import 'package:parafait_maintainence/app/pendingActionItem/view/maint_service_pendingaction_tab_widget.dart';
import 'package:parafait_maintainence/app/service_request/view/service_request_create.dart';
import 'package:parafait_maintainence/app/service_request/view/service_request_tab.dart';
import 'package:parafait_maintainence/app/service_request/view/service_request_details_screen.dart';
import 'package:parafait_maintainence/app/sync/view/syncScreenWidget.dart';
import 'package:parafait_maintainence/app/tasks/view/task_details.dart';
import 'package:parafait_maintainence/app/tasks/view/task_tab.dart';

class HomeModule extends Module {
  static String srdetails = "srdetails";
  static String srtab = "srtab";
  static String srcreate = "srcreate";
  static String tasktab = "tasktab";
  static String taskdetails = "taskdetails";
  static String pendingactionlayout = "pendingactionlayout";
  static String syncdetails = "syncdetails";
  static String intialroute = "/";

  @override
  List<ModularRoute> get routes => [
        ChildRoute(intialroute,
            child: (context, args) => const ParafaitHomeScreen()),
        ChildRoute(
          "/$srdetails",
          transition: TransitionType.fadeIn,
          child: (BuildContext context, arguments) =>
              ServiceRequestDetailsScreen(data: arguments.data),
        ),
        ChildRoute(
          "/$srtab",
          transition: TransitionType.fadeIn,
          child: (BuildContext context, arguments) =>
              ServiceRequestTabWidget(menuclick: arguments.data),
        ),
        ChildRoute(
          "/$srcreate",
          transition: TransitionType.fadeIn,
          child: (BuildContext context, arguments) => CreateServiceRequest(),
        ),
        ChildRoute(
          "/$tasktab",
          transition: TransitionType.fadeIn,
          child: (BuildContext context, arguments) =>
              TaskTabWidget(menuclick: arguments.data),
        ),
        ChildRoute(
          "/$taskdetails",
          transition: TransitionType.fadeIn,
          child: (BuildContext context, arguments) =>
              TaskDetails(data: arguments.data),
        ),
        ChildRoute(
          "/$pendingactionlayout",
          transition: TransitionType.fadeIn,
          child: (BuildContext context, arguments) =>
              PendingActionItems(taskgroupid: arguments.data),
        ),
        ChildRoute(
          "/$syncdetails",
          transition: TransitionType.fadeIn,
          child: (BuildContext context, arguments) =>
              SyncScreenWidget(arguments.data),
        ),
      ];
}
