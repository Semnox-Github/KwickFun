import 'package:semnox_core/modules/authentication/model/authentication_response_dto.dart';
import 'package:semnox_core/modules/authentication/repository/request/authentication_service.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

class AuthenticationRepository {
  AuthenticationRepository(ExecutionContextDTO executionContext) : super() {
    _service = AuthenticationService(executionContext);
  }

  late AuthenticationService _service;

  Future<AuthenticateResponseDTO?> loginSystemUser(
      Map<String, dynamic> authenticationrequestDTO) async {
    final result =
        await _service.authenticateSystemUsers(authenticationrequestDTO);
    return result;
  }

  Future<AuthenticateResponseDTO?> loginAppUser(
      Map<String, dynamic> authenticationrequestDTO) async {
    final result =
        await _service.authenticateAppUsers(authenticationrequestDTO);
    return result;
  }
}
