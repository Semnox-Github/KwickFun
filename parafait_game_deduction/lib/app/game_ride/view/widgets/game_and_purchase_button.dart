import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_ride/app/game_ride/routes/module.dart';
import 'package:semnox_core/modules/customer/accounts/model/account_summary_dto.dart';
import 'package:semnox_core/modules/messages/provider/translation_provider.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import '../../provider/view_model/start_ride_view_model.dart';

class GameplayAndPurchaseButton extends ConsumerWidget {
  const GameplayAndPurchaseButton({
    Key? key,
    required this.cardNo,
    this.accountDto,
  }) : super(key: key);

  final String cardNo;
  final AccountSummaryViewDTO? accountDto;

  @override
  Widget build(BuildContext context, ref) {
    return Row(
      children: [
        SizedBox(width: 20.mapToIdealWidth(context)),
        Expanded(
            child: SemnoxFlatButton(
          child: SemnoxText(
              text: TranslationProvider.getTranslationBykey(Messages.gameplay)
                  .toUpperCase()),
          onPressed: () {
            ref.read(StartRideViewModel.provider).navigateToBalance(
                GameModule.gameHistory,
                cardNo: cardNo,
                accountDto: accountDto);
          },
        )),
        SizedBox(width: 20.mapToIdealWidth(context)),
        Expanded(
            child: SemnoxFlatButton(
          child: SemnoxText(
              text: TranslationProvider.getTranslationBykey(Messages.purchases)
                  .toUpperCase()),
          onPressed: () {
            ref.read(StartRideViewModel.provider).navigateToBalance(
                GameModule.purchaseHistory,
                cardNo: cardNo,
                accountDto: accountDto);
          },
        )),
        SizedBox(width: 20.mapToIdealWidth(context)),
      ],
    );
  }
}
