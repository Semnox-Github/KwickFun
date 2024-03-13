import 'dart:async';
import 'dart:io';
import 'package:retry/retry.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/data_with_hash.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/utils/constants.dart';

class SiteViewService extends ModuleService {
  final r = const RetryOptions(maxAttempts: 3);
  SiteViewService(ExecutionContextDTO? executionContext)
      : super(executionContext);

  static final Map<SiteViewDTOSearchParameter, dynamic> _queryParams = {
    SiteViewDTOSearchParameter.hash: "hash",
    SiteViewDTOSearchParameter.rebuildcache: "rebuildCache"
  };

  Future<DataWithHash<List>?> getSites(
      {required Map<SiteViewDTOSearchParameter, dynamic> searchParams}) async {
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          .get(SemnoxConstants.siteContainerUrl,
              queryParameters:
                  await _constructContainerQueryParams(searchParams))
          .timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    Map data = await response.data;
    if (response.data is! Map) {
      throw InvalidResponseException("Invalid Response.");
    }
    return data["data"] == null
        ? null
        : DataWithHash(
            data: data["data"]["SiteContainerDTOList"],
            hash: data["data"]["Hash"]);
  }

  Future<Map<String, dynamic>> _constructContainerQueryParams(
      Map<SiteViewDTOSearchParameter, dynamic> searchParams) async {
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
