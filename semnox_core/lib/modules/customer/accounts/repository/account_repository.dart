import 'package:semnox_core/modules/customer/accounts/model/account_activity_dto.dart';
import 'package:semnox_core/modules/customer/accounts/model/account_response_dto.dart';
import 'package:semnox_core/modules/customer/accounts/model/account_summary_dto.dart';
import 'package:semnox_core/modules/customer/accounts/repository/request/account_service.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

class AccountRepository {
  AccountService? _accountService;
  AccountRepository(ExecutionContextDTO? executionContextDTO) {
    _accountService = AccountService(executionContextDTO);
  }

  Future<List<AccountSummaryViewDTO>> getAccountDTOList(
      {Map<AccountFilterParams, String>? params}) async {
    final response = await _accountService?.getAccounts(params: params);
    return response ?? [];
  }

  Future<List<AccountActivityDto>> getAccountActivityDTOList(
      {int? accountId}) async {
    final response =
        await _accountService?.getAccountActivity(accountId: accountId);
    return response ?? [];
  }
}
