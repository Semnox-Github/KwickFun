import 'package:semnox_core/modules/customer/accounts/bl/account_list_bl.dart';
import 'package:semnox_core/modules/customer/accounts/model/account_activity_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

class AccountActivityDataProvider {
  List<AccountActivityDto>? _accountActivityListDTO;
  ExecutionContextDTO? _executionContextDTO;

  AccountActivityDataProvider(
      {ExecutionContextDTO? executionContextDTO,
      List<AccountActivityDto>? accountActivityListDTO}) {
    _accountActivityListDTO = accountActivityListDTO;
    _executionContextDTO = executionContextDTO;
  }

  Future<AccountActivityDataProvider> getAccountActivityDTOList(
      {int? accountId}) async {
    _accountActivityListDTO = await AccountListBL(_executionContextDTO)
        .getAccountActivityDTOList(accountId: accountId);
    return AccountActivityDataProvider(
        accountActivityListDTO: _accountActivityListDTO ?? []);
  }

  List<AccountActivityDto>? getAccountActivityListDTO() {
    return _accountActivityListDTO;
  }
}
