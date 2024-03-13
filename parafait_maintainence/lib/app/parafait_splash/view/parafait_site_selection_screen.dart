import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/parafait_splash/view_model/site_selection_view_model.dart';
import 'package:semnox_core/generator/assets.generator.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/messages/provider/translation_provider.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:semnox_core/widgets/buttons/flat_fill_button.dart';
import 'package:semnox_core/widgets/buttons/semnox_circle_loader.dart';
import 'package:semnox_core/widgets/elements/version_tag.dart';

class ParafaitSiteSelectionScreen extends ConsumerWidget {
  const ParafaitSiteSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(SiteSelectionViewModel.provider);
    viewModel.context = context;
    return WillPopScope(
      onWillPop: () async {
        Modular.to.pop(context);
        return Future.value(false);
      },
      child: SemnoxSetupScaffold(
        logoallignment: Alignment.center,
        applogo: Assets.images.maintlogo.path,
        appname: viewModel.appNamelabel ?? "",
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
                          Messages.selectsite),
                    ),
                  ],
                ),
                SizedBox(
                  height: 45.mapToIdealHeight(context),
                ),
                DataProviderBuilder<bool>(
                    enableAnimation: false,
                    dataProvider: viewModel.loadstates,
                    loader: (context) {
                      return const SemnoxCircleLoader(
                        color: Colors.red,
                      );
                    },
                    builder: (context, snapshot) {
                      return SemnoxDropdownField<SiteViewDTO>(
                        properties: viewModel.siteField,
                        enabled: viewModel.siteField.items.length > 1
                            ? true
                            : false, //viewModel.siteField.items.length>1,
                        position: LabelPosition.top,
                        prefix: SemnoxIcons.creditCard.toIcon(),
                      );
                    }),
                SizedBox(
                  height: 20.mapToIdealHeight(context),
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
                              style: const TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              await viewModel.clearsite();
                            },
                          ),
                          SemnoxFlatFillButton(
                            child: SemnoxText.subtitle(
                              text: TranslationProvider.getTranslationBykey(
                                      Messages.prev)
                                  .toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              await ExecutionContextProvider()
                                  .clearExecutionContext();
                              Modular.to.pop(context);
                            },
                          ),
                          SemnoxFlatFillButton(
                            child: SemnoxText.subtitle(
                              text: TranslationProvider.getTranslationBykey(
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
                                  await viewModel.systemUserlogin();
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
