import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/asset_type_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/repository/asset_type_repositories.dart';

class AssetTypesBL {
  late AssetTypesRepositories _assetTypesRepositories;
  late ExecutionContextDTO? _executionContext;

  AssetTypesBL.id(ExecutionContextDTO executionContext, int id) {
    _executionContext = executionContext;
    _assetTypesRepositories = AssetTypesRepositories(_executionContext!);
  }

  AssetTypesBL.dto(
      ExecutionContextDTO executionContext, AssetTypesDTO assetTypesDTO) {
    _executionContext = executionContext;
    _assetTypesRepositories = AssetTypesRepositories(_executionContext!);
  }
}

class AssetTypesListBL {
  late ExecutionContextDTO _executionContext;
  late AssetTypesRepositories _assetTypesRepositories;
  AssetTypesListBL(ExecutionContextDTO executionContext) {
    _executionContext = executionContext;
    _assetTypesRepositories = AssetTypesRepositories(_executionContext);
  }

  Future<List<AssetTypesDTO>> assetsTypeDTOList(
      Map<AssetsTypesDTOSearchParameter, dynamic>
          assetGroupsSearchParams) async {
    List<AssetTypesDTO> assetTypesDTO = await _assetTypesRepositories
        .getAssetTypesDTOList(assetGroupsSearchParams);
    return assetTypesDTO;
  }
}
