import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_ride/routes.dart';
import 'package:semnox_core/modules/app_information/model/app_information_dto.dart';
import 'package:semnox_core/modules/app_information/provider/app_Information_provider.dart';
import 'package:semnox_core/modules/authentication/bl/authentication_bl.dart';
import 'package:semnox_core/modules/authentication/model/authentication_response_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/languages/bl/language_view_bl.dart';
import 'package:semnox_core/modules/lookups/bl/lookup_view_bl.dart';
import 'package:semnox_core/modules/messages/provider/translation_provider.dart';
import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/modules/network_configuration/provider/network_configuration_provider.dart';
import 'package:semnox_core/modules/parafait_defaults_configuration/bl/parafait_default_view_bl.dart';
import 'package:semnox_core/modules/sites/bl/site_view_bl.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/dataprovider/micro_state_provider.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:semnox_core/widgets/semnox_widget/login_widget/view_model/login_user_form_view_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(
    this.ref,
  ) {
    _init();
  }
  late Ref? ref;
  static AutoDisposeChangeNotifierProvider<LoginViewModel> provider =
      ChangeNotifierProvider.autoDispose<LoginViewModel>((ref) {
    return LoginViewModel(ref);
  });

  ExecutionContextDTO? _executionContext;
  final MicroStateProvider<String> message =
      MicroStateProvider<String>(initial: "");
  bool? isLoggedIn = false;
  String? appNamelabel;

  void _init() async {
    _executionContext = await ExecutionContextProvider().getExecutionContext();
    if (_executionContext == null) {
      var appInfomationDTO = await AppInformationProvider().getAppInformation();
      var networkConfigurationDTO =
          await NetworkConfigurationProvider().getNetworkConfiguration();
      _executionContext = ExecutionContextDTO(
          apiUrl: networkConfigurationDTO?.serverUrl,
          posMachineName: appInfomationDTO?.macAddress);
      final authenticateresponse =
          await AuthenticationBL(executionContext: _executionContext)
              .loginSystemUser(appInfomationDTO);
      if (authenticateresponse != null) {
        await ExecutionContextProvider().buildContext(
            authenticateresponse,
            networkConfigurationDTO,
            appInfomationDTO,
            _executionContext?.languageId);
        await ExecutionContextProvider().updateSession(
            isSystemUserLogined: true,
            isSiteLogined: true,
            isUserLogined: false);
      }
    }
    _executionContext = await ExecutionContextProvider().getExecutionContext();
    if (_executionContext?.isSystemLogined == true &&
        _executionContext?.isSiteLogined == true &&
        _executionContext?.isUserLogined == false) {
      bool isTokenValid = await ExecutionContextProvider().isTokenValid();
      if (isTokenValid == true) {
        var appInformationDTO =
            await AppInformationProvider().getAppInformation();
        appNamelabel = appInformationDTO?.appName;
        isLoggedIn = true;
        notifyListeners();
        return;
      } else {
        throw AppException();
      }
    }
    // load user specific data if isSystemLogin == false
    await _loadUserSpecificData();
    Modular.to.navigate(AppRoutes.home);
    return;
  }

  void onLoginClick(
      BuildContext context,
      UserData userData,
      Future<void> Function(
              AuthenticateResponseDTO? authenticateresponse,
              NetworkConfigurationDTO? networkConfigurationDTO,
              AppInformationDTO? appInformation,
              UserData? userData)
          onComplete) async {
    try {
      userData.buttonState.startLoading();
      var networkConfigurationDTO =
          await NetworkConfigurationProvider().getNetworkConfiguration();
      var appInformationDTO =
          await AppInformationProvider().getAppInformation();
      final authenticateresponse =
          await AuthenticationBL(executionContext: _executionContext)
              .loginAsUser(
                  loginId: userData.loginId,
                  password: userData.password,
                  tagNumber: userData.cardNumber,
                  languageCode: userData.languageDto?.languageCode,
                  siteId: userData.site?.siteId,
                  posMachine: _executionContext?.posMachineName);
      await onComplete(authenticateresponse, networkConfigurationDTO,
          appInformationDTO, userData);
      userData.buttonState.updateData(true);
    } on SocketException catch (e, s) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        // ignore: use_build_context_synchronously
        SemnoxSnackbar.error(context, Messages.checkInternetConnection);
      } else {
        // ignore: use_build_context_synchronously
        Utils().showCustomDialog(context, e.message, s.toString());
      }
      userData.buttonState.updateData(true);
    } on ServerNotReachableException catch (e, s) {
      // ignore: use_build_context_synchronously
      Utils().showCustomDialog(context, e.message, s.toString(), e.statusCode);
      userData.buttonState.updateData(true);
    } catch (e) {
      SemnoxSnackbar.error(context, "$e");
      userData.buttonState.updateData(true);
    }
  }

  Future<void> _loadUserSpecificData() async {
    final futureGroup = FutureGroup();

    /// add all the futures , this is not the best way u can create an extension method to add all at the same time
    _updateMessage(await TranslationProvider.getTranslationBykey(
        Messages.loadingcontainer));
    futureGroup
        .add(ParafaitDefaultViewListBL(_executionContext).getParafaitDefault());
    futureGroup.add(LookupViewListBL(_executionContext).getLookUp());
    futureGroup.add(LanguageViewListBL(_executionContext).getLanguages());
    futureGroup.add(TranslationProvider(executionContextDTO: _executionContext)
        .initialize());
    futureGroup.add(SitesViewListBL(_executionContext).getSites());
    futureGroup.close();
    // await for future group to finish (all futures inside it to finish)
    await futureGroup.future;
  }

  void _updateMessage(String newmessage) {
    message.updateData(newmessage);
  }
}
