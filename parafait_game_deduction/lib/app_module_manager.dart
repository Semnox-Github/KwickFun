import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:game_ride/routes.dart';
import 'package:semnox_core/modules/app_information/model/app_information_dto.dart';
import 'package:semnox_core/modules/authentication/model/authentication_response_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/messages/provider/translation_provider.dart';
import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/widgets/semnox_widget/login_widget/view_model/login_user_form_view_model.dart';

class MainModuleManager {
  MainModuleManager();
  Future<void> onAuthenticationComplete(
      AuthenticateResponseDTO? authenticateresponse,
      NetworkConfigurationDTO? networkConfigurationDTO,
      AppInformationDTO? appInformation,
      UserData? userData) async {
    await ExecutionContextProvider().buildContext(
        authenticateresponse,
        networkConfigurationDTO,
        appInformation,
        userData?.languageDto?.languageId);
    await ExecutionContextProvider().updateSession(
        isSystemUserLogined: true, isSiteLogined: true, isUserLogined: true);
    var executionContextDTO =
        await ExecutionContextProvider().getExecutionContext();
    await TranslationProvider(executionContextDTO: executionContextDTO)
        .initialize();
    Modular.to.navigate(AppRoutes.splash);
  }
}
