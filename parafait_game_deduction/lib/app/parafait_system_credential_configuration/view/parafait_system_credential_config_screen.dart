import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_ride/app/parafait_system_credential_configuration/view_model/system_credential_config_view_model.dart';
import 'package:game_ride/routes.dart';
import 'package:semnox_core/modules/messages/provider/translation_provider.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:semnox_core/generator/assets.generator.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/widgets/buttons/flat_fill_button.dart';
import 'package:semnox_core/widgets/buttons/semnox_circle_loader.dart';
import 'package:semnox_core/widgets/elements/version_tag.dart';

class ParafaitSystemCredentialConfig extends ConsumerWidget {
  const ParafaitSystemCredentialConfig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ref.watch(SystemCredentialConfigViewModel.provider);
    viewModel.buildContext = context;
    return WillPopScope(
      onWillPop: () async {
        Modular.to.navigate(AppRoutes.networkConfiguartion);
        return Future.value(false);
      },
      child: SemnoxSetupScaffold(
        applogo: Assets.images.kwickFunLogo.path,
        appname: null,
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 100.mapToIdealHeight(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SemnoxText.h4(
                      text: TranslationProvider.getTranslationBykey(
                          Messages.systemuserlogin),
                    ),
                  ],
                ),
                SizedBox(
                  height: 45.mapToIdealHeight(context),
                ),
                Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: [
                      SemnoxTextFormField(
                        properties: viewModel.systemuserNameField,
                        prefix: const Icon(Icons.person_outline),
                        position: LabelPosition.inside,
                      ),
                      SizedBox(
                        height: 20.mapToIdealHeight(context),
                      ),
                      SemnoxTextFormField(
                        properties: viewModel.systempasswordField,
                        position: LabelPosition.inside,
                        prefix: SemnoxIcons.key.toIcon(),
                      ),
                      SizedBox(
                        height: 15.mapToIdealHeight(context),
                      ),
                      DataProviderBuilder<bool>(
                          enableAnimation: false,
                          dataProvider: viewModel.buttonStates,
                          loader: (context) {
                            return SemnoxFlatFillButton(
                              child: const SemnoxCircleLoader(),
                              onPressed: () {},
                            );
                          },
                          builder: (context, snapshot) {
                            return Column(
                              children: [
                                SemnoxFlatFillButton(
                                  child: SemnoxText.subtitle(
                                    text:
                                        TranslationProvider.getTranslationBykey(
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
                                    text:
                                        TranslationProvider.getTranslationBykey(
                                                Messages.clear)
                                            .toUpperCase(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    await viewModel.cred();
                                  },
                                ),
                                SemnoxFlatFillButton(
                                  child: SemnoxText.subtitle(
                                    text:
                                        TranslationProvider.getTranslationBykey(
                                                Messages.prev)
                                            .toUpperCase(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    Modular.to.navigate(
                                        AppRoutes.networkConfiguartion);
                                  },
                                ),
                                SemnoxFlatFillButton(
                                  child: SemnoxText.subtitle(
                                    text:
                                        TranslationProvider.getTranslationBykey(
                                                Messages.next)
                                            .toUpperCase(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    try {
                                      if ((viewModel.formKey.currentState
                                              ?.validate() ??
                                          true)) {
                                        viewModel.formKey.currentState?.save();
                                        viewModel.buttonState.startLoading();
                                        await viewModel.save();
                                        viewModel.buttonState.updateData(true);
                                      }
                                    } catch (e) {
                                      SemnoxSnackbar.error(context, "$e");
                                    }
                                  },
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        footerWidget: Padding(
          padding: const EdgeInsets.only(top: 20.0, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              AppVersionTag(),
            ],
          ),
        ),
      ),
    );
  }
}
