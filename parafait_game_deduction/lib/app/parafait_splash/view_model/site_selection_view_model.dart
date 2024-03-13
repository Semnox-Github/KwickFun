import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_ride/routes.dart';
import 'package:rxdart/streams.dart';
import 'package:semnox_core/modules/app_information/provider/app_Information_provider.dart';
import 'package:semnox_core/modules/authentication/bl/authentication_bl.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/languages/model/language_container_dto.dart';
import 'package:semnox_core/modules/network_configuration/provider/network_configuration_provider.dart';
import 'package:semnox_core/modules/sites/bl/site_view_bl.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/dataprovider/data_provider.dart';
import 'package:semnox_core/utils/dataprovider/data_state.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SiteSelectionViewModel extends ChangeNotifier {
  SiteSelectionViewModel(
    this.ref,
  ) {
    _init();
  }

  late Ref? ref;

  static AutoDisposeChangeNotifierProvider<SiteSelectionViewModel> provider =
      ChangeNotifierProvider.autoDispose<SiteSelectionViewModel>((ref) {
    return SiteSelectionViewModel(ref);
  });

  ExecutionContextDTO? _executionContext;
  String? appNamelabel;

  List<SiteViewDTO>? sitelist;

  final formKey = GlobalKey<FormState>();

  SemnoxDropdownProperties<LanguageContainerDto> languageField =
      SemnoxDropdownProperties<LanguageContainerDto>(items: []);

  SemnoxDropdownProperties<SiteViewDTO> siteField =
      SemnoxDropdownProperties<SiteViewDTO>(items: []);

  late BuildContext context;

  final DataProvider<bool> stateupdate = DataProvider<bool>(initial: false);
  ValueStream<DataState<bool>> get loadstates => stateupdate.dataStream;

  final DataProvider<bool> buttonState = DataProvider<bool>(initial: false);
  ValueStream<DataState<bool>> get buttonStates => buttonState.dataStream;

  void _init() async {
    stateupdate.startLoading();
    _executionContext = await ExecutionContextProvider().getExecutionContext();
    sitelist = await SitesViewListBL(_executionContext).getSites();
    siteField = SemnoxDropdownProperties<SiteViewDTO>(
        label: "Site",
        items: sitelist!
            .map((e) => DropdownMenuItem<SiteViewDTO>(
                value: e, child: SemnoxText(text: "${e.siteName}")))
            .toList(),
        enabled: true,
        validators: [
          (data) {
            if (data == null) {
              return "Select Any Site";
            }
            return null;
          }
        ]);
    if (sitelist!.isNotEmpty) {
      final initial = sitelist!.firstWhereOrNull(
          (element) => _executionContext?.siteId == element.siteId);
      siteField.setInitialValue(initial ?? sitelist!.first);
    }
    stateupdate.updateData(true);
    notifyListeners();
  }

  Future<void> systemUserlogin() async {
    buttonState.startLoading();
    _executionContext = await ExecutionContextProvider().getExecutionContext();
    var appInfomationDTO = await AppInformationProvider().getAppInformation();
    var networkConfigurationDTO =
        await NetworkConfigurationProvider().getNetworkConfiguration();

    _executionContext = ExecutionContextDTO(
        apiUrl: networkConfigurationDTO?.serverUrl,
        posMachineName: appInfomationDTO?.macAddress,
        siteId: siteField.value?.siteId);

    try {
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
        Modular.to.navigate(AppRoutes.loginPage);
        buttonState.updateData(true);
      }
    } on SocketException catch (e, s) {
      // ignore: use_build_context_synchronously
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        // ignore: use_build_context_synchronously
        SemnoxSnackbar.error(context, Messages.checkInternetConnection);
      } else {
        // ignore: use_build_context_synchronously
        Utils().showCustomDialog(context, e.message, s.toString());
      }
      buttonState.updateData(true);
    } on ServerNotReachableException catch (e, s) {
      // ignore: use_build_context_synchronously
      Utils().showCustomDialog(context, e.message, s.toString(), e.statusCode);
      buttonState.updateData(true);
    } catch (e) {
      // ignore: use_build_context_synchronously
      SemnoxSnackbar.error(context, e.toString());
      buttonState.updateData(true);
    }
  }

  Future<void> clearsite() async {
    siteField.setInitialValue(sitelist!.first);
  }
}
