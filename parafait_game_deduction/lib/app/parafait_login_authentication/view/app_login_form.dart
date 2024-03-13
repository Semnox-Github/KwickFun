import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_ride/app/parafait_login_authentication/view_model/login_view_model.dart';
import 'package:semnox_core/modules/app_information/model/app_information_dto.dart';
import 'package:semnox_core/modules/authentication/model/authentication_response_dto.dart';
import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/widgets/semnox_widget/login_widget/view/login_form.dart';
import 'package:semnox_core/widgets/semnox_widget/login_widget/view_model/login_user_form_view_model.dart';

class AppLoginForm extends ConsumerWidget {
  const AppLoginForm(
      {Key? key,
      required this.onAuthenticationComplete,
      required this.isEnabled})
      : super(key: key);

  final Future<void> Function(
      AuthenticateResponseDTO? authenticateresponse,
      NetworkConfigurationDTO? networkConfigurationDTO,
      AppInformationDTO? appInformation,
      UserData? userData) onAuthenticationComplete;

  final bool isEnabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(LoginViewModel.provider);
    ref.watch(LoginViewModel.provider);
    return LoginForm((UserData userdata) async {
      if ((userdata.loginId!.isNotEmpty && userdata.password!.isNotEmpty) ||
          userdata.cardNumber!.isNotEmpty) {
        viewModel.onLoginClick(context, userdata, onAuthenticationComplete);
      } else if (userdata.loginId!.isEmpty && userdata.password!.isEmpty) {
        SemnoxSnackbar.error(context, "Username / password is required ");
      }
    }, isEnabled);
  }
}
