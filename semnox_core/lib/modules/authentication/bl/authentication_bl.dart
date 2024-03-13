import 'package:semnox_core/modules/app_information/model/app_information_dto.dart';
import 'package:semnox_core/modules/authentication/model/authentication_request_dto.dart';
import 'package:semnox_core/modules/authentication/model/authentication_response_dto.dart';
import 'package:semnox_core/modules/authentication/repository/authentication_repository.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

class AuthenticationBL {
  AuthenticationBL({required ExecutionContextDTO? executionContext}) {
    _executioncontext = executionContext;
  }

  late ExecutionContextDTO? _executioncontext;

  Future<AuthenticateResponseDTO?> loginSystemUser(
      AppInformationDTO? appInformationdto) async {
    final repo = AuthenticationRepository(_executioncontext!);

    var authenticationrequestDTO = AuthenticationRequestDTO(
            loginId: appInformationdto?.systemUsername,
            password: appInformationdto?.systemPassword,
            machineName: _executioncontext?.posMachineName!,
            siteId: _executioncontext?.siteId ?? -1)
        .toJson();

    ///TODO: Check For this credentials.
    final userResponse = await repo.loginSystemUser(authenticationrequestDTO);
    return userResponse;
  }

  Future<AuthenticateResponseDTO?> loginAsUser(
      {String? loginId,
      String? password,
      String? tagNumber,
      String? languageCode,
      int? siteId,
      String? posMachine}) async {
    final repo = AuthenticationRepository(_executioncontext!);
    var authenticationrequestDTO = AuthenticationRequestDTO(
            loginId: loginId,
            password: password,
            machineName: posMachine,
            tagNumber: tagNumber,
            languageCode: languageCode,
            siteId: siteId)
        .toJson();

    ///TODO: Check For this credentials.
    final userResponse = await repo.loginAppUser(authenticationrequestDTO);
    return userResponse;
  }

  Future<bool> isTokenValid() async {
    try {
      return true;
    } catch (e) {}

    return false;
  }
}
