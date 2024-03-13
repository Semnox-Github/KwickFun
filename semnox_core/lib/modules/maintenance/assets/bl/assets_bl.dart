import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/asset_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/repository/assets_repositories.dart';
import 'package:semnox_core/modules/maintenance/assets/repository/dbhandler/assets_dbhandler.dart';

class AssetsBL {
  GenericAssetDTO? _assetsGenericDTO;
  ExecutionContextDTO? _executionContextDTO;
  AssetsGenericRepositories? _assetsGenericRepositories;

  AssetsBL.id(ExecutionContextDTO executionContext, int id) {
    _executionContextDTO = executionContext;
    _assetsGenericRepositories = AssetsGenericRepositories(executionContext);
  }

  AssetsBL.dto(
      ExecutionContextDTO executionContext, GenericAssetDTO assetsGenericDTO) {
    _executionContextDTO = executionContext;
    _assetsGenericDTO = assetsGenericDTO;
    _assetsGenericRepositories = AssetsGenericRepositories(executionContext);
  }

  AssetsBL(ExecutionContextDTO executionContext) {
    _executionContextDTO = executionContext;
    _assetsGenericRepositories = AssetsGenericRepositories(executionContext);
  }

  Future<List<GenericAssetDTO>> getLocalDB() async {
    return await GenericAssetDbHandler(_executionContextDTO!).getAssetLists();
  }
}

class AssetsListBL {
  ExecutionContextDTO? _executionContextDTO;
  AssetsGenericRepositories? _assetsGenericRepositories;
  AssetsListBL(ExecutionContextDTO executionContext) {
    _executionContextDTO = executionContext;
    _assetsGenericRepositories =
        AssetsGenericRepositories(_executionContextDTO!);
  }

  Future<List<GenericAssetDTO>?> getAssetsDTOList(
      Map<AssetsGenericDTOSearchParameter, dynamic>
          assetGenericSearchParams) async {
    return await _assetsGenericRepositories
        ?.getGenericAssetDTOList(assetGenericSearchParams);
  }
}
