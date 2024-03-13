import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/assets_group_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/repository/dbhandler/assetgroup_dbhandler.dart';
import 'package:semnox_core/modules/maintenance/assets/repository/request/assetgroup_service.dart';
import 'package:semnox_core/utils/database/dataConstant.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:flutter/material.dart';

class AssetGroupRepositories {
  AssetsGroupsService? _assetsGroupsService;
  ExecutionContextDTO? _executionContext;
  int? count = 0;
  List<SyncDetails>? syncdataList = [];

  AssetGroupRepositories(ExecutionContextDTO executionContext) {
    _executionContext = executionContext;
    _assetsGroupsService = AssetsGroupsService(_executionContext!);
  }

  Future<List<AssetGroupsDTO>> getAssetGroupsDTOList(
      Map<AssetGroupsDTOSearchParameter, dynamic> searchparams) async {
    late List<AssetGroupsDTO> localAssetGroupsDTOList;

    AssetGroupDbHandler assetGroupLocalDataHandler =
        AssetGroupDbHandler(_executionContext!);

    final result = await Connectivity().checkConnectivity();
    if (result.name != "none") {
      List<AssetGroupsDTO> serverAssetGroupDTOList =
          await _assetsGroupsService!.getAssetsGroupsList(searchparams);

      if (serverAssetGroupDTOList.isNotEmpty) {
        localAssetGroupsDTOList =
            await assetGroupLocalDataHandler.getAssetGroupsList(searchparams);

        for (var element in serverAssetGroupDTOList) {
          bool insertElement = false;
          if (localAssetGroupsDTOList.isEmpty) {
            insertElement = true;
          } else {
            Iterable<AssetGroupsDTO> myListFiltered = localAssetGroupsDTOList
                .where((e) => e.assetGroupId == element.assetGroupId);

            if (myListFiltered.isNotEmpty) {
              // the entry exists, so update
              AssetGroupsDTO assetGroupsDTO = myListFiltered.first;
              if (element.lastUpdatedDate != assetGroupsDTO.lastUpdatedDate) {
                assetGroupsDTO.RefreshServerValues(element);
                int status = await AssetGroupDbHandler(_executionContext!)
                    .updateAssetGroups(assetGroupsDTO);
                if (status != -1) {
                  count = count! + 1;
                  if (count == serverAssetGroupDTOList.length) {
                    var syncdetails = SyncDetails(
                        type: DatabaseTableName.TABLE_ASSETSGROUP,
                        insertedcount: count,
                        totalcount: serverAssetGroupDTOList.length,
                        syncstatus: serverAssetGroupDTOList.length == count
                            ? "Completed"
                            : "Syncing");
                    syncdataList?.add(syncdetails);
                    assetGroupCrudCount.value =
                        SyncData(percent: 10.00, syncdetails: syncdataList);
                  }
                }
              }
            } else {
              insertElement = true;
            }
          }
          if (insertElement == true) {
            // insert object
            AssetGroupsDTO assetGroupsDTO = AssetGroupsDTO();
            assetGroupsDTO.RefreshServerValues(element);
            int status = await AssetGroupDbHandler(_executionContext!)
                .insertAssetGroups(assetGroupsDTO);
            if (status != -1) {
              count = count! + 1;
              if (count == serverAssetGroupDTOList.length) {
                var syncdetails = SyncDetails(
                    type: DatabaseTableName.TABLE_ASSETSGROUP,
                    insertedcount: count,
                    totalcount: serverAssetGroupDTOList.length,
                    syncstatus: serverAssetGroupDTOList.length == count
                        ? "Completed"
                        : "Syncing");
                syncdataList?.add(syncdetails);
                assetGroupCrudCount.value =
                    SyncData(percent: 10.00, syncdetails: syncdataList);
              }
            }
          }
        }
      }
    }
    localAssetGroupsDTOList =
        await assetGroupLocalDataHandler.getAssetGroupsList(searchparams);
    return localAssetGroupsDTOList;
  }
}

final ValueNotifier<SyncData> assetGroupCrudCount =
    ValueNotifier<SyncData>(SyncData(percent: 0.00, syncdetails: []));
