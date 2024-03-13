import 'dart:async';
import 'dart:io';

import 'package:retry/retry.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/hr/model/user_role_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/utils/index.dart';

class UserRoleService extends ModuleService {
  final r = const RetryOptions(maxAttempts: 3);
  // ExecutionContextDTO? _executionContextDTO;

  UserRoleService(ExecutionContextDTO? executionContext)
      : super(executionContext);

  static final Map<UserRoleViewDTOSearchParameter, dynamic> _queryParams = {
    UserRoleViewDTOSearchParameter.rebuildCache: "rebuildCache",
    UserRoleViewDTOSearchParameter.siteId: 'siteId'
  };

  Future<List?> getUserRoleDTOList(
      Map<UserRoleViewDTOSearchParameter, dynamic> params) async {
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          //userRoleUrl
          //need to be replced by UserRoleContainer
          .get(SemnoxConstants.userRoleContainerUrl,
              queryParameters: await _constructContainerQueryParams(params))
          .timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    Map data = response.data;
    if (response.data is! Map) {
      throw InvalidResponseException("Invalid Response.");
    }
    print('fromuserRoleContainerUrl: $data');
    // Extract the list from the returned data
    return data["data"]?["UserRoleContainerDTOList"] ?? [];
  }

  Future<Map<String, dynamic>> _constructContainerQueryParams(
      Map<UserRoleViewDTOSearchParameter, dynamic> searchParams) async {
    Map<String, dynamic> queryparameter = {};

    _queryParams.forEach((key, value) {
      var valu = searchParams[key];
      if (valu != null) {
        queryparameter.addAll({value: valu});
      }
    });
    return queryparameter;
  }
}
