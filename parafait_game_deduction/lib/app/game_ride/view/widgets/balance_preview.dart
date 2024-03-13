import 'package:flutter/material.dart';
import 'package:semnox_core/modules/customer/accounts/provider/account_data_provider.dart';
import 'package:semnox_core/semnox_core.dart';
import 'account_info_preview.dart';
import 'game_and_purchase_button.dart';

class BalancePreview extends StatelessWidget {
  const BalancePreview({
    Key? key,
    required this.repo,
    required this.cardNo,
  }) : super(key: key);

  final AccountDataProvider repo;
  final String cardNo;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            padding:
                EdgeInsets.symmetric(vertical: 20.mapToIdealWidth(context)),
            child: Center(
              child: SemnoxText.h4(
                text: "Balance Of $cardNo",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          getPair(
              "Name", "${repo.getAccountSummaryDto()?.customerName}", context),
          SizedBox(height: 20.mapToIdealWidth(context)),
          AccountInfoPreview(account: repo.getAccountSummaryDto()!),
          SizedBox(height: 20.mapToIdealWidth(context)),
          GameplayAndPurchaseButton(
              cardNo: cardNo, accountDto: repo.getAccountSummaryDto()),
        ],
      ),
    );
  }

  Widget getPair(String title, String data, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SemnoxElevatedCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SemnoxText.subtitle(
              text: data,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
            SizedBox(width: 20.mapToIdealWidth(context)),
            SemnoxText(
              text: title,
              textAlign: TextAlign.right,
              style:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
