import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_ride/app/game_ride/provider/view_model/account_activity_view_model.dart';
import 'package:game_ride/app/game_ride/provider/view_model/gameplay_view_model.dart';
import 'package:semnox_core/modules/customer/accounts/model/account_summary_dto.dart';
import 'package:semnox_core/modules/messages/provider/translation_provider.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';

class SemnoxPurchasesScreen extends ConsumerWidget {
  final String cardNo;
  final AccountSummaryViewDTO accountsummaryDTO;
  const SemnoxPurchasesScreen({
    Key? key,
    required this.cardNo,
    required this.accountsummaryDTO,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ref
        .watch(AccountActivityViewModel.provider(accountsummaryDTO.accountId!));
    viewModel.context = context;
    return SemnoxScaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //   },
      //   child: Icon(Icons.thumb_up),
      //   backgroundColor: Colors.pink,
      // ),
      bodyPadding: SemnoxPadding.zero,
      appBar: SemnoxAppBar(
        // automaticallyImplyLeading: false,
        title: SemnoxText.h4(
          text:
              "${TranslationProvider.getTranslationBykey(Messages.purchaseof)} $cardNo",
          style: const TextStyle(color: Colors.white),
        ),
        actions: const [
          // Padding(
          //   padding: EdgeInsets.all(32.mapToIdealWidth(context)),
          //   child: SemnoxIcons.creditCard
          //       .toIcon(size: 32.mapToIdealWidth(context)),
          // )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DataProviderBuilder(
            dataProvider: viewModel.accountactivityProvider.dataStream,
            builder: (context, snapshot) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.75),
                    width:
                        (SemnoxSizing.IdealWidth * 2).mapToIdealWidth(context),
                    child: SemnoxTable(
                        // physics: BouncingScrollPhysics(),
                        bodyBackgroundColor: SemnoxConstantColor.cardForeground(
                            context), // Colors.white,
                        title: <SemnoxTableHeadder>[
                          SemnoxTableHeadder(
                              label: TranslationProvider.getTranslationBykey(
                                  Messages.date)),
                          SemnoxTableHeadder(
                              label: TranslationProvider.getTranslationBykey(
                                  Messages.product),
                              flex: 2),
                          SemnoxTableHeadder(
                              label: TranslationProvider.getTranslationBykey(
                                  Messages.amount)),
                          SemnoxTableHeadder(
                              label: TranslationProvider.getTranslationBykey(
                                  Messages.credit)),
                          SemnoxTableHeadder(
                              label: TranslationProvider.getTranslationBykey(
                                  Messages.bonus)),
                          SemnoxTableHeadder(
                              label: TranslationProvider.getTranslationBykey(
                                  Messages.courtesy)),
                          SemnoxTableHeadder(
                              label: TranslationProvider.getTranslationBykey(
                                  Messages.tickets)),
                        ],
                        rowBuilder: (BuildContext context, int index) {
                          final data = viewModel.activityHistory[index];
                          return [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SemnoxText.bodyReg1(
                                    text: data.date != null
                                        ? DateFormat("dd/MM/yyyy")
                                            .format(DateTime.parse(data.date!))
                                        : ""),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 4.mapToIdealHeight(context)),
                                  child: SemnoxText.bodyReg2(
                                      text: data.date != null
                                          ? DateFormat("hh:mm a").format(
                                              DateTime.parse(data.date!))
                                          : ""),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              child: SemnoxText.bodyReg1(
                                  text: data.product ?? "--"),
                            ),
                            SemnoxText.bodyReg1(
                                text: data.amount?.toString() ?? "--"),
                            SemnoxText.bodyReg1(
                                text: data.credits?.toString() ?? ""),
                            SemnoxText.bodyReg1(
                                text: data.bonus?.toString() ?? "--"),
                            SemnoxText.bodyReg1(
                                text: data.courtesy?.toString() ?? "--"),
                            SemnoxText.bodyReg1(
                                text: data.tickets?.toString() ?? "--"),
                          ];
                        },
                        itemCount: viewModel.activityHistory.length),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class SemnoxGameHistoryScreen extends ConsumerWidget {
  final String cardNo;
  final AccountSummaryViewDTO accountsummaryDTO;
  const SemnoxGameHistoryScreen({
    Key? key,
    required this.cardNo,
    required this.accountsummaryDTO,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final viewModel =
        ref.watch(GamePlayViewModel.provider(accountsummaryDTO.accountId!));
    viewModel.context = context;
    return SemnoxScaffold(
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: SemnoxConstantColor.appbarBackground(context),
      //   foregroundColor: Colors.black,
      //   onPressed: () {
      //     // Respond to button press
      //   },
      //   child: const Icon(Icons.keyboard_arrow_right_sharp),
      // ),
      // bodyPadding: SemnoxPadding.zero,
      appBar: SemnoxAppBar(
        // automaticallyImplyLeading: false,
        title: SemnoxText.h4(
          text: "Game Play Of $cardNo",
          style: const TextStyle(color: Colors.white),
        ),
        actions: const [
          // Padding(
          //   padding: EdgeInsets.all(32.mapToIdealWidth(context)),
          //   child: SemnoxIcons.creditCard
          //       .toIcon(size: 32.mapToIdealWidth(context)),
          // )
        ],
      ),
      body: DataProviderBuilder(
          dataProvider: viewModel.gameplayprovider.dataStream,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.75),
                  width: (SemnoxSizing.IdealWidth * 3).mapToIdealWidth(context),
                  child: SemnoxTable(
                      physics: const BouncingScrollPhysics(),
                      bodyBackgroundColor:
                          SemnoxConstantColor.cardForeground(context),
                      title: <SemnoxTableHeadder>[
                        SemnoxTableHeadder(
                            label: TranslationProvider.getTranslationBykey(
                                Messages.date)),
                        SemnoxTableHeadder(
                            label: TranslationProvider.getTranslationBykey(
                                Messages.game)),
                        // SemnoxTableHeadder(label: "Amount"),
                        SemnoxTableHeadder(
                            label: TranslationProvider.getTranslationBykey(
                                Messages.credit)),
                        SemnoxTableHeadder(
                            label: TranslationProvider.getTranslationBykey(
                                Messages.bonus)),
                        SemnoxTableHeadder(
                            label: TranslationProvider.getTranslationBykey(
                                Messages.courtesy)),
                        //added by shobith
                        SemnoxTableHeadder(
                            label: TranslationProvider.getTranslationBykey(
                                Messages.time)),
                        SemnoxTableHeadder(
                            label: TranslationProvider.getTranslationBykey(
                                Messages.cardGame)),
                        SemnoxTableHeadder(
                            label: TranslationProvider.getTranslationBykey(
                                Messages.cpCardBalance)),
                        SemnoxTableHeadder(
                            label: TranslationProvider.getTranslationBykey(
                                Messages.cpCredits)),
                        SemnoxTableHeadder(
                            label: TranslationProvider.getTranslationBykey(
                                Messages.cpBonus)),
                        SemnoxTableHeadder(
                            label: TranslationProvider.getTranslationBykey(
                                Messages.tickets)),
                      ],
                      rowBuilder: (BuildContext context, int index) {
                        final data = viewModel.gameplayHistory[index];
                        return [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SemnoxText.bodyReg1(
                                  text: data.playDate != null
                                      ? DateFormat("dd/MM/yyyy").format(
                                          DateTime.parse(data.playDate!))
                                      : ""),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 4.mapToIdealHeight(context)),
                                child: SemnoxText.bodyReg2(
                                    text: data.playDate != null
                                        ? DateFormat("hh:mm a").format(
                                            DateTime.parse(data.playDate!))
                                        : ""),
                              ),
                            ],
                          ),
                          // SemnoxText.bodyReg1(text: "Variable"),
                          SemnoxText.bodyReg1(text: data.game ?? "--"),
                          SemnoxText.bodyReg1(
                              text: data.credits?.toString() ?? "--"),
                          SemnoxText.bodyReg1(
                              text: data.bonus?.toString() ?? ""),
                          SemnoxText.bodyReg1(
                              text: data.courtesy?.toString() ?? ""),
                          SemnoxText.bodyReg1(
                              text: data.time?.toString() ?? ""),
                          SemnoxText.bodyReg1(
                              text: data.cardGame?.toString() ?? ""),
                          SemnoxText.bodyReg1(
                              text: data.cpCardBalance?.toString() ?? ""),
                          SemnoxText.bodyReg1(
                              text: data.cpCredits?.toString() ?? ""),
                          SemnoxText.bodyReg1(
                              text: data.cpBonus?.toString() ?? ""),
                          SemnoxText.bodyReg1(
                              text: data.ticketCount?.toString() ?? ""),
                        ];
                      },
                      itemCount: viewModel.gameplayHistory.length),
                ),
              ),
            );
          }),
    );
  }
}
