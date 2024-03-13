import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:semnox_core/modules/customer/accounts/provider/account_data_provider.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/utils/dataprovider/data_provider.dart';

class AccountHistoryViewModel extends ChangeNotifier {
  static final provider = ChangeNotifierProvider.autoDispose
      .family<AccountHistoryViewModel, String>((ref, id) {
    return AccountHistoryViewModel(
      cardNo: id,
    );
  });
  ExecutionContextDTO? executionContext;
  final String cardNo;
  AccountHistoryViewModel({
    required this.cardNo,
  }) {
    initializeDateFormatting();
    fetchAccount();
  }

  DataProvider<AccountDataProvider> accountDtoProvider =
      DataProvider<AccountDataProvider>();

  void fetchAccount() async {
    executionContext = await ExecutionContextProvider().getExecutionContext();
    accountDtoProvider.handleFuture(AccountDataProvider.fromCardNo(
      executionContext!,
      cardNo,
      buildActivityHistory: true,
      buildChildRecords: true,
      buildGamePlayHistory: true,
    ));
  }
}
