import 'dart:async';
import 'dart:io';

import 'package:retry/retry.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/asset_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/utils/constants.dart';

class AssetsGenericService extends ModuleService {
  final r = const RetryOptions(maxAttempts: 3);
  AssetsGenericService(ExecutionContextDTO executionContext)
      : super(executionContext);
  static final Map<AssetsGenericDTOSearchParameter, dynamic> _queryParams = {
    AssetsGenericDTOSearchParameter.ISACTIVE: "isActive",
    AssetsGenericDTOSearchParameter.ASSETTYPE: "assetType",
    AssetsGenericDTOSearchParameter.FIRSTNAME: "firstName",
    AssetsGenericDTOSearchParameter.URN: "urn",
    AssetsGenericDTOSearchParameter.ASSETSTATUS: "assetStatus",
    AssetsGenericDTOSearchParameter.LOCATION: "location",
    AssetsGenericDTOSearchParameter.BUILDASSETDETAILED: "buildAssetDetailed",
    AssetsGenericDTOSearchParameter.BUILDASSETLIMITED: "buildAssetLimited"
  };

  Future<List<GenericAssetDTO>> getGenericAssetList(
      Map<AssetsGenericDTOSearchParameter, dynamic> searchParams) async {
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          .get(SemnoxConstants.genericassetUrl,
              queryParameters:
                  await _constructContainerQueryParams(searchParams))
          .timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var data = response.data;
    if (data is! Map) throw AppException("Invalid response.");
    List<GenericAssetDTO> dtos = [];
    if (data["data"] != null) {
      List rawList = data["data"];
      for (var item in rawList) {
        dtos.add(GenericAssetDTO.fromMap(item));
      }
    }
    return dtos;
  }

  Future<Map<String, dynamic>> _constructContainerQueryParams(
      Map<AssetsGenericDTOSearchParameter, dynamic> searchParams) async {
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
