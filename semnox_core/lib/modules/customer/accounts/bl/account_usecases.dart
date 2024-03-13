// import 'package:semnox_core/modules/customer/accounts/bl/account_list_bl.dart';
// import 'package:semnox_core/modules/customer/accounts/model/account_dto.dart';
// import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
// import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';

// class AccountUseCases {
//   ExecutionContextDTO? _executionContextDTO;

//   AccountUseCases(
//       {ExecutionContextDTO? executionContextDTO, AccountDto? data}) {
//     _executionContextDTO = executionContextDTO;
//   }

//   Future<List<AccountDto>> getAccountByCardNo(String cardNo) async {
//     final accountsDTO =
//         await AccountListBL(_executionContextDTO).getAccountDTOList(cardNo);
//     if (accountsDTO!.isEmpty) {
//       throw AppException("No Account Found With $cardNo");
//     }
//     if (accountsDTO.length > 1) {
//       throw AppException("duplicate Account found");
//     }

//     //AccountSummaryView API should be called to validate the card or account

//     return accountsDTO;
//   }
// }
