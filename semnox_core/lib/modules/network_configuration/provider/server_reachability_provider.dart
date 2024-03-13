import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox_core/modules/network_configuration/bl/network_configuration_bl.dart';
import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/modules/network_configuration/provider/network_configuration_provider.dart';
import 'package:semnox_core/utils/helper/debouncer.dart';
import 'package:semnox_core/widgets/elements/semnox_state_icon.dart';
import 'package:semnox_core/widgets/semnox_widget/network_configuration_widget.dart/view_model/network_configuration_form_view_model.dart';

class ServerReachabilityNotifier extends StateNotifier<SemnoxConnectionState> {
  static final provider =
      StateNotifierProvider<ServerReachabilityNotifier, SemnoxConnectionState>(
          (ref) {
    return ServerReachabilityNotifier();
  });

  ServerReachabilityNotifier() : super(SemnoxConnectionState.IS_NOT_CONNECTED) {
    _checkStatus();
  }

  Debouncer debouncer = Debouncer(duration: const Duration(seconds: 10));
  List<ServerReachablewithException?>? serverReachablewithException = [];
  ServerReachablewithException? serverreachable, dbreachable;

  NetworkConfigurationDTO? _networkConfigurationDTO;

  List<ServerReachablewithException?>? get getserverReachablewithException =>
      serverReachablewithException;
  Future<void> _checkStatus() async {
    if (!mounted) return;
    serverReachablewithException = [];
    _networkConfigurationDTO =
        await NetworkConfigurationProvider().getNetworkConfiguration();
    serverreachable = await NetworkConfigurationBL(_networkConfigurationDTO)
        .checkServerAddressisValid(checkDBConnection: false);

    serverReachablewithException?.add(ServerReachablewithException(
        entitytype: "Is Server Url Format Valid?",
        status: true,
        exception: "null"));

    if (serverreachable?.status == false) {
      serverReachablewithException?.add(ServerReachablewithException(
          entitytype: "Is Webserver Accessible?",
          status: false,
          exception: serverreachable?.exception,
          stackTrace: serverreachable?.stackTrace));
    } else {
      serverReachablewithException?.add(ServerReachablewithException(
          entitytype: "Is Webserver Accessible?",
          status: true,
          exception: "null"));
    }

    if (serverreachable?.status == true) {
      dbreachable = await NetworkConfigurationBL(_networkConfigurationDTO)
          .checkServerAddressisValid(checkDBConnection: true);
      if (dbreachable?.status == false) {
        serverReachablewithException?.add(ServerReachablewithException(
            entitytype: "Is DB Connection Established?",
            status: false,
            exception: dbreachable?.exception,
            stackTrace: dbreachable?.stackTrace));
      } else {
        serverReachablewithException?.add(ServerReachablewithException(
            entitytype: "Is DB Connection Established?",
            status: true,
            exception: "null"));
      }
    } else {
      serverReachablewithException?.add(ServerReachablewithException(
          entitytype: "Is DB Connection Established ?",
          status: false,
          exception: "null"));
    }

    bool? isReachable =
        (serverreachable!.status! && dbreachable!.status!) ? true : false;

    if (!mounted) return;
    state = isReachable
        ? SemnoxConnectionState.IS_CONNECTED
        : SemnoxConnectionState.IS_NOT_CONNECTED;
    if (!mounted) return;
    debouncer.run(_checkStatus);
  }

  @override
  void dispose() {
    debouncer.cancel();
    super.dispose();
  }
}
