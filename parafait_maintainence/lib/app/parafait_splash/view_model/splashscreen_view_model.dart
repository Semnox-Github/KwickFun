import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/routes.dart';
import 'package:semnox_core/modules/app_information/model/app_information_dto.dart';
import 'package:semnox_core/modules/app_information/provider/app_Information_provider.dart';
import 'package:semnox_core/modules/app_initializer/app_Intializer_bl.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/messages/provider/translation_provider.dart';
import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/modules/network_configuration/provider/network_configuration_provider.dart';
import 'package:semnox_core/modules/network_configuration/provider/network_connectivity_provider.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/dataprovider/micro_state_provider.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:semnox_logger/semnox_logger.dart';

class SplashScreenViewModel extends ChangeNotifier {
  static final provider = ChangeNotifierProvider.autoDispose
      .family<SplashScreenViewModel, BuildContext>((ref, context) {
    return SplashScreenViewModel(ref, context: context);
  });

  final MicroStateProvider<String> message =
      MicroStateProvider<String>(initial: "");

  SemnoxLogger? _log;
  BuildContext? buildContext;
  ExecutionContextDTO? executionContextDTO;

  SplashScreenViewModel(this.ref, {BuildContext? context}) {
    _log = SemnoxLogger(runtimeType.toString());
    buildContext = context;
    _initializeApp();
  }

  AutoDisposeChangeNotifierProviderRef<SplashScreenViewModel> ref;

  Future<AppInformationDTO?> _getApplicationInformation() async {
    AppInformationDTO? appInfomationDTO =
        await AppInformationProvider().getAppInformation();
    return appInfomationDTO;
  }

  Future<NetworkConfigurationDTO?> _getNetworkConfiguration(
      AppInformationDTO appInformation) async {
    NetworkConfigurationDTO? networkConfigurationDTO;
    try {
      networkConfigurationDTO =
          await NetworkConfigurationProvider().getNetworkConfiguration();
    } on NetworkConfigurationNotFoundException {
      if (appInformation.inWebMode == true) {
        // get Web Config JSON File;
        final String jsonConfiguration =
            await rootBundle.loadString('assets/web_configuration.json');
        networkConfigurationDTO =
            NetworkConfigurationDTO.fromJson(json.decode(jsonConfiguration));
        await NetworkConfigurationProvider()
            .storeNetworkConfiguration(networkConfigurationDTO);
        Modular.to.navigate(AppRoutes.splash);
        rethrow;
      } else {
        Modular.to.navigate(AppRoutes.networkConfiguartion);
        rethrow;
      }
    }

    try {
      await NetworkConnectivityProvider()
          .checkNetworkConnection(networkConfigurationDTO);
    } on ServerNotReachableException {
      if (appInformation.isOfflineEnabled == false) {
        await updateMessage(Messages.servernotreachable);
        rethrow;
      }
    }
    return networkConfigurationDTO!;
  }

  Future<void> _initializeApp() async {
    try {
      var appInfomationDTO = await _getApplicationInformation();
      var networkConnetionDTO =
          await _getNetworkConfiguration(appInfomationDTO!);
      AppInitializerBL appInitializationBL = AppInitializerBL(
          networkConfigurationDTO: networkConnetionDTO,
          appInformation: appInfomationDTO,
          statusMessageListener: updateMessage,
          context: buildContext);
      executionContextDTO = await appInitializationBL.initialize();
      if (executionContextDTO == null) {
        Modular.to.navigate(AppRoutes.systemcredsave);
      } else if (executionContextDTO?.isSystemLogined == true &&
          executionContextDTO?.isSiteLogined == false &&
          executionContextDTO?.isUserLogined == false) {
        Modular.to.pushNamed(AppRoutes.sitePage);
      } else {
        Modular.to.navigate(AppRoutes.loginPage);
      }
    } on NetworkConfigurationNotFoundException catch (e) {
    } on ServerNotReachableException catch (e, s) {
      Utils().showCustomDialog(
          buildContext!, e.message, s.toString(), e.statusCode);
    } on UnauthorizedException catch (e) {
      SemnoxSnackbar.error(buildContext!, e.message.toString());
      await ExecutionContextProvider().clearExecutionContext();
      Modular.to.navigate(AppRoutes.loginPage);
    } on BadRequestException catch (e) {
      SemnoxSnackbar.error(buildContext!, e.message.toString());
      Modular.to.navigate(AppRoutes.systemcredsave);
    } on SocketException catch (e) {
      executionContextDTO =
          await ExecutionContextProvider().getExecutionContext();
      if (executionContextDTO?.isSystemLogined == true &&
          executionContextDTO?.isSiteLogined == true &&
          executionContextDTO?.isUserLogined == false) {
        Modular.to.navigate(AppRoutes.loginPage);
      } else if (executionContextDTO?.isSystemLogined == true &&
          executionContextDTO?.isSiteLogined == true &&
          executionContextDTO?.isUserLogined == true) {
        Modular.to.navigate(AppRoutes.home);
      } else {
        SemnoxSnackbar.error(buildContext!, e.toString());
      }
    } catch (e) {
      SemnoxSnackbar.error(buildContext!, e.toString());
      Modular.to.navigate(AppRoutes.loginPage);
    }
  }

  updateMessage(String newmessage) async {
    message
        .updateData(await TranslationProvider.getTranslationBykey(newmessage));
  }
}
