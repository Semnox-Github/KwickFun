import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/modules/network_configuration/repository/server_connection_check_repository.dart';
import 'package:semnox_core/widgets/semnox_widget/network_configuration_widget.dart/view_model/network_configuration_form_view_model.dart';

class NetworkConfigurationBL {
  NetworkConfigurationDTO? _networkConfigurationDTO;
  final _serverValidationBL = ServerConnectionCheckRepository();

  NetworkConfigurationBL(NetworkConfigurationDTO? networkConfigurationDTO) {
    _networkConfigurationDTO = networkConfigurationDTO;
  }

  Future<ServerReachablewithException?> checkServerAddressisValid(
      {required bool checkDBConnection}) async {
    // bool isValid = await _serverValidationBL
    //     .checkServerAddressisValid(_networkConfigurationDTO!.serverUrl!);
    return await _serverValidationBL.checkServerAddressisValid(
        checkDBConnection: checkDBConnection,
        address: _networkConfigurationDTO!.serverUrl!);
  }
}
