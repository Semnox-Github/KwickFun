import 'package:network_info_plus/network_info_plus.dart';
import 'package:semnox_core/modules/network_configuration/bl/network_configuration_bl.dart';
import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/widgets/semnox_widget/network_configuration_widget.dart/view_model/network_configuration_form_view_model.dart';
import 'package:universal_platform/universal_platform.dart';

class NetworkConnectivityProvider {
  NetworkInfo? _networkInfo;
  NetworkConnectivityProvider() {
    _networkInfo = NetworkInfo();
  }
  getNetworkSSID() async {
    return UniversalPlatform.isWeb ? "--" : await _networkInfo?.getWifiName();
  }

  getDeviceIpAddress() async {
    return UniversalPlatform.isWeb ? "--" : await _networkInfo?.getWifiIP();
  }

  Future<ServerReachablewithException?> checkNetworkConnection(
      NetworkConfigurationDTO? networkConfigurationDTO) async {
    if (networkConfigurationDTO == null) {
      throw NetworkConfigurationNotFoundException();
    }
    var result = await NetworkConfigurationBL(networkConfigurationDTO)
        .checkServerAddressisValid(checkDBConnection: false);
    bool? serverreachable = result!.status! ? false : true;
    if (serverreachable == false) {
      throw ServerNotReachableException();
    }
    return result;
  }
}
