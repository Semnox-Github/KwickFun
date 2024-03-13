import 'package:semnox_core/modules/customer/accounts/bl/account_bl.dart';
import 'package:semnox_core/modules/customer/accounts/model/account_response_dto.dart';
import 'package:semnox_core/modules/customer/accounts/model/account_summary_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

class AccountDataProvider {
  static AccountSummaryViewDTO? _accountSummaryViewDTO;
  static String? _cardNo;

  AccountDataProvider(
      {AccountSummaryViewDTO? accountSummaryViewDTO, String? cardNo}) {
    _accountSummaryViewDTO = accountSummaryViewDTO;
    _cardNo = cardNo;
  }

  static Future<AccountDataProvider> fromCardNo(
    ExecutionContextDTO executionContextDTO,
    String cardNo, {
    bool buildChildRecords = true,
    bool buildActivityHistory = true,
    bool buildGamePlayHistory = true,
  }) async {
    _accountSummaryViewDTO =
        await AccountsBL(executionContextDTO).getAccountByCardNo(params: {
      AccountFilterParams.accountNumber: cardNo.toString(),
      AccountFilterParams.buildActivityHistory: buildActivityHistory.toString(),
      AccountFilterParams.buildGamePlayHistory: buildGamePlayHistory.toString(),
      AccountFilterParams.buildChildRecords: buildChildRecords.toString(),
    });
    return AccountDataProvider(
        accountSummaryViewDTO: _accountSummaryViewDTO, cardNo: cardNo);
  }

  AccountSummaryViewDTO? getAccountSummaryDto() {
    return _accountSummaryViewDTO;
  }

  String? getCardNo() {
    return _cardNo;
  }
}
