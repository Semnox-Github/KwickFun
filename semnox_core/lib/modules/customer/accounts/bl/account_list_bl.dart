import 'package:semnox_core/modules/customer/accounts/model/account_activity_dto.dart';
import 'package:semnox_core/modules/customer/accounts/repository/account_repository.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

class AccountListBL {
  AccountRepository? _accountRepository;
  AccountListBL(ExecutionContextDTO? executionContextDTO) {
    _accountRepository = AccountRepository(executionContextDTO!);
  }

  Future<List<AccountActivityDto>> getAccountActivityDTOList(
      {int? accountId}) async {
    final response = await _accountRepository?.getAccountActivityDTOList(
        accountId: accountId);
    return response ?? [];
  }
}
