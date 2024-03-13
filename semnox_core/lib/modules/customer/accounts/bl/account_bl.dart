import 'package:semnox_core/modules/customer/accounts/model/account_response_dto.dart';
import 'package:semnox_core/modules/customer/accounts/model/account_summary_dto.dart';
import 'package:semnox_core/modules/customer/accounts/repository/account_repository.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/utils/message.dart';

class AccountsBL {
  AccountSummaryViewDTO? _accountSummaryViewDTO;
  AccountRepository? _accountRepository;

  AccountsBL.id(ExecutionContextDTO? executionContextDTO, int? id) {
    _accountRepository = AccountRepository(executionContextDTO);
  }

  AccountsBL.dto(ExecutionContextDTO executionContextDTO,
      AccountSummaryViewDTO accountSummaryViewDTO) {
    _accountSummaryViewDTO = accountSummaryViewDTO;
    _accountRepository = AccountRepository(executionContextDTO);
  }

  AccountsBL(ExecutionContextDTO executionContextDTO) {
    _accountRepository = AccountRepository(executionContextDTO);
  }

  Future<AccountSummaryViewDTO?> getAccountByCardNo(
      {Map<AccountFilterParams, String>? params}) async {
    final accountDtoList =
        await _accountRepository?.getAccountDTOList(params: params);
    if (accountDtoList!.length > 1) {
      var dtolist = accountDtoList.where((i) => i.validFlag == true);
      if (dtolist.isNotEmpty) {
        _accountSummaryViewDTO = dtolist.first;
      }
    } else if (accountDtoList.length == 1) {
      var dtolist = accountDtoList.where((i) => i.validFlag == true);
      if (dtolist.isNotEmpty) {
        _accountSummaryViewDTO = accountDtoList.first;
      } else {
        throw BadRequestException(Messages.invalidcard);
      }
    }
    return _accountSummaryViewDTO;
  }
}
