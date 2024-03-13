import 'dart:async';
import 'dart:io';
import 'package:retry/retry.dart';
import 'package:semnox_core/modules/pos_machines/model/pos_machine_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/data_with_hash.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import '../../../../../utils/constants.dart';

class PosMachineViewService extends ModuleService {
  final r = const RetryOptions(maxAttempts: 3);
  PosMachineViewService(ExecutionContextDTO? executionContext)
      : super(executionContext);

  static final Map<PosMachineDTOSearchParameter, dynamic> _queryParams = {
    PosMachineDTOSearchParameter.hash: "hash",
    PosMachineDTOSearchParameter.rebuildCache: "rebuildCache",
    PosMachineDTOSearchParameter.siteId: "siteId"
  };

  Future<DataWithHash<List?>?> getPosMachines(
      {required Map<PosMachineDTOSearchParameter, dynamic>
          searchParams}) async {
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          .get(SemnoxConstants.posMachineContainerUrl,
              queryParameters:
                  await _constructContainerQueryParams(searchParams))
          .timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var rawData = response.data;
    if (response.data is! Map) {
      throw InvalidResponseException("Invalid Response.");
    }
    return rawData["data"] == null
        ? null
        : DataWithHash(
            data: rawData["data"]?["POSMachineContainerDTOList"],
            hash: rawData["data"]?["Hash"]);
  }

  Future<Map<String, dynamic>> _constructContainerQueryParams(
      Map<PosMachineDTOSearchParameter, dynamic> searchParams) async {
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
