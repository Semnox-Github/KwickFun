import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:parafait_maintainence/app/parafait_home/view/maint_taskgroup_panel_widget.dart';
import 'package:parafait_maintainence/app/parafait_home/view/pendingaction_panel_widget.dart';
import 'package:parafait_maintainence/app/widget/layout/maint_service_panel_widget.dart';
import 'package:parafait_maintainence/app/widget/layout/maint_task_panel_widget.dart';
import 'package:parafait_maintainence/app/widget/layout/sync_panel_widget.dart';
import 'package:parafait_maintainence/routes.dart';
import 'package:parafait_maintainence/themes.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/hr/provider/userrole_data_provider.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/maintainence_service_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/repositories/dbhandler/purge_dbhandler.dart';
import 'package:semnox_core/modules/messages/provider/translation_provider.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/widgets/elements/connection_status_indicator.dart';

Widget builderactionbar(BuildContext context) {
  return FittedBox(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Modular.to.pushNamedAndRemoveUntil(AppRoutes.home, (p0) => false);
            },
            child: const SizedBox(
              width: 35.0,
              child: Icon(Icons.refresh),
            ),
          ),
        ),
        const ConnectionStatusIndicator(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PopupMenuButton(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            offset: const Offset(0, kToolbarHeight),
            elevation: 20,
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            padding: EdgeInsets.all(
              12.mapToIdealWidth(context),
            ),
            iconSize: 32.mapToIdealWidth(context),
            onSelected: (dynamic value) async {
              switch (value) {
                case 0:
                  checkusermanagerAccess(AppRoutes.appsetting);
                  break;
                case 1:
                  purgeJobDetails(context: context);
                  break;
                case 2:
                  await ExecutionContextProvider().updateSession(
                      isSystemUserLogined: true,
                      isSiteLogined: true,
                      isUserLogined: false);
                  Modular.to.navigate(AppRoutes.loginPage);
                  break;
              }
            },
            itemBuilder: (context) => <PopupMenuItem<int>>[
              PopupMenuItem(
                value: 0,
                child: SemnoxText.bodyMed1(
                  text: TranslationProvider.getTranslationBykey(
                      Messages.settings),
                  style: (AppThemes.names[DynamicTheme.of(context)?.themeId] !=
                          "Light"
                      ? const TextStyle(color: Colors.white)
                      : const TextStyle(color: Colors.black)),
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: SemnoxText.bodyMed1(
                  text: TranslationProvider.getTranslationBykey(
                      Messages.purgeJobDetails),
                  style: (AppThemes.names[DynamicTheme.of(context)?.themeId] !=
                          "Light"
                      ? const TextStyle(color: Colors.white)
                      : const TextStyle(color: Colors.black)),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: SemnoxText.bodyMed1(
                  text:
                      TranslationProvider.getTranslationBykey(Messages.logout),
                  style: (AppThemes.names[DynamicTheme.of(context)?.themeId] !=
                          "Light"
                      ? const TextStyle(color: Colors.white)
                      : const TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

void purgeJobDetails({BuildContext? context}) async {
  var executionContextDTO =
      await ExecutionContextProvider().getExecutionContext();
  Map<CheckListDetailSearchParameter, dynamic> checkListDetailssearchParams = {
    CheckListDetailSearchParameter.SITEID: executionContextDTO?.siteId,
    CheckListDetailSearchParameter.SERVERSYNC: 1,
  };
  int result = await PurgeDbHandler(executionContextDTO!)
      .purgeJobDetails(checkListDetailssearchParams);
  if (result != -1) {
    SemnoxSnackbar.success("Purge job Successful", context!,
        title: Messages.purgeJobSuccess);
  } else {
    SemnoxSnackbar.error(context!, Messages.canNotPurge);
  }
}

Future<void> checkusermanagerAccess(String route) async {
  var userroleDTO = UserRoleDataProvider.getuserroleDTO();
  if (userroleDTO.isNotEmpty) {
    if (userroleDTO.first.manager == true) {
      // print('userroleDTO.first.managerFlag3 == "Y"');
      Modular.to.pushNamed(route);
    } else {
      Modular.to.pushNamed(AppRoutes.home);
    }
  } else {
    Modular.to.pushNamed(AppRoutes.home);
  }
}

Widget builderhomepage(BuildContext context, [String? message]) {
  return SingleChildScrollView(
    child: Column(
      children: [
        SizedBox(
          height: 10.mapToIdealHeight(context),
        ),
        message != null
            ? Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SemnoxText.subtitle(
                          textScaleFactor: 0.6,
                          text: Messages.hello,
                          style: TextStyle(color: Colors.white),
                        ),
                        message.isNotEmpty
                            ? Row(
                                children: [
                                  SemnoxText.h4(
                                    textScaleFactor: 0.6,
                                    text: message.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              )
                            : Container()
                      ],
                    ),
                  ],
                ),
              )
            : Container(),
        SizedBox(
          height: 20.mapToIdealHeight(context),
        ),
        const SyncLayout(),
        PendingActionLayout(),
        builderhomeclipper(context),
      ],
    ),
  );
}

ClipPath builderhomeclipper(BuildContext context) {
  return ClipPath(
    clipper: MyClipper(),
    child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: SemnoxConstantColor.scaffoldBackground(context), //Colors.white,
      ),
      child: Expanded(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 750.0.mapToIdealWidth(context),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 140.mapToIdealHeight(context),
                      ),
                      const TaskGroupLayout(),
                      TaskPanel(),
                      const Divider(),
                      MaintServicePanel(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
