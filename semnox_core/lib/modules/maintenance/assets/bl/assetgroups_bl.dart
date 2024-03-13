import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/assets_group_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/repository/assetsgroup_repositories.dart';

class AssetGroupBL {
  AssetGroupsDTO? _assetGroupsDTO;
  ExecutionContextDTO? _executionContextDTO;
  AssetGroupRepositories? _assetGroupRepositories;

  AssetGroupBL.id(ExecutionContextDTO executionContext, int id) {
    _executionContextDTO = executionContext;
    _assetGroupRepositories = AssetGroupRepositories(executionContext);
  }

  AssetGroupBL.dto(
      ExecutionContextDTO executionContext, AssetGroupsDTO assetGroupsDTO) {
    _executionContextDTO = executionContext;
    _assetGroupsDTO = assetGroupsDTO;
    _assetGroupRepositories = AssetGroupRepositories(executionContext);
  }
}

class AssetGroupListBL {
  ExecutionContextDTO? _executionContextDTO;
  AssetGroupRepositories? assetGroupRepositories;
  AssetGroupListBL(ExecutionContextDTO executionContext) {
    _executionContextDTO = executionContext;
    assetGroupRepositories = AssetGroupRepositories(executionContext);
  }

  Future<List<AssetGroupsDTO>?> getAssetGroupsDTOList(
      Map<AssetGroupsDTOSearchParameter, dynamic>
          assetGroupsSearchParams) async {
    return await assetGroupRepositories
        ?.getAssetGroupsDTOList(assetGroupsSearchParams);
  }
}
