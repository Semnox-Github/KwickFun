import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox_core/modules/customer/accounts/model/account_summary_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import '../../provider/view_model/info_preview_view_model.dart';

class AccountInfoPreview extends ConsumerWidget {
  const AccountInfoPreview({Key? key, required this.account}) : super(key: key);
  final AccountSummaryViewDTO account;
  @override
  Widget build(BuildContext context, ref) {
    return GridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300.mapToIdealWidth(context),
          childAspectRatio: 1.7),
      children: ref
          .watch(AccountInfoPreviewViewModel.provider(account))
          .getPairs(context)
          .map((e) {
        return getPair(e.title, e.value, context);
      }).toList(),
      // [
      // getPair("Membership Type", account.membershipName ?? "", context),
      // // Row(
      // //   children: [
      //     getPair(
      //         "Credits",
      //         account.accountSummaryDto
      //                 ?.formattedTotalGamePlayCreditsBalance ??
      //             "",
      //         context),
      //     getPair(
      //         "Bonus",
      //         account.accountSummaryDto?.formattedTotalBonusBalance ?? "",
      //         context),
      //     getPair(
      //         "Tickets",
      //         account.accountSummaryDto?.totalTicketsBalance
      //                 ?.toString() ??
      //             "",
      //         context),
      //   // ],
      // // ),

      // // Row(
      // //   children: [
      //     getPair(
      //         "Courtesy",
      //         account.accountSummaryDto?.formattedTotalCourtesyBalance ??
      //             "",
      //         context),
      //     getPair(
      //         "Time",
      //         account.accountSummaryDto?.formattedTotalTimeBalance ?? "",
      //         context),
      //     getPair(
      //         "Loyalty Pts",
      //         account.accountSummaryDto
      //                 ?.formattedTotalLoyaltyPointBalance ??
      //             "",
      //         context),
      // //   ],
      // // ),
      // getPair("Issue Date", account.issueDate?.fromatToDate(context) ?? "", context),
      // getPair("Name", account.customerName ?? "", context),
      // getPair(
      //     "Credit Plus",
      //     account.accountSummaryDto?.formattedCreditPlusCardBalance ?? "",
      //     context),
      // getPair(
      //     "Game Count",
      //     account.accountSummaryDto?.formattedTotalGamesBalance ?? "",
      //     context),
      // getPair(
      //     "Used Credits",
      //     account.accountSummaryDto?.formattedCreditPlusGamePlayCredits ?? "",
      //     context),
      // ],
    );
  }

  Widget getPair(String title, String data, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SemnoxElevatedCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.baseline,
          // textBaseline: TextBaseline.alphabetic,
          children: [
            SemnoxText.bodyMed1(
              text: data,
              style:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 30),
            ),
            SizedBox(width: 20.mapToIdealWidth(context)),
            SemnoxText(
              text: title.isEmpty ? "-" : title,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
