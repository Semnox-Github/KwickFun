import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/assetgroup_Assets_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/repository/assetsgroup_assets_repositories.dart';

class AssetGroupAssetsBL {
  AssetGroupAssetsRepositories? _assetGroupAssetsRepositories;
  AssetGroupAssetsDto? _assetGroupAssetsDto;
  ExecutionContextDTO? _executionContextDTO;

  AssetGroupAssetsBL.id(ExecutionContextDTO executionContext, int id) {
    _executionContextDTO = executionContext;
    _assetGroupAssetsRepositories =
        AssetGroupAssetsRepositories(_executionContextDTO);
  }

  AssetGroupAssetsBL.dto(ExecutionContextDTO executionContext,
      AssetGroupAssetsDto assetGroupAssetsDto) {
    _executionContextDTO = executionContext;
    _assetGroupAssetsDto = assetGroupAssetsDto;
    _assetGroupAssetsRepositories =
        AssetGroupAssetsRepositories(_executionContextDTO);
  }
}

class AssetGroupAssetsListBL {
  late ExecutionContextDTO _executionContextDTO;
  late AssetGroupAssetsRepositories? _assetGroupAssetsRepositories;
  AssetGroupAssetsListBL(ExecutionContextDTO executionContext) {
    _executionContextDTO = executionContext;
    _assetGroupAssetsRepositories =
        AssetGroupAssetsRepositories(_executionContextDTO);
  }

  Future<List<AssetGroupAssetsDto>?> assetGroupAssetsDTOList(
      Map<AssetGroupAssetsDTOSearchParameter, dynamic> searchparams) async {
    List<AssetGroupAssetsDto>? assetTypesDTO =
        await _assetGroupAssetsRepositories
            ?.getAssetGroupAssetsDTOList(searchparams);
    return assetTypesDTO;
  }
}
