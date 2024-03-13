import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:semnox_core/modules/app_information/model/app_information_dto.dart';
import 'package:semnox_core/modules/authentication/model/authentication_response_dto.dart';
import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/utils/storage_service/storage_service.dart';

class ExecutionContextProvider {
  static ExecutionContextDTO? _executionContextDTO;
  static String get _storageKey => "executionContext";
  Future<bool> isTokenValid() async {
    try {
      //API Needed to check the token is valid
      return true;
      // ignore: empty_catches
    } catch (e) {}
    return false;
  }

  Future<void> buildContext(
      AuthenticateResponseDTO? authResult,
      NetworkConfigurationDTO? networkConfigurationDTO,
      AppInformationDTO? appInformation,
      int? languageId) async {
    var as = authResult?.userRoleId;
    var sa = authResult?.userId;
    print('authResult.UserRole: $as');
    print('authResult.UserId: $as');

    _executionContextDTO = ExecutionContextDTO(
        inWebMode: kIsWeb,
        loginId: authResult?.userId,
        siteId: authResult?.siteId,
        languageId: languageId,
        apiUrl: networkConfigurationDTO?.serverUrl,
        authToken: authResult?.webApiToken,
        machineId: authResult?.machineId,
        posMachineName:
            authResult?.posMachineName ?? appInformation?.macAddress,
        languageCode: authResult?.languageCode ?? "",
        isCorporate: authResult?.isCorporate,
        roleId: authResult?.userRoleId,
        userPKId: authResult?.userPkId,
        userId: authResult?.userId);
    await _addToLocalStorage();
  }

  Future<void> updateSession(
      {bool? isSystemUserLogined,
      bool? isSiteLogined,
      bool? isUserLogined}) async {
    print('isUserLogined:$isUserLogined');
    _executionContextDTO?.isSystemLogined = isSystemUserLogined;
    _executionContextDTO?.isSiteLogined = isSiteLogined;
    _executionContextDTO?.isUserLogined = isUserLogined;
    await _addToLocalStorage();
  }

  Future<ExecutionContextDTO?> getExecutionContext() async {
    return await _getLocalData();
  }

  Future<void> clearExecutionContext() async {
    _executionContextDTO = null;
    LocalStorage().delete(_storageKey);
  }

  Future<void> _addToLocalStorage() async {
    LocalStorage()
        .save(_storageKey, json.encode(_executionContextDTO?.toMap()));
  }

  Future<ExecutionContextDTO?> _getLocalData() async {
    if (_executionContextDTO == null) {
      var storageData = LocalStorage().get(_storageKey);
      if (storageData != null && storageData != "") {
        _executionContextDTO =
            ExecutionContextDTO.fromMap(json.decode(storageData));
      }
    }
    return _executionContextDTO;
  }
}
