import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox_core/modules/customer/accounts/model/account_summary_dto.dart';
import 'package:semnox_core/modules/messages/provider/translation_provider.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import '../../provider/view_model/start_ride_view_model.dart';
import 'account_info_preview.dart';
import 'card_preview.dart';
import 'game_and_purchase_button.dart';

class GamePlayResult {
  bool isSuccess;
  String? errorMessage;
  AccountSummaryViewDTO? accountDto;
  String cardNo;
  GamePlayResult({
    required this.isSuccess,
    this.errorMessage,
    this.accountDto,
    required this.cardNo,
  });

  static GamePlayResult success(AccountSummaryViewDTO? dto, String cardNo) {
    return GamePlayResult(isSuccess: true, accountDto: dto, cardNo: cardNo);
  }

  static GamePlayResult failed(String error, String cardNo) {
    return GamePlayResult(
        isSuccess: false, errorMessage: error, cardNo: cardNo);
  }
}

class GameplayResultInfo extends ConsumerWidget {
  const GameplayResultInfo({Key? key, required this.result}) : super(key: key);
  final GamePlayResult result;

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 100.mapToIdealHeight(context),
          decoration: BoxDecoration(
              color: result.isSuccess ? Colors.green : Colors.red),
          child: Center(
            child: SemnoxText.h4(
              text: result.isSuccess ? Messages.success : Messages.failed,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        if (result.errorMessage != null) ...{
          SizedBox(
            height: 30.mapToIdealHeight(context),
          ),
          SemnoxText.subtitle(
            text: result.errorMessage ?? Messages.nomessage,
          ),
        },
        SizedBox(
          height: 30.mapToIdealHeight(context),
        ),
        if (result.accountDto != null) ...[
          CardWidget(
            properties: CardWidgetProperties(
              cardNo: result.cardNo,
              name: result.accountDto?.customerName ?? "",
            ),
          ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.baseline,
          //   textBaseline: TextBaseline.alphabetic,
          //   children: [
          //     Expanded(
          //         child: SemnoxText.h5(
          //       text: "Card No:",
          //       textAlign: TextAlign.right,
          //     )),
          //     SizedBox(width: 20.mapToIdealWidth(context)),
          //     Expanded(
          //         child: SemnoxText.h6(
          //       text: "${result.cardNo}",
          //       style: TextStyle(fontWeight: FontWeight.normal),
          //     )),
          //   ],
          // ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 10.mapToIdealWidth(context)),
            child: AccountInfoPreview(
              account: result.accountDto!,
            ),
          ),
          SizedBox(
            height: 30.mapToIdealHeight(context),
          )
        ],

        result.accountDto != null
            ? GameplayAndPurchaseButton(
                cardNo: result.cardNo, accountDto: result.accountDto)
            : Container(),
        // Row(
        //   children: [
        //     SizedBox(width: 20.mapToIdealWidth(context)),
        //     Expanded(
        //         child: SemnoxFlatButton(
        //       child: SemnoxText(text: "Game Play"),
        //       onPressed: () {
        //         context.read(StartRideViewModel.provider).navigateToBalance(
        //             GameModule.gameHistory,
        //             cardNo: result.cardNo);
        //       },
        //     )),
        //     SizedBox(width: 20.mapToIdealWidth(context)),
        //     Expanded(
        //         child: SemnoxFlatButton(
        //       child: SemnoxText(text: "Purchases"),
        //       onPressed: () {
        //         context.read(StartRideViewModel.provider).navigateToBalance(
        //             GameModule.purchaseHistory,
        //             cardNo: result.cardNo);
        //       },
        //     )),
        //     SizedBox(width: 20.mapToIdealWidth(context)),
        //   ],
        // ),
        // SizedBox(
        //   height: 10.mapToIdealHeight(context),
        // ),
        Row(
          children: [
            SizedBox(width: 20.mapToIdealWidth(context)),
            Expanded(
                child: SemnoxFlatButton(
              child: SemnoxText(
                  text:
                      TranslationProvider.getTranslationBykey(Messages.newtext)
                          .toUpperCase()),
              onPressed: () {
                ref.refresh(StartRideViewModel.provider);
                // Navigator.pop(context);
              },
            )),
            SizedBox(width: 20.mapToIdealWidth(context)),
            Expanded(
                child: SemnoxFlatButton(
              child: SemnoxText(
                  text: TranslationProvider.getTranslationBykey(Messages.clear)
                      .toUpperCase()),
              onPressed: () {
                ref.read(StartRideViewModel.provider).clear();
                // Navigator.pop(context);
              },
            )),
            SizedBox(width: 20.mapToIdealWidth(context)),
          ],
        ),
        // SizedBox(
        //   height: 30.mapToIdealHeight(context),
        // ),
      ],
    );
  }
}
