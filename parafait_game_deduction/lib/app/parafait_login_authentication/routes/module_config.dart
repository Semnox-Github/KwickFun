import 'package:semnox_core/modules/app_information/model/app_information_dto.dart';
import 'package:semnox_core/modules/authentication/model/authentication_response_dto.dart';
import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/widgets/semnox_widget/login_widget/view_model/login_user_form_view_model.dart';

class AuthModuleConfig {
  AuthModuleConfig({
    required this.onAuthenticationComplete,
    // required this.getSites,
  });

  // List<SiteDto> Function() getSites;

  ///
  /// This Function will be called when Authentication is completed.
  ///
  final Future<void> Function(
      AuthenticateResponseDTO? authenticateresponse,
      NetworkConfigurationDTO? networkConfigurationDTO,
      AppInformationDTO? appInformation,
      UserData? userData) onAuthenticationComplete;
}
