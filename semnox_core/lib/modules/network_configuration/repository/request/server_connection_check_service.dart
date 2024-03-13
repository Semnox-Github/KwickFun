import 'dart:async';
import 'dart:io';
import 'package:retry/retry.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/utils/constants.dart';
import 'package:semnox_core/widgets/semnox_widget/network_configuration_widget.dart/view_model/network_configuration_form_view_model.dart';

class ServerConnectionCheckService extends ModuleService {
  final r = const RetryOptions(maxAttempts: 3);
  ServerConnectionCheckService(ExecutionContextDTO executionContext)
      : super(executionContext);
  Future<ServerReachablewithException?> ping(
      {required bool checkDBConnection}) async {
    try {
      APIResponse response = await r.retry(
        () async => await server
            .call()!
            .get(SemnoxConstants.remoteConnectionUrl, queryParameters: {
          "checkDBConnection": checkDBConnection
        }).timeout(const Duration(seconds: 10)),
        // Retry on SocketException or TimeoutException
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
      return ServerReachablewithException(status: response.data != null);
    } on ServerNotReachableException catch (error) {
      return ServerReachablewithException(
          status: false,
          exception: error,
          stackTrace: StackTrace.current,
          statusCode: error.statusCode);
    } catch (error) {
      return ServerReachablewithException(
        status: false,
        exception: error,
        stackTrace: StackTrace.current,
      );
    }
  }
}
