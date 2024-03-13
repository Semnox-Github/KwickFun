import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_ride/routes.dart';
import 'package:semnox_core/modules/app_information/provider/app_Information_provider.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/messages/provider/translation_provider.dart';
import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/modules/network_configuration/provider/network_configuration_provider.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:semnox_logger/semnox_logger.dart';

class NetworkConfigurationViewModel extends ChangeNotifier {
  static ChangeNotifierProvider<NetworkConfigurationViewModel> provider =
      ChangeNotifierProvider<NetworkConfigurationViewModel>(
    (ref) {
      return NetworkConfigurationViewModel();
    },
  );

  late BuildContext? buildContext;

  NetworkConfigurationViewModel() {
    _log = SemnoxLogger(runtimeType.toString());

    _fetchStoredServerIP();
  }
  NetworkConfigurationDTO? _networkConfigurationDTO;
  String? appNamelabel;
  SemnoxLogger? _log;

  Future<void> _fetchStoredServerIP() async {
    try {
      _networkConfigurationDTO =
          await NetworkConfigurationProvider().getNetworkConfiguration();
    } catch (e) {
      // SemnoxSnackbar.error(buildContext!, e.toString());
    }
    // if (_networkConfigurationDTO?.serverUrl != null) {
    //   bool isValid = await NetworkConfigurationBL(_networkConfigurationDTO)
    //       .checkServerAddressisValid();
    //   if (isValid) {
    //     Modular.to.pushNamed(AppRoutes.splash);
    //   }
    //   return;
    // }
    var appInformationDTO = await AppInformationProvider().getAppInformation();
    appNamelabel = await TranslationProvider.getTranslationBykey(
        appInformationDTO?.appName);
    notifyListeners();
  }

  checkaddressvalid(
      bool? status, NetworkConfigurationDTO? networkConfigurationDTO) async {
    if (status == true) {
      await saveNetworkConfiguraton(networkConfigurationDTO);
      Modular.to.navigate(AppRoutes.splash);
    }
  }

  saveNetworkConfiguraton(
      NetworkConfigurationDTO? networkConfigurationDTO) async {
    NetworkConfigurationProvider()
        .storeNetworkConfiguration(networkConfigurationDTO);
  }

  Future<void> checkexcutioncontextavailable() async {
    var executioncontext =
        await ExecutionContextProvider().getExecutionContext();
    if (executioncontext != null) {
      Modular.to.navigate(AppRoutes.appsetting);
    } else {
      Utils().showExitDialog(buildContext!);
    }
  }
}
