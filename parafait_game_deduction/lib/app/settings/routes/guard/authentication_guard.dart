import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_ride/app/parafait_login_authentication/view/app_login_form.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:semnox_core/modules/app_information/model/app_information_dto.dart';
import 'package:semnox_core/modules/authentication/model/authentication_response_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/hr/provider/userrole_data_provider.dart';
import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/widgets/semnox_widget/login_widget/view_model/login_user_form_view_model.dart';
import '../route.dart';

class AuthGuardState {
  bool isAuthenticated = true;
  void changeState(bool authState) {
    isAuthenticated = authState;
  }
}

class SettingsAuthGuard extends RouteGuard {
  SettingsAuthGuard(String redirectPath) : super(redirectTo: redirectPath);
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    await Modular.isModuleReady<SettingsModule>();
    AuthGuardState? authGuardState;
    try {
      authGuardState = Modular.get<AuthGuardState>(
          defaultValue: AuthGuardState()..changeState(false));
    } catch (e) {}
    if (authGuardState?.isAuthenticated ?? false) {
      return true;
    }
    final isAuthenticated = await Modular.to.push<bool>(
          MaterialPageRoute<bool>(
            builder: (context) => Consumer(builder: (context, ref, child) {
              return SemnoxScaffold(
                appBar: SemnoxAppBar(
                  title: SemnoxText(text: Messages.logintoconfirm),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      SemnoxText.h5(
                        text: Messages.accesssettings,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      AppLoginForm(
                        onAuthenticationComplete: (authenticateresponse,
                            networkConfigurationDTO,
                            appInformation,
                            languageId) async {
                          await checkuserIsManager(
                              authenticateresponse,
                              networkConfigurationDTO,
                              appInformation,
                              languageId,
                              context);
                        },
                        isEnabled: false,
                      ),
                    ],
                  ),
                ),
              );
              // return SemnoxLoginScreen(
              //   viewModel: ref.watch(AppLoginViewModel.provider),
              //   onAuthenticationComplete:
              //     (result, language, site, executionContext) async {
              //   Navigator.of(context).pop(true);
              // },
              // );
            }),
          ),
        ) ??
        false;
    if (authGuardState == null) {}
    authGuardState?.changeState(isAuthenticated);
    return isAuthenticated;
  }

  Future<void> checkuserIsManager(
      AuthenticateResponseDTO? authenticateresponse,
      NetworkConfigurationDTO? networkConfigurationDTO,
      AppInformationDTO? appInformation,
      UserData? userData,
      BuildContext context) async {
    await ExecutionContextProvider().buildContext(
        authenticateresponse,
        networkConfigurationDTO,
        appInformation,
        userData?.languageDto?.languageId);

    await UserRoleDataProvider(
            executionContextDTO:
                await ExecutionContextProvider().getExecutionContext())
        .initialize();

    var userroleDTO = UserRoleDataProvider.getuserroleDTO();
    if (userroleDTO.isNotEmpty) {
      if (userroleDTO.first.managerFlag == "Y") {
        Modular.to.pop(true);
      } else {
        // ignore: use_build_context_synchronously
        Utils()
            .showSemnoxDialog(context, "This User doesn't have manager Access");
      }
    } else {
      // ignore: use_build_context_synchronously
      Utils().showSemnoxDialog(context, "userroleDTO is null or empty");
    }
  }
}
