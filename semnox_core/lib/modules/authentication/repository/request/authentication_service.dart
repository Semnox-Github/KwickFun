import 'dart:async';
import 'dart:io';
import 'package:retry/retry.dart';
import 'package:semnox_core/modules/authentication/model/authentication_response_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/constants.dart';

class AuthenticationService extends ModuleService {
  final r = const RetryOptions(maxAttempts: 3);

  AuthenticationService(ExecutionContextDTO? executionContext)
      : super(executionContext);

  Future<AuthenticateResponseDTO?>? authenticateSystemUsers(
      Map<String, dynamic> authenticationrequestDTO) async {
    APIResponse response = await r.retry(
      () => server
          .call()!
          .post(SemnoxConstants.authenticateSystemUsersUrl,
              authenticationrequestDTO)
          .timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    if (response.data is! Map) {
      throw InvalidResponseException("Invalid Response.");
    }
    Map<String, dynamic> data = response.data;
    return data["data"] == null
        ? null
        : AuthenticateResponseDTO.fromJson(data["data"]);
  }

  Future<AuthenticateResponseDTO?> authenticateAppUsers(
      Map<String, dynamic> authenticationrequestDTO) async {
    APIResponse response = await r.retry(
      () => server
          .call()!
          .post(
              SemnoxConstants.authenticateAppUsersUrl, authenticationrequestDTO)
          .timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    if (response.data is! Map) {
      throw InvalidResponseException("Invalid Response.");
    }
    Map<String, dynamic> data = response.data;
    print('authenticateAppUsersUrl,$data');
    return data["data"] == null
        ? null
        : AuthenticateResponseDTO.fromJson(data["data"]);
  }
}
