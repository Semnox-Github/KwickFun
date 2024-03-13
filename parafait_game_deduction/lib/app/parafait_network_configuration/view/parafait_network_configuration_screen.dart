import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_ride/app/parafait_network_configuration/view_model/network_configuration_view_model.dart';
import 'package:semnox_core/generator/assets.generator.dart';
import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/widgets/semnox_widget/network_configuration_widget.dart/view/network_configuration_form.dart';

// ignore: must_be_immutable
class ParafaitNetworkConfiguration extends ConsumerWidget {
  NetworkConfigurationViewModel? _networkConfigurationViewModel;

  ParafaitNetworkConfiguration({Key? key}) : super(key: key);

  Future<void> Function(bool? networkstatus)? onComplete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _networkConfigurationViewModel =
        ref.watch(NetworkConfigurationViewModel.provider);
    _networkConfigurationViewModel?.buildContext = context;

    return WillPopScope(
      onWillPop: () async {
        _networkConfigurationViewModel?.checkexcutioncontextavailable();
        return Future.value(false);
      },
      child: SemnoxSetupScaffold(
        applogo: Assets.images.kwickFunLogo.path,
        body: NetworkConfigurationForm(onData: _onData),
      ),
    );
  }

  void _onData(bool? status, NetworkConfigurationDTO? networkConfigurationDTO) {
    if (networkConfigurationDTO != null) {
      _networkConfigurationViewModel?.checkaddressvalid(
          status, networkConfigurationDTO);
    }
  }
}
