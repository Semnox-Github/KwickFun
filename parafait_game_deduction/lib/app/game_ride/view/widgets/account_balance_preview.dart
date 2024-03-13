import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox_core/modules/customer/accounts/provider/account_data_provider.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/dataprovider/data_provider.dart';
import 'package:semnox_core/utils/message.dart';
import 'balance_preview.dart';

class AccountBalancePreview extends ConsumerWidget {
  const AccountBalancePreview({
    Key? key,
    required this.notifier,
  }) : super(key: key);
  final DataProvider<AccountDataProvider> notifier;
  @override
  Widget build(BuildContext context, ref) {
    return DataProviderBuilder(
      dataProvider: notifier.dataStream,
      builder: (BuildContext context, AccountDataProvider? value) {
        if (value != null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              value.getAccountSummaryDto() != null
                  ? BalancePreview(repo: value, cardNo: value.getCardNo()!)
                  : const Center(
                      child: SemnoxText.subtitle(
                      text: Messages.invalidcard,
                      style: TextStyle(color: Colors.black),
                    ))
            ],
          );
        }
        return Center(child: SemnoxText(text: Messages.failedtofetchdetails));
      },
    );
  }
}
