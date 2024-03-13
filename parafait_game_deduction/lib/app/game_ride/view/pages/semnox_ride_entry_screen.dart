import 'dart:async';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_ride/routes.dart';
import 'package:game_ride/themes.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/messages/provider/translation_provider.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/extension/formatter.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:semnox_core/widgets/elements/connection_status_indicator.dart';
import 'package:semnox_core/widgets/elements/version_tag.dart';
import 'package:semnox_core/widgets/input_fields/nfc_reader/nfc_reader.dart';
import 'package:semnox_core/widgets/input_fields/nfc_reader/semnox_ride_tap_card.dart';

import '../../provider/view_model/start_ride_view_model.dart';
import '../widgets/post_gameplay_result.dart';

// ignore: must_be_immutable
class SemnoxRideEntryScreen extends ConsumerWidget {
  var selectedItem = '';
  SemnoxRideEntryScreen({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();

  get userIdAppVersionTag => null;

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ref.watch(StartRideViewModel.provider);
    viewModel.context = context;
    return WillPopScope(
        onWillPop: () async {
          Utils().showExitDialog(context);
          return Future.value(false);
        },
        child: SemnoxScaffold(
          bodyPadding: EdgeInsets.zero,
          appBar: SemnoxAppBar(
            automaticallyImplyLeading: false,
            title:
                // Flexible(
                //   child:
                Row(
              children: [
                Image.asset("assets/images/parafait_splash_logo.png",
                    width: 160),
                const SizedBox(
                  width: 10,
                ),
                // const Spacer(), // Add this line
                TextButton(
                  onPressed: () async {
                    viewModel.checkBalance(context);
                  },
                  child: SemnoxText(
                    text: TranslationProvider.getTranslationBykey(
                        Messages.checkbalance),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),

                const Flexible(
                  child: ConnectionStatusIndicator(),
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: PopupMenuButton(
                    onSelected: (value) {
                      selectedItem = value.toString();
                      Navigator.pushNamed(context, value.toString());
                    },
                    itemBuilder: (BuildContext bc) {
                      return [
                        // Wrap the items in a list
                        PopupMenuItem(
                          child: GestureDetector(
                            child: Center(
                              child: SemnoxText(
                                text:
                                    // '${TranslationProvider.getTranslationBykey(Messages.loggedInUserName)}\n\n${viewModel.userId}',
                                    viewModel.userId ?? '--',
                                style: (AppThemes.names[DynamicTheme.of(context)
                                            ?.themeId] !=
                                        "Light"
                                    ? const TextStyle(
                                        color:
                                            Color.fromARGB(255, 151, 150, 150),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)
                                    : const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                              ),
                            ),
                          ),
                        ),
                        // PopupMenuItem(
                        //   child: GestureDetector(
                        //     child: Center(
                        //       child: Column(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: const [
                        //           AppVersionTag(
                        //             color: Color.fromARGB(255, 105, 105, 105),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        PopupMenuItem(
                          child: GestureDetector(
                            child: Center(
                              child: SemnoxText(
                                text: TranslationProvider.getTranslationBykey(
                                    Messages.settings),
                                style: (AppThemes.names[DynamicTheme.of(context)
                                            ?.themeId] !=
                                        "Light"
                                    ? const TextStyle(
                                        color: Colors.white, fontSize: 30)
                                    : const TextStyle(
                                        color: Colors.black, fontSize: 30)),
                              ),
                            ),
                            onTap: () {
                              viewModel.checkusermanagerAccess(
                                  AppRoutes.appsetting, () {
                                Utils().showNotManageralert(context);
                              });
                            },
                          ),
                        ),
                        PopupMenuItem(
                            child: Center(
                              child: SemnoxText(
                                text: TranslationProvider.getTranslationBykey(
                                    Messages.logout),
                                style: (AppThemes.names[DynamicTheme.of(context)
                                            ?.themeId] !=
                                        "Light"
                                    ? const TextStyle(
                                        color: Colors.white, fontSize: 30)
                                    : const TextStyle(
                                        color: Colors.black, fontSize: 30)),
                              ),
                            ),
                            onTap: () => viewModel.navigatetoLogin()),
                      ];
                    },
                  ),
                ),
              ],
            ),
            //),
          ),
          body: Stack(
            children: [
              (viewModel.canStartRide)
                  ? ListView(children: [
                      DataProviderBuilder<String?>(
                        dataProvider: viewModel.dataProvider.dataStream,
                        builder: (context, data) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SemnoxRideTapCard(
                              refreshbutton: true,
                              enableclosebutton: false,
                              title: TranslationProvider.getTranslationBykey(
                                  Messages.tapCard),
                              enableQrScan: viewModel.cardReader.canReadBarcode,
                              callback: (bool val) {
                                if (val == true) {
                                  viewModel.cardReader.startListening();
                                }
                              },
                            ),
                          );
                        },
                        loader: (context) {
                          return SemnoxElevatedCard(
                              child: SizedBox(
                            height: 200.mapToIdealWidth(context),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: SemnoxMenuButton(
                          menu: Container(
                            padding: EdgeInsets.zero,
                            color: SemnoxConstantColor.scaffoldBackground(
                                context), //Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 150.0),
                              child: Column(
                                children: [
                                  Flexible(
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            viewModel.availableMachines?.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, i) {
                                          var machine =
                                              viewModel.availableMachines![i];
                                          return SemnoxListTile(
                                            onPressed: () async {
                                              SemnoxMenuButton.closeMenu();
                                              await viewModel
                                                  .changeMachine(machine);
                                            },
                                            padding: EdgeInsets.all(
                                                30.mapToIdealWidth(context)),
                                            title: SemnoxText.h4(
                                              text: machine.machineName,
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              SemnoxText.h6(
                                  text: TranslationProvider.getTranslationBykey(
                                      Messages.selectgames),
                                  style: AppThemes.names[
                                              DynamicTheme.of(context)
                                                  ?.themeId] !=
                                          "Light"
                                      ? const TextStyle(
                                          fontSize: 35, color: Colors.white)
                                      : const TextStyle(
                                          fontSize: 35, color: Colors.black)),
                              SemnoxText.h6(
                                  text: viewModel.gameMachine?.machineName ??
                                      TranslationProvider.getTranslationBykey(
                                          Messages.startgames),
                                  style: AppThemes.names[
                                              DynamicTheme.of(context)
                                                  ?.themeId] !=
                                          "Light"
                                      ? const TextStyle(
                                          fontSize: 30, color: Colors.white)
                                      : const TextStyle(
                                          fontSize: 30, color: Colors.black)),
                              if (viewModel.availableMachines!.length > 1)
                                AppThemes.names[DynamicTheme.of(context)
                                            ?.themeId] !=
                                        "Light"
                                    ? const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          child: _SemnoxRectangleDetailCard(
                            rightTitle: TranslationProvider.getTranslationBykey(
                                Messages.vipPrice),
                            rightContent: viewModel.vipPlayCredits! > 0
                                ? viewModel.vipPlayCredits
                                        ?.formatToCurrencySymbol() ??
                                    "--"
                                : "--",
                            leftTitle: TranslationProvider.getTranslationBykey(
                                Messages.priceOrSeat),
                            leftContent: viewModel.playCredits! > 0
                                ? viewModel.playCredits
                                        ?.formatToCurrencySymbol() ??
                                    "--"
                                : "--",
                          )),
                      if (viewModel.gamePlayResult != null) ...{
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: SemnoxElevatedCard(
                              padding: EdgeInsets.zero,
                              child: GameplayResultInfo(
                                  result: viewModel.gamePlayResult!)),
                        )
                      }
                    ])
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SemnoxPadding.mediumSpace(context)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SemnoxText.h5(
                            text: TranslationProvider.getTranslationBykey(
                                Messages.nogamemachinemsg),
                            textAlign: TextAlign.center,
                          ),
                          // SemnoxFlatButton(
                          //   child: SemnoxText(
                          //     text: TranslationProvider.getTranslationBykey(
                          //         Messages.selectgamemachine),
                          //   ),
                          //   onPressed: () {
                          //     viewModel
                          //         .checkusermanagerAccess(AppRoutes.machines);
                          //   },
                          // )
                          SemnoxFlatButton(
                            child: SemnoxText(
                              text: TranslationProvider.getTranslationBykey(
                                  Messages.selectgamemachine),
                            ),
                            onPressed: () {
                              viewModel.checkusermanagerAccess(
                                  AppRoutes.machines, () {
                                Utils().showNotManageralert(context);
                              });
                            },
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ));
  }
}

class CardReaderDialog extends StatelessWidget {
  CardReaderDialog(
      {Key? key,
      SemnoxNFCReaderProperties? cardReader,
      bool autoCloseOnTap = false,
      required SemnoxTextFieldProperties? textread})
      : super(key: key) {
    cardFieldProperties = cardReader ?? SemnoxNFCReaderProperties();
    textFieldProperties = textread ?? SemnoxTextFieldProperties();

    if (autoCloseOnTap) {
      subscription = cardFieldProperties?.valueChangeStream.listen((event) {
        if (buildcontext != null && cardFieldProperties!.value.length >= 8) {
          Navigator.pop(buildcontext!, cardFieldProperties?.value);
          subscription?.cancel();
          subscription = null;
        }
      });
    }
  }

  SemnoxNFCReaderProperties? cardFieldProperties;
  SemnoxTextFieldProperties? textFieldProperties;
  BuildContext? buildcontext;
  StreamSubscription<String>? subscription;

  @override
  Widget build(BuildContext context) {
    buildcontext = context;
    return SemnoxElevatedCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NfcCardReader(
              cardproperties: cardFieldProperties!,
              textproperties: textFieldProperties!),
          SizedBox(
            width: double.maxFinite,
            child: SemnoxFlatButton(
              child: SemnoxText(
                text: TranslationProvider.getTranslationBykey(
                    Messages.checkbalance),
              ),
              onPressed: () {
                Navigator.pop(context, textFieldProperties?.value);
              },
            ),
          )
        ],
      ),
    );
  }

  Future<String?> show(BuildContext context) async {
    return showDialog<String?>(
        context: context,
        builder: (_) => Dialog(
              child: this,
            ));
  }
}

class _SemnoxRectangleDetailCard extends StatelessWidget {
  final String leftTitle;
  final String rightTitle;
  final String leftContent;
  final String rightContent;
  const _SemnoxRectangleDetailCard({
    Key? key,
    required this.leftTitle,
    required this.rightTitle,
    required this.leftContent,
    required this.rightContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.0.mapToIdealWidth(context)),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 90.mapToIdealHeight(context),
              child: SemnoxElevatedCard(
                padding: SemnoxPadding.zero,
                borderRadius: BorderRadius.circular(8.mapToIdealWidth(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SemnoxText.bodyMed1(text: leftTitle),
                        SemnoxText.subtitle(text: leftContent),
                      ],
                    ),
                    Container(
                      width: 1.mapToIdealWidth(context),
                      color: SemnoxConstantColor.grey(context),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SemnoxText.bodyMed1(text: rightTitle),
                        SemnoxText.subtitle(text: rightContent),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
