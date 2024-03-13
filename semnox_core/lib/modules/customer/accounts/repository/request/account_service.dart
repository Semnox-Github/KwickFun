import 'package:semnox_core/modules/customer/accounts/model/account_activity_dto.dart';
import 'package:semnox_core/modules/customer/accounts/model/account_response_dto.dart';
import 'package:semnox_core/modules/customer/accounts/model/account_summary_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/utils/constants.dart';

class AccountService extends ModuleService {
  AccountService(ExecutionContextDTO? executionContext)
      : super(executionContext);

  Future<List<AccountSummaryViewDTO>> getAccounts(
      {Map<AccountFilterParams, dynamic>? params}) async {
    final response = await server.call()!.get(
          SemnoxConstants.accountSummaryUrl,
          queryParameters: params != null ? _convertToQueryParam(params) : null,
        );

    Map data = response.data;
    List<AccountSummaryViewDTO> dtos = [];
    List rawList = data["data"] ?? [];
    for (var item in rawList) {
      dtos.add(AccountSummaryViewDTO.fromJson(item));
    }
    return dtos;
  }

  Future<List<AccountActivityDto>> getAccountActivity({int? accountId}) async {
    final response = await server
        .call()!
        .get("/api/Customer/Account/$accountId/AccountActivity");

    Map data = response.data;

    if (data is! Map) throw InvalidResponseException();

    List<AccountActivityDto> dtos = [];
    List rawList = data["data"] ?? [];
    for (var item in rawList) {
      dtos.add(AccountActivityDto.fromMap(item));
    }

    return dtos;
  }

  Map<String, String> _convertToQueryParam(
      Map<AccountFilterParams, dynamic> params) {
    Map<String, String> converted = {};

    for (var element in params.keys) {
      converted[element.name] = params[element]!.toString();
    }

    return converted;
  }
}
