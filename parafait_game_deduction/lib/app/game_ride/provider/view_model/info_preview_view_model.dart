import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox_core/modules/customer/accounts/model/account_summary_dto.dart';
import 'package:semnox_core/modules/parafait_defaults_configuration/default_config_keys.dart';
import 'package:semnox_core/modules/parafait_defaults_configuration/provider/default_config.dart';

class AccountInfoPreviewViewModel extends ChangeNotifier {
  static final provider = ChangeNotifierProvider.family<
      AccountInfoPreviewViewModel, AccountSummaryViewDTO>((ref, dto) {
    return AccountInfoPreviewViewModel(ref, dto);
  });

  final ChangeNotifierProviderRef<AccountInfoPreviewViewModel> reference;
  final AccountSummaryViewDTO accountSummaryViewDTO;

  AccountInfoPreviewViewModel(this.reference, this.accountSummaryViewDTO);

  // ignore: library_private_types_in_public_api
  List<_Pair> getPairs(BuildContext context) {
    List<_Pair> pair = [];
// _pair.add(Pair(
//         title: "Name",
//         value: account.customerName ?? "",
//       ));
    if (_canShow(DefaultConfigKey.SHOW_MEMBERSHIP_ON_CARD)) {
      pair.add(_Pair(
        title: "Membership Type",
        value: accountSummaryViewDTO.membershipName ?? "",
      ));
    }

    if (_canShow(DefaultConfigKey.SHOW_CREDITS_ON_CARD)) {
      pair.add(_Pair(
        title: "Credits",
        value: (accountSummaryViewDTO.totalGamePlayCreditsBalance ?? "")
            .toString(),
      ));
    }

    if (_canShow(DefaultConfigKey.SHOW_BONUS_ON_CARD)) {
      pair.add(_Pair(
        title: "Bonus",
        value: (accountSummaryViewDTO.totalBonusBalance ?? "").toString(),
      ));
    }

    if (_canShow(DefaultConfigKey.SHOW_TICKETS_ON_CARD)) {
      pair.add(_Pair(
        title: "Tickets",
        value: (accountSummaryViewDTO.totalTicketsBalance ?? "").toString(),
      ));
    }

    if (_canShow(DefaultConfigKey.SHOW_COURTESY_ON_CARD)) {
      pair.add(_Pair(
        title: "Courtesy",
        value: (accountSummaryViewDTO.totalCourtesyBalance ?? "").toString(),
      ));
    }

    if (_canShow(DefaultConfigKey.SHOW_TIME_ON_CARD)) {
      pair.add(_Pair(
        title: "Time",
        value: (accountSummaryViewDTO.totalTimeBalance ?? "").toString(),
      ));
    }
    if (_canShow(DefaultConfigKey.SHOW_GAMES_ON_CARD)) {
      pair.add(_Pair(
        title: "Game",
        value: (accountSummaryViewDTO.totalGamesBalance ?? "").toString(),
      ));
    }
    if (_canShow(DefaultConfigKey.SHOW_LOYALTY_ON_CARD)) {
      pair.add(_Pair(
        title: "Loyalty Pts",
        value: (accountSummaryViewDTO.totalLoyaltyBalance ?? "").toString(),
      ));
    }
    // if (_canShow(DefaultConfigKey.SHOW_CARD_EXPIRY) &&
    //     DefaultConfigProvider.getConfigFor(DefaultConfigKey.CARD_EXPIRY_RULE) !=
    //         "NONE") {
    //   pair.add(_Pair(
    //     title: "Loyalty Pts",
    //     value: (accountSummaryViewDTO.expiryDate ?? "").toString(),
    //   ));
    // }

    return pair;
  }

  bool _canShow(String key) {
    return DefaultConfigProvider.getConfigFor(key) == "Y";
  }
}

class _Pair {
  String title;
  String value;
  _Pair({
    required this.title,
    required this.value,
  });
}
