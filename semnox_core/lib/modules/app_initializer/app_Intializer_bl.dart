import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:semnox_core/modules/app_information/model/app_information_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/hr/bl/user_container_bl.dart';
import 'package:semnox_core/modules/hr/provider/userrole_data_provider.dart';
import 'package:semnox_core/modules/languages/bl/language_view_bl.dart';
import 'package:semnox_core/modules/lookups/bl/lookup_view_bl.dart';
import 'package:semnox_core/modules/messages/provider/translation_provider.dart';
import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/modules/network_configuration/provider/network_connectivity_provider.dart';
import 'package:semnox_core/modules/parafait_defaults_configuration/provider/default_config.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/widgets/popup/index.dart';

class AppInitializerBL {
  AppInformationDTO? _appInformation;
  NetworkConfigurationDTO? _networkConfigurationDTO;
  ExecutionContextDTO? _executionContext;
  late void Function(String message)? _statusMessageListener;
  BuildContext? buildContext;

  AppInitializerBL(
      {required NetworkConfigurationDTO? networkConfigurationDTO,
      required AppInformationDTO? appInformation,
      required void Function(String message)? statusMessageListener,
      BuildContext? context}) {
    _networkConfigurationDTO = networkConfigurationDTO;
    _appInformation = appInformation;
    _statusMessageListener = statusMessageListener;
    buildContext = context;
  }

  Future<ExecutionContextDTO?> initialize() async {
    // Step 1 - Get the execution context from the local storage
    _executionContext = await ExecutionContextProvider().getExecutionContext();
    // Step 2 - If there is no EC, login as system user
    if (_executionContext != null) {
      // check if the token is valid
      var isTokenValid = await ExecutionContextProvider().isTokenValid();
      if (!isTokenValid) {
        var isConnectedToNetwork = await NetworkConnectivityProvider()
            .checkNetworkConnection(_networkConfigurationDTO);
        if (isConnectedToNetwork!.status!) {
          _executionContext =
              await ExecutionContextProvider().getExecutionContext();
        } else if (_appInformation?.isOfflineEnabled == false) {
          throw UnauthorizedException();
        }
      }
      await _loadAppDataParallel();
    }
    return _executionContext;
  }

  Future<void> _loadAppDataParallel() async {
    final futureGroup = FutureGroup();
    _statusMessageListener!(Messages.loadingcontainer);
    futureGroup.add(
        DefaultConfigProvider(executionContextDTO: _executionContext)
            .initialize());
    futureGroup.add(LookupViewListBL(_executionContext).getLookUp());
    futureGroup.add(LanguageViewListBL(_executionContext).getLanguages());
    futureGroup.add(TranslationProvider(executionContextDTO: _executionContext)
        .initialize());
    futureGroup.add(UserRoleDataProvider(executionContextDTO: _executionContext)
        .initialize());
    futureGroup
        .add(UserContainerListBL(_executionContext).getUserContainerDTOList());
    futureGroup.close();
    await futureGroup.future;
  }

  getTranslationString(String key) async {
    //  return await _translationProvider?.getTranslationBykey(key);
  }
}
