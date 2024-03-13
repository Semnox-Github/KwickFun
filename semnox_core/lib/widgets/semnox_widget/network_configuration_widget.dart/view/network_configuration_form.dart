import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox_core/modules/messages/provider/translation_provider.dart';
import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:semnox_core/widgets/buttons/flat_fill_button.dart';
import 'package:semnox_core/widgets/buttons/semnox_circle_loader.dart';
import 'package:semnox_core/widgets/input_fields/text_fields/editable_list_tile.dart';
import 'package:semnox_core/widgets/semnox_widget/network_configuration_widget.dart/view_model/network_configuration_form_view_model.dart';

class NetworkConfigurationForm extends StatefulWidget {
  final void Function(bool?, NetworkConfigurationDTO?) onData;

  const NetworkConfigurationForm({Key? key, required this.onData})
      : super(key: key);

  @override
  State<NetworkConfigurationForm> createState() =>
      _NetworkConfigurationFormState();
}

class _NetworkConfigurationFormState extends State<NetworkConfigurationForm> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, ref, child) {
      final viewModel = ref.watch(NetworkConfigurationFormViewModel.provider);
      viewModel.buildContext = context;
      return OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return SingleChildScrollView(
            child: Form(
              key: viewModel.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100.mapToIdealHeight(context),
                  ),
                  SemnoxText.h4(
                      text: TranslationProvider.getTranslationBykey(
                              Messages.networkInfo)
                          .toUpperCase()),
                  SizedBox(
                    height: 30.mapToIdealHeight(context),
                  ),
                  DataProviderBuilder<NetworkConfigurationDTO?>(
                      dataProvider: viewModel.connectionInfoProvider,
                      loader: (context) {
                        return const SemnoxCircleLoader(
                          color: Colors.red,
                        );
                      },
                      builder: (context, connectionInfo) {
                        var isConnected = connectionInfo != null;
                        return Column(
                          children: [
                            SetupTextFormField(
                              dropdownproperties: viewModel.sslField,
                              border: false,
                              textFieldPropeties: viewModel.serverIpField,
                              label: TranslationProvider.getTranslationBykey(
                                  Messages.serveraddressUrl),
                            ),
                            if (!isConnected)
                              Container()
                            else ...[
                              SizedBox(
                                height: 20.mapToIdealHeight(context),
                              ),
                              StreamBuilder<String>(
                                  stream: viewModel.deviceipAddress,
                                  builder: (context, snapshot) {
                                    return SemnoxListTile(
                                      leading: SemnoxIcons.ipAddress.toIcon(),
                                      title: SemnoxText.subtitle(
                                        text: TranslationProvider
                                            .getTranslationBykey(
                                                Messages.deviceIp),
                                      ),
                                      subtitle: SemnoxText.subtitle(
                                        text: snapshot.data ?? "",
                                      ),
                                    );
                                  }),
                              SizedBox(
                                height: 20.mapToIdealHeight(context),
                              ),
                              StreamBuilder<String>(
                                  stream: viewModel.macAddress,
                                  builder: (context, snapshot) {
                                    return SemnoxListTile(
                                      leading: SemnoxIcons.macAddress.toIcon(),
                                      title: SemnoxText.subtitle(
                                        text: TranslationProvider
                                            .getTranslationBykey(
                                                Messages.macaddress),
                                      ),
                                      subtitle: SemnoxText.subtitle(
                                        text: snapshot.data ?? "",
                                      ),
                                    );
                                  }),
                              SizedBox(
                                height: 20.mapToIdealHeight(context),
                              ),
                              viewModel.viewbuttonenabled == true
                                  ? SemnoxFlatFillButton(
                                      backgroundColor:
                                          viewModel.viewbuttonenabled == true
                                              ? Colors.red
                                              : null,
                                      child: SemnoxText.subtitle(
                                        text: TranslationProvider
                                                .getTranslationBykey(
                                                    Messages.viewerror)
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        Utils().showCustomserverDialog(
                                            context,
                                            viewModel
                                                .serverReachablewithException!);
                                      },
                                    )
                                  : Container(),
                              SemnoxFlatFillButton(
                                child: SemnoxText.subtitle(
                                  text: TranslationProvider.getTranslationBykey(
                                          Messages.close)
                                      .toUpperCase(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  Utils().showExitDialog(context);
                                },
                              ),
                              SemnoxFlatFillButton(
                                child: SemnoxText.subtitle(
                                  text: TranslationProvider.getTranslationBykey(
                                          Messages.clear)
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () async {
                                  viewModel.clearserverurl();
                                },
                              ),
                              connectionInfo != null
                                  ? DataProviderBuilder<bool>(
                                      enableAnimation: false,
                                      dataProvider:
                                          viewModel.validatebuttonStates,
                                      loader: (context) {
                                        return SemnoxFlatFillButton(
                                          child: const SemnoxCircleLoader(),
                                          onPressed: () {},
                                        );
                                      },
                                      builder: (context, snapshot) {
                                        return SemnoxFlatFillButton(
                                          child: SemnoxText.subtitle(
                                            text: TranslationProvider
                                                    .getTranslationBykey(
                                                        Messages.next)
                                                .toUpperCase(),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          onPressed: () async {
                                            try {
                                              connected
                                                  ? nextclicked(viewModel)
                                                  : SemnoxSnackbar.error(
                                                      context,
                                                      Messages
                                                          .checkInternetConnection);
                                            } catch (e) {
                                              SemnoxSnackbar.error(
                                                  context, "$e");
                                            }
                                          },
                                        );
                                      })
                                  : Container()
                            ]
                          ],
                        );
                      }),
                ],
              ),
            ),
          );
        },
        builder: (BuildContext context) {
          return Container();
        },
      );
    });
  }

  void nextclicked(NetworkConfigurationFormViewModel viewModel) async {
    if ((viewModel.formKey.currentState?.validate() ?? true)) {
      viewModel.formKey.currentState?.save();
      bool result = await viewModel.checkserverurlchanged(context);
      if (result == true) {
        widget.onData(
            // ignore: use_build_context_synchronously
            await viewModel.validateIpAddress(context),
            viewModel.getnetworkconfigurationDTO());
      }
    }
  }
}
