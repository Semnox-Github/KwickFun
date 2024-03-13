import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:game_ride/app/parafait_login_authentication/view/app_login_form.dart';
import 'package:game_ride/app/parafait_login_authentication/view_model/login_view_model.dart';
import 'package:game_ride/routes.dart';
import 'package:semnox_core/generator/assets.generator.dart';
import 'package:semnox_core/modules/app_information/model/app_information_dto.dart';
import 'package:semnox_core/modules/authentication/model/authentication_response_dto.dart';
import 'package:semnox_core/modules/messages/provider/translation_provider.dart';
import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:semnox_core/widgets/elements/version_tag.dart';
import 'package:semnox_core/widgets/semnox_widget/login_widget/view_model/login_user_form_view_model.dart';

class ParafaitLoginScreen extends StatelessWidget {
  final LoginViewModel viewModel;
  int? count = 0;
  ParafaitLoginScreen({
    Key? key,
    required this.viewModel,
    required this.onAuthenticationComplete,
  }) : super(key: key);

  final Future<void> Function(
      AuthenticateResponseDTO? authenticateresponse,
      NetworkConfigurationDTO? networkConfigurationDTO,
      AppInformationDTO? appInformation,
      UserData? userData) onAuthenticationComplete;

  @override
  Widget build(BuildContext context) {
    if (viewModel.isLoggedIn == false) {
      return SemnoxSplashScreen();
    }
    return WillPopScope(
      onWillPop: () async {
        Utils().showExitDialog(context);
        return Future.value(false);
      },
      child: SemnoxSetupScaffold(
        applogo: Assets.images.kwickFunLogo.path,
        appname: null,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 100.mapToIdealHeight(context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SemnoxText.h4(
                        text: TranslationProvider.getTranslationBykey(
                            Messages.loginToSemnox),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 45.mapToIdealHeight(context),
                  ),
                  AppLoginForm(
                      isEnabled: true,
                      onAuthenticationComplete: onAuthenticationComplete),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: InkWell(
                      onTap: () async {
                        count = count! + 1;
                        if (count! >= 5) {
                          Modular.to.pushReplacementNamed(
                              AppRoutes.networkConfiguartion);
                        }
                      },
                      child: const AppVersionTag(
                        textScaleFactor: 0.8,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
