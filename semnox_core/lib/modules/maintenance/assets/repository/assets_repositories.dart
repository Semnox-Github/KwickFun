import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/asset_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/repository/dbhandler/assets_dbhandler.dart';
import 'package:semnox_core/modules/maintenance/assets/repository/request/assets_service.dart';
import 'package:semnox_core/utils/database/dataConstant.dart';
import 'package:semnox_core/utils/utils.dart';

class AssetsGenericRepositories {
  AssetsGenericService? _assetsGenericService;
  ExecutionContextDTO? _executionContext;
  int? count = 0;
  List<SyncDetails>? syncdataList = [];

  AssetsGenericRepositories(ExecutionContextDTO executionContext) {
    _executionContext = executionContext;
    _assetsGenericService = AssetsGenericService(_executionContext!);
  }

  Future<List<GenericAssetDTO>> getGenericAssetDTOList(
      Map<AssetsGenericDTOSearchParameter, dynamic>
          genericAssetSearchParams) async {
    // bool dataChanged = false;
    late List<GenericAssetDTO> localGenericAssetDTOList;
    GenericAssetDbHandler genericAssetLocalDataHandler =
        GenericAssetDbHandler(_executionContext!);
    final result = await Connectivity().checkConnectivity();
    if (result.name != "none") {
      List<GenericAssetDTO> serverGenericAssetDTOList =
          await _assetsGenericService!
              .getGenericAssetList(genericAssetSearchParams);
      if (serverGenericAssetDTOList.isNotEmpty) {
        localGenericAssetDTOList = await genericAssetLocalDataHandler
            .getAssetDTOList(genericAssetSearchParams);
        for (var element in serverGenericAssetDTOList) {
          bool insertElement = false;
          if (localGenericAssetDTOList.isEmpty) {
            insertElement = true;
          } else {
            Iterable<GenericAssetDTO> myListFiltered = localGenericAssetDTOList
                .where((e) => e.assetId == element.assetId);
            if (myListFiltered.isNotEmpty) {
              // the entry exists, so update
              GenericAssetDTO assetDTO = myListFiltered.first;
              if (element.lastUpdatedDate != assetDTO.lastUpdatedDate) {
                assetDTO.RefreshServerValues(element);
                int status = await GenericAssetDbHandler(_executionContext!)
                    .updateAsset(assetDTO);
                if (status != -1) {
                  count = count! + 1;
                  if (count == serverGenericAssetDTOList.length) {
                    var syncdetails = SyncDetails(
                        type: DatabaseTableName.TABLE_ASSETS,
                        insertedcount: count,
                        totalcount: serverGenericAssetDTOList.length,
                        syncstatus: serverGenericAssetDTOList.length == count
                            ? "Completed"
                            : "Syncing");
                    syncdataList?.add(syncdetails);
                    assetCrudCount.value =
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
            GenericAssetDTO assetDTO = GenericAssetDTO();
            assetDTO.RefreshServerValues(element);
            int status = await GenericAssetDbHandler(_executionContext!)
                .insertAsset(assetDTO);
            if (status != -1) {
              count = count! + 1;
              if (count == serverGenericAssetDTOList.length) {
                var syncdetails = SyncDetails(
                    type: DatabaseTableName.TABLE_ASSETS,
                    insertedcount: count,
                    totalcount: serverGenericAssetDTOList.length,
                    syncstatus: serverGenericAssetDTOList.length == count
                        ? "Completed"
                        : "Syncing");
                syncdataList?.add(syncdetails);
                assetCrudCount.value =
                    SyncData(percent: 10.00, syncdetails: syncdataList);
              }
            }
          }
        }
      }
    }
    localGenericAssetDTOList = await genericAssetLocalDataHandler
        .getAssetDTOList(genericAssetSearchParams);
    return localGenericAssetDTOList;
  }
}

final ValueNotifier<SyncData> assetCrudCount =
    ValueNotifier<SyncData>(SyncData(percent: 0.00, syncdetails: []));
