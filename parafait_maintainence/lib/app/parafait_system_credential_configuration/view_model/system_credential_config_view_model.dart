import 'dart:io';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/routes.dart';
import 'package:rxdart/streams.dart';
import 'package:semnox_core/modules/app_information/model/app_information_dto.dart';
import 'package:semnox_core/modules/app_information/provider/app_Information_provider.dart';
import 'package:semnox_core/modules/authentication/bl/authentication_bl.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/network_configuration/provider/network_configuration_provider.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/dataprovider/data_provider.dart';
import 'package:semnox_core/utils/dataprovider/data_state.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/utils/storage_service/storage_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:semnox_core/utils/utils.dart';

class SystemCredentialConfigViewModel extends ChangeNotifier {
  SystemCredentialConfigViewModel(
    this.ref,
  ) {
    _init();
  }
  late Ref? ref;
  static AutoDisposeChangeNotifierProvider<SystemCredentialConfigViewModel>
      provider =
      ChangeNotifierProvider.autoDispose<SystemCredentialConfigViewModel>(
          (ref) {
    return SystemCredentialConfigViewModel(ref);
  });
  String? appNamelabel;
  final formKey = GlobalKey<FormState>();
  static String get _systemuserName => "systemuserName";
  static String get _systemPassword => "systemPassword";
  final DataProvider<bool> buttonState = DataProvider<bool>(initial: false);
  ValueStream<DataState<bool>> get buttonStates => buttonState.dataStream;
  late BuildContext? buildContext;
  late SemnoxTextFieldProperties systemuserNameField =
      SemnoxTextFieldProperties(label: "System UserName", validators: [
    (value) {
      if (value?.isEmpty ?? true) return "System UserName is required";
      return null;
    }
  ]);

  late SemnoxTextFieldProperties systempasswordField =
      SemnoxTextFieldProperties(
          label: "System Password",
          isObscured: true,
          validators: [
        (value) {
          if (value?.isEmpty ?? true) return "System Password is required";
          return null;
        }
      ]);

  AppInformationDTO? _appInfomationDTO;

  void _init() async {
    try {
      _appInfomationDTO = await AppInformationProvider().getAppInformation();
      appNamelabel = _appInfomationDTO?.appName;
    } on SocketException catch (e, s) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        // ignore: use_build_context_synchronously
        SemnoxSnackbar.error(buildContext!, Messages.checkInternetConnection);
      } else {
        // ignore: use_build_context_synchronously
        Utils().showCustomDialog(buildContext!, e.message, s.toString());
      }
    }
  }

  Future<void> save() async {
    try {
      _appInfomationDTO?.systemusername = systemuserNameField.value;
      _appInfomationDTO?.systempassword = systempasswordField.value;
      bool systemuserstatus = await _performSystemUserInitialization();
      if (systemuserstatus == true) {
        LocalStorage().save(_systemuserName, systemuserNameField.value);
        LocalStorage().save(_systemPassword, systempasswordField.value);
        Modular.to.pushNamed(AppRoutes.sitePage);
      }
    } on SocketException catch (e, s) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        // ignore: use_build_context_synchronously
        SemnoxSnackbar.error(buildContext!, Messages.checkInternetConnection);
      } else {
        // ignore: use_build_context_synchronously
        Utils().showCustomDialog(buildContext!, e.message, s.toString());
      }
    } catch (e) {
      SemnoxSnackbar.error(buildContext!, e.toString());
    }
  }

  ///Accepts encrypted data and decrypt it. Returns plain text
  String decryptWithAES(String key, Encrypted encryptedData) {
    final cipherKey = encrypt.Key.fromUtf8(key);
    final encryptService =
        Encrypter(AES(cipherKey, mode: AESMode.cbc)); //Using AES CBC encryption
    final initVector = IV.fromUtf8(key.substring(0,
        16)); //Here the IV is generated from key. This is for example only. Use some other text or random data as IV for better security.

    return encryptService.decrypt(encryptedData, iv: initVector);
  }

  ///Encrypts the given plainText using the key. Returns encrypted data
  Encrypted encryptWithAES(String key, String plainText) {
    final cipherKey = encrypt.Key.fromUtf8(key);
    final encryptService = Encrypter(AES(cipherKey, mode: AESMode.cbc));
    final initVector = IV.fromUtf8(key.substring(0,
        16)); //Here the IV is generated from key. This is for example only. Use some other text or random data as IV for better security.
    Encrypted encryptedData = encryptService.encrypt(plainText, iv: initVector);
    return encryptedData;
  }

  static String prepareKey() {
    String encryptionKey = "o1!esmXn"; //o1!esmXn
    List<String> key = List<String>.generate(
        encryptionKey.length, (index) => encryptionKey[index]);
    key[0] = encryptionKey[4]; //s
    key[1] = encryptionKey[3]; //e
    key[2] = encryptionKey[5]; //m
    key[3] = encryptionKey[7]; //n
    key[4] = encryptionKey[0]; //o
    key[5] = encryptionKey[6]; //X
    key[6] = encryptionKey[2]; //!
    key[7] = encryptionKey[1]; //1
    return key.toString();
  }

  Future<bool> _performSystemUserInitialization() async {
    var networkConfigurationDTO =
        await NetworkConfigurationProvider().getNetworkConfiguration();
    ExecutionContextDTO executionContext = ExecutionContextDTO(
        apiUrl: networkConfigurationDTO?.serverUrl,
        posMachineName: _appInfomationDTO?.macAddress);

    final authenticateresponse =
        await AuthenticationBL(executionContext: executionContext)
            .loginSystemUser(_appInfomationDTO);
    if (authenticateresponse != null) {
      await ExecutionContextProvider().buildContext(
          authenticateresponse,
          networkConfigurationDTO,
          _appInfomationDTO,
          executionContext.languageId);
      await ExecutionContextProvider().updateSession(
          isSystemUserLogined: true,
          isSiteLogined: false,
          isUserLogined: false);
      return true;
    }
    return false;
  }

  Future<void> cred() async {
    systemuserNameField.setInitialValue("");
    systempasswordField.setInitialValue("");
  }
}
