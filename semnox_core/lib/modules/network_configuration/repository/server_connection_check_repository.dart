import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/widgets/semnox_widget/network_configuration_widget.dart/view_model/network_configuration_form_view_model.dart';
import 'request/server_connection_check_service.dart';

class ServerConnectionCheckRepository {
  Future<ServerReachablewithException?> checkServerAddressisValid(
      {required String address, required bool checkDBConnection}) async {
    ServerConnectionCheckService service =
        ServerConnectionCheckService(ExecutionContextDTO(apiUrl: address));
    return await service.ping(checkDBConnection: checkDBConnection);
    // try {
    //   return await service.ping();
    // } catch (error, stacktrace) {
    //   // if (error is InvalidResponseException || error is NotFoundException) {

    //   return ServerReachablewithException(
    //       status: false, exception: error, stackTrace: stacktrace);
    //   // }
    // }
    // return ServerReachablewithException(status: false);
  }
}
