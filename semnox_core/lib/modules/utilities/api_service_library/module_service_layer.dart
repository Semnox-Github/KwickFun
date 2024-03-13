import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/semnox_parafait_server.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';

abstract class ModuleServiceLayer<T> {
  ParafaitServer? _server;

  ModuleServiceLayer(ExecutionContextDTO? executionContext) {
    _server = ParafaitServer(executionContext);
  }

  ParafaitServer? server() {
    return _server;
  }

  Map<String, dynamic> decodeToMap(APIResponse response) {
    if (response.data is Map) {
      return response.data as Map<String, dynamic>;
    }
    throw InvalidResponseException();
  }

  Future<List?> getData({required Map? searchparams});
  Future<List?> postData(Object dto, Map? searchparams);
  Future<int?> postDataToLocalDB(Object dto);
}
