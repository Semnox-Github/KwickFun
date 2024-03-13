import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox_core/modules/languages/model/language_container_dto.dart';
import 'package:semnox_core/modules/messages/provider/translation_provider.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/widgets/buttons/semnox_circle_loader.dart';
import 'package:semnox_core/widgets/semnox_widget/login_widget/view_model/login_user_form_view_model.dart';

class LoginForm extends StatefulWidget {
  Function(UserData)? userdata;
  LoginUserViewModel? viewModel;

  bool isEnabled;

  LoginForm(
    this.userdata,
    this.isEnabled, {
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, ref, child) {
      final viewModel = ref.watch(LoginUserViewModel.provider);
      viewModel.context = context;

      return DataProviderBuilder<bool>(
          enableAnimation: false,
          dataProvider: viewModel.loadstates,
          loader: (context) {
            return const SemnoxCircleLoader(
              color: Colors.red,
            );
          },
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SemnoxTextFormField(
                    properties: viewModel.userNameField,
                    prefix: const Icon(Icons.person_outline),
                    position: LabelPosition.inside,
                  ),
                  SizedBox(
                    height: 20.mapToIdealHeight(context),
                  ),
                  SemnoxTextFormField(
                    properties: viewModel.passwordField,
                    position: LabelPosition.inside,
                    prefix: SemnoxIcons.key.toIcon(),
                  ),
                  SizedBox(
                    height: 15.mapToIdealHeight(context),
                  ),
                  const SemnoxText.bodyMed1(text: "-- or --"),
                  SizedBox(
                    height: 15.mapToIdealHeight(context),
                  ),
                  SemnoxTextFormField(
                    properties: viewModel.cardNoField,
                    enabled: false,
                    position: LabelPosition.inside,
                  ),
                  if (viewModel.siteField.items.length > 1) ...{
                    SizedBox(
                      height: 15.mapToIdealHeight(context),
                    ),
                    const SemnoxText.bodyMed1(text: "--  --"),
                    SizedBox(
                      height: 15.mapToIdealHeight(context),
                    ),
                    SemnoxDropdownField<SiteViewDTO>(
                      properties: viewModel.siteField,
                      enabled: viewModel.siteField.enabled,
                      position: LabelPosition.top,
                      prefix: SemnoxIcons.creditCard.toIcon(),
                    ),
                  },
                  SizedBox(
                    height: 20.mapToIdealHeight(context),
                  ),
                  SemnoxDropdownField<LanguageContainerDto>(
                    properties: viewModel.languageField,
                    enabled: widget.isEnabled,
                    position: LabelPosition.top,
                    prefix: SemnoxIcons.creditCard.toIcon(),
                  ),
                  SizedBox(
                    height: 20.mapToIdealHeight(context),
                  ),
                  Row(
                    children: [
                      DataProviderBuilder<bool>(
                          enableAnimation: false,
                          dataProvider: viewModel.buttonStates,
                          loader: (context) {
                            return Expanded(
                              child: SemnoxFlatButton(
                                child: const SemnoxCircleLoader(),
                                onPressed: () {},
                              ),
                            );
                          },
                          builder: (context, snapshot) {
                            return Expanded(
                              child: SemnoxFlatButton(
                                child: SemnoxText.subtitle(
                                  text: TranslationProvider.getTranslationBykey(
                                          Messages.login)
                                      .toUpperCase(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  try {
                                    widget.userdata!(UserData(
                                        viewModel.userNameField.value,
                                        viewModel.passwordField.value,
                                        viewModel.cardNoField.value,
                                        viewModel.siteField.value,
                                        viewModel.languageField.value,
                                        viewModel.buttonState));
                                    viewModel.cardNoField.setInitialValue("");
                                  } catch (e) {
                                    SemnoxSnackbar.error(context, "$e");
                                  }
                                },
                              ),
                            );
                          }),
                    ],
                  ),
                ],
              ),
            );
          });
    });
  }
}
