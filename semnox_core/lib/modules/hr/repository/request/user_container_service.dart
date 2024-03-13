import 'dart:async';
import 'dart:io';
import 'package:retry/retry.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/hr/model/user_container_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/data_with_hash.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/utils/constants.dart';

class UserContainerService extends ModuleService {
  final r = const RetryOptions(maxAttempts: 3);
  UserContainerService(ExecutionContextDTO? executionContext)
      : super(executionContext);

  static final Map<UserContainerDTOSearchParameter, dynamic> _queryParams = {
    UserContainerDTOSearchParameter.HASH: "hash",
    UserContainerDTOSearchParameter.REBUILDCACHE: "rebuildCache",
    UserContainerDTOSearchParameter.SITEID: 'siteId'
  };

  Future<DataWithHash<List?>?> getUserContainer(
      {required Map<UserContainerDTOSearchParameter, dynamic>
          searchParams}) async {
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          //userContainerUrl replaced here
          .get(SemnoxConstants.userContainerUrl,
              queryParameters:
                  await _constructContainerQueryParams(searchParams))
          .timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    Map data = response.data;
    print('userRolenew:$data');
    return data["data"] == null
        ? null
        : DataWithHash(
            data: data["data"]["UserContainerDTOList"],
            hash: data["data"]["Hash"]);
  }

  Future<Map<String, dynamic>> _constructContainerQueryParams(
      Map<UserContainerDTOSearchParameter, dynamic> searchParams) async {
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
