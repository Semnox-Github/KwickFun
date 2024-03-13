import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_ride/app/game_ride/provider/selected_game_machines.dart';
import 'package:game_ride/routes.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:semnox_core/modules/app_information/model/app_information_dto.dart';
import 'package:semnox_core/modules/app_information/provider/app_Information_provider.dart';
import 'package:semnox_core/modules/app_initializer/app_Intializer_bl.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/game/provider/game_data_List_provider.dart';
import 'package:semnox_core/modules/messages/provider/translation_provider.dart';
import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/modules/network_configuration/provider/network_configuration_provider.dart';
import 'package:semnox_core/modules/network_configuration/provider/network_connectivity_provider.dart';
import 'package:semnox_core/modules/pos_machines/bl/pos_machine_bl.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/dataprovider/micro_state_provider.dart';
import 'package:semnox_logger/semnox_logger.dart';
import 'package:semnox_core/utils/message.dart';

class SplashScreenViewModel extends ChangeNotifier {
  static final provider = ChangeNotifierProvider.autoDispose
      .family<SplashScreenViewModel, BuildContext>((ref, context) {
    return SplashScreenViewModel(ref, context: context);
  });

  final MicroStateProvider<String> message =
      MicroStateProvider<String>(initial: "");

  SemnoxLogger? _log;
  BuildContext? buildContext;

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
      // _log?.error(
      //     "_getNetworkConfiguration",
      //     await getTranslationString(
      //         "Network Configuration Not Found Exception"),
      //     NetworkConfigurationNotFoundException());
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
      // _log?.error(
      //     "_getNetworkConfiguration",
      //     await getTranslationString("Server Not Reachable Exception"),
      //     ServerNotReachableException());
      //code
      if (appInformation.isOfflineEnabled == false) {
        // this should be an alert message. App cannot continue
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
      var executionContextDTO = await appInitializationBL.initialize();

      if (executionContextDTO == null) {
        // if (appInfomationDTO.systemUsername == null &&
        //     appInfomationDTO.systemPassword == null) {
        //   Modular.to.navigate(AppRoutes.systemcredsave);
        // }
        Modular.to.navigate(AppRoutes.systemcredsave);
      } else if (executionContextDTO.isSystemLogined == true &&
          executionContextDTO.isSiteLogined == false) {
        Modular.to.pushNamed(AppRoutes.sitePage);
      } else {
        await _initializeAppContainers(executionContextDTO);
        Modular.to.navigate(AppRoutes.loginPage);
      }
    } on NetworkConfigurationNotFoundException catch (e) {
    } on ServerNotReachableException catch (e, s) {
      Utils().showCustomDialog(buildContext!, e.message, s.toString());
    } on UnauthorizedException catch (e) {
      SemnoxSnackbar.error(buildContext!, e.message.toString());
      await ExecutionContextProvider().clearExecutionContext();
      Modular.to.navigate(AppRoutes.loginPage);
    } on BadRequestException catch (e) {
      SemnoxSnackbar.error(buildContext!, e.message.toString());
      Modular.to.navigate(AppRoutes.systemcredsave);
    } catch (e) {
      SemnoxSnackbar.error(buildContext!, e.toString());
      Modular.to.navigate(AppRoutes.loginPage);
    }
  }

  Future<void> _initializeAppContainers(
      ExecutionContextDTO executionContext) async {
    // final futureGroup = FutureGroup();
    await updateMessage(Messages.loadingAppcontainer);

    // futureGroup
    //     .add(GameDataProvider(executionContextDTO: executionContext).fromIds());
    await GameDataListProvider.fromIds(executionContext);
    // reader(GameMachineProvider.provider.notifier).initialize();
    // futureGroup.add(PosMachineListBL(executionContext).getPosMachines());
    await PosMachineListBL(executionContext).getPosMachines();
    // reader(SemnoxPosMachineProvider.provider.notifier).refresh();
    await ref.read(SelectedGameMachinesNotifier.provider).initialize();
  }

  updateMessage(String newmessage) async {
    message
        .updateData(await TranslationProvider.getTranslationBykey(newmessage));
  }

  getTranslationString(String key) async {
    return await TranslationProvider.getTranslationBykey(key);
  }
}
