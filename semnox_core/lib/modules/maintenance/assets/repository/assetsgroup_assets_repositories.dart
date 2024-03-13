import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/assetgroup_Assets_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/repository/request/assetgroup_assets_service.dart';
import 'package:semnox_core/utils/database/dataConstant.dart';
import 'package:semnox_core/utils/utils.dart';
import 'dbhandler/assetsgroup_assets_dbhandler.dart';

class AssetGroupAssetsRepositories {
  AssetGroupAssetsService? _assetGroupAssetsService;
  ExecutionContextDTO? _executionContext;
  int? count = 0;
  List<SyncDetails>? syncdataList = [];

  AssetGroupAssetsRepositories(ExecutionContextDTO? executionContext) {
    _executionContext = executionContext;
    _assetGroupAssetsService = AssetGroupAssetsService(_executionContext!);
  }

  Future<List<AssetGroupAssetsDto>> getAssetGroupAssetsDTOList(
      Map<AssetGroupAssetsDTOSearchParameter, dynamic>
          genericAssetSearchParams) async {
    // bool dataChanged = false;

    late List<AssetGroupAssetsDto> localAssetGroupAssetsDto;

    AssetsGroupAssetsDbHandler genericAssetLocalDataHandler =
        AssetsGroupAssetsDbHandler(_executionContext!);

    final result = await Connectivity().checkConnectivity();

    if (result.name != "none") {
      List<AssetGroupAssetsDto> serverAssetGroupAssetsDto =
          await _assetGroupAssetsService!
              .getAssetGroupAssetsList(genericAssetSearchParams);

      if (serverAssetGroupAssetsDto.isNotEmpty) {
        localAssetGroupAssetsDto = await genericAssetLocalDataHandler
            .getAssetGroupAssetDTOList(genericAssetSearchParams);

        for (var element in serverAssetGroupAssetsDto) {
          bool insertElement = false;
          if (localAssetGroupAssetsDto.isEmpty) {
            insertElement = true;
          } else {
            Iterable<AssetGroupAssetsDto> myListFiltered =
                localAssetGroupAssetsDto
                    .where((e) => e.assetId == element.assetId);

            if (myListFiltered.isNotEmpty) {
              // the entry exists, so update
              AssetGroupAssetsDto assetGroupAssetsDto = myListFiltered.first;
              if (element.lastUpdatedDate !=
                  assetGroupAssetsDto.lastUpdatedDate) {
                assetGroupAssetsDto.RefreshServerValues(element);
                // take value from server and put into local
                //Update when server date > local date
                int status =
                    await AssetsGroupAssetsDbHandler(_executionContext!)
                        .updateAsset(assetGroupAssetsDto);
                if (status != -1) {
                  count = count! + 1;
                  if (count == serverAssetGroupAssetsDto.length) {
                    var syncdetails = SyncDetails(
                        type: DatabaseTableName.TABLE_ASSETSGROUP_ASSETS,
                        insertedcount: count,
                        totalcount: serverAssetGroupAssetsDto.length,
                        syncstatus: serverAssetGroupAssetsDto.length == count
                            ? "Completed"
                            : "Syncing");
                    syncdataList?.add(syncdetails);
                    assetgroupassetCrudCount.value =
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
            AssetGroupAssetsDto assetGroupAssetsDto = AssetGroupAssetsDto();
            assetGroupAssetsDto.RefreshServerValues(element);
            int status = await AssetsGroupAssetsDbHandler(_executionContext!)
                .insertAssetGroupAsset(assetGroupAssetsDto);
            if (status != -1) {
              count = count! + 1;
              if (count == serverAssetGroupAssetsDto.length) {
                var syncdetails = SyncDetails(
                    type: DatabaseTableName.TABLE_ASSETSGROUP_ASSETS,
                    insertedcount: count,
                    totalcount: serverAssetGroupAssetsDto.length,
                    syncstatus: serverAssetGroupAssetsDto.length == count
                        ? "Completed"
                        : "Syncing");
                syncdataList?.add(syncdetails);
                assetgroupassetCrudCount.value =
                    SyncData(percent: 10.00, syncdetails: syncdataList);
              }
            }
          }
        }
      }
    }
    localAssetGroupAssetsDto = await genericAssetLocalDataHandler
        .getAssetGroupAssetDTOList(genericAssetSearchParams);
    return localAssetGroupAssetsDto;
  }
}

final ValueNotifier<SyncData> assetgroupassetCrudCount =
    ValueNotifier<SyncData>(SyncData(percent: 0.00, syncdetails: []));
