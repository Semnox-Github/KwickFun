import 'dart:async';
import 'dart:io';
import 'package:retry/retry.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/messages/model/translation_view_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/data_with_hash.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/utils/constants.dart';

class TranslationService extends ModuleService {
  final r = const RetryOptions(maxAttempts: 3);
  TranslationService(ExecutionContextDTO? executionContext)
      : super(executionContext);

  static final Map<TranslationViewDTOSearchParameter, dynamic> _queryParams = {
    TranslationViewDTOSearchParameter.HASH: "hash",
    TranslationViewDTOSearchParameter.REBUILDCACHE: "rebuildCache",
    TranslationViewDTOSearchParameter.LANGUAGEID: "languageId",
    TranslationViewDTOSearchParameter.SITEID: "siteId"
  };

  Future<DataWithHash<List?>?> gettranslation(
      {required Map<TranslationViewDTOSearchParameter, dynamic>
          searchParams}) async {
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          .get(SemnoxConstants.translationUrl,
              queryParameters:
                  await _constructContainerQueryParams(searchParams))
          .timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    Map data = response.data;
    var temp = data["data"]["MessageContainerDTOList"];
    print('MessageContainerData:$temp');
    if (response.data is! Map) {
      throw InvalidResponseException("Invalid Response.");
    }
    return data["data"] == null
        ? null
        : DataWithHash(
            data: data["data"]["MessageContainerDTOList"],
            hash: data["data"]["Hash"]);
  }

  Future<Map<String, dynamic>> _constructContainerQueryParams(
      Map<TranslationViewDTOSearchParameter, dynamic> searchParams) async {
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
