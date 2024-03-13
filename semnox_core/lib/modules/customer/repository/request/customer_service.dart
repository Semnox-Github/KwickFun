import 'dart:async';
import 'dart:io';
import 'package:retry/retry.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/utils/constants.dart';

class CustomerService extends ModuleService {
  final r = const RetryOptions(maxAttempts: 3);
  CustomerService(ExecutionContextDTO? executionContext)
      : super(executionContext);

  static final Map<CustomerDTOSearchParameter, dynamic> _queryParams = {
    CustomerDTOSearchParameter.customerId: "customerId",
    CustomerDTOSearchParameter.contactNumber: "contactNumber",
    CustomerDTOSearchParameter.emailId: "emailId",
    CustomerDTOSearchParameter.firstName: "firstName",
    CustomerDTOSearchParameter.lastName: "lastName",
    CustomerDTOSearchParameter.fromDate: "fromDate",
    CustomerDTOSearchParameter.toDate: "toDate",
    CustomerDTOSearchParameter.pageNumber: "pageNumber",
    CustomerDTOSearchParameter.pageSize: "pageSize",
    CustomerDTOSearchParameter.buildChildRecords: "buildChildRecords",
    CustomerDTOSearchParameter.activeRecordsOnly: "activeRecordsOnly",
    CustomerDTOSearchParameter.profilePic: "profilePic",
    CustomerDTOSearchParameter.idPic: "idPic",
    CustomerDTOSearchParameter.buildActiveCampaignActivity:
        "buildActiveCampaignActivity",
    CustomerDTOSearchParameter.loadSignedWaiverFileContent:
        "loadSignedWaiverFileContent",
    CustomerDTOSearchParameter.loadSignedWaivers: "loadSignedWaivers",
    CustomerDTOSearchParameter.loadAdultOnly: "loadAdultOnly",
    CustomerDTOSearchParameter.buildLastVistitedDate: "buildLastVistitedDate",
    CustomerDTOSearchParameter.customerGUID: "customerGUID",
    CustomerDTOSearchParameter.customerMembershipId: "customerMembershipId",
    CustomerDTOSearchParameter.uniqueIdentifier: "uniqueIdentifier",
    CustomerDTOSearchParameter.middleName: "middleName",
    CustomerDTOSearchParameter.phoneOrEmail: "phoneOrEmail",
  };

  Future<List<CustomerDTO>?> getCustomerDTOList(
      {required Map<CustomerDTOSearchParameter, dynamic> searchParams}) async {
    APIResponse response = await r.retry(
      () async => server
          .call()!
          .get(SemnoxConstants.customersUrl,
              queryParameters:
                  await _constructContainerQueryParams(searchParams))
          .timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    Map data = response.data;
    if (response.data is! Map) {
      throw InvalidResponseException("Invalid Response.");
    }
    List<CustomerDTO> dtos = [];
    if (data["data"] != null) {
      List rawItems = data["data"];
      for (var item in rawItems) {
        dtos.add(CustomerDTO.fromJson(item));
      }
    }
    return dtos;
  }

  Future<Map<String, dynamic>> _constructContainerQueryParams(
      Map<CustomerDTOSearchParameter, dynamic> searchParams) async {
    Map<String, dynamic> queryparameter = {};

    _queryParams.forEach((key, value) {
      var valu = searchParams[key];
      if (valu != null) {
        queryparameter.addAll({value: valu});
      }
    });
    return queryparameter;
  }

  Future<bool> login(Map<String, dynamic> customerLoginRequestDTO) async {
    try {
      APIResponse response = await r.retry(
        () async => await server
            .call()!
            .post(SemnoxConstants.customerLoginUrl, customerLoginRequestDTO)
            .timeout(const Duration(seconds: 10)),
        // Retry on SocketException or TimeoutException
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
      return response.data != null;
      // ignore: empty_catches
    } catch (e) {}
    return false;
  }
}
