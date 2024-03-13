import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox_core/modules/network_configuration/provider/server_reachability_provider.dart';
import 'package:semnox_core/utils/utils.dart';
import 'semnox_state_icon.dart';

class ConnectionStatusIndicator extends ConsumerWidget {
  const ConnectionStatusIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SemnoxStateIcon(
        connectionState: ref.watch(ServerReachabilityNotifier.provider),
        onPressed: () {
          // var connectionstate = ref.watch(ServerReachabilityNotifier.provider);
          // if (connectionstate == SemnoxConnectionState.IS_NOT_CONNECTED) {
          //   Utils().showCustomserverDialog(
          //       context,
          //       ref
          //           .read(ServerReachabilityNotifier.provider.notifier)
          //           .getserverReachablewithException);
          // }
        },
        icon: const Icon(Feather.server),
      ),
    );
  }
}
