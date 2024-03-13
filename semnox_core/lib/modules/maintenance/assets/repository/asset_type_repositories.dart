import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/asset_type_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/repository/dbhandler/asset_type_dbhandler.dart';
import 'package:semnox_core/modules/maintenance/assets/repository/request/asset_type_service.dart';
import 'package:semnox_core/utils/database/dataConstant.dart';
import 'package:semnox_core/utils/utils.dart';

class AssetTypesRepositories {
  AssetsTypeService? _assetsTypeService;
  ExecutionContextDTO? _executionContext;
  int? count = 0;
  List<SyncDetails>? syncdataList = [];

  AssetTypesRepositories(ExecutionContextDTO executionContext) {
    _executionContext = executionContext;
    _assetsTypeService = AssetsTypeService(_executionContext!);
  }

  Future<List<AssetTypesDTO>> getAssetTypesDTOList(
      Map<AssetsTypesDTOSearchParameter, dynamic> searchParams) async {
    late List<AssetTypesDTO> localAssetTypesDTOList;

    AssetTypesDbHandler assetTypesLocalDataHandler =
        AssetTypesDbHandler(_executionContext!);

    final result = await Connectivity().checkConnectivity();

    if (result.name != "none") {
      List<AssetTypesDTO> serverAssetGroupDTOList =
          await _assetsTypeService!.getAssetsTypeList(searchParams);

      if (serverAssetGroupDTOList.isNotEmpty) {
        localAssetTypesDTOList =
            await assetTypesLocalDataHandler.getAssetGroupsList(searchParams);

        for (var element in serverAssetGroupDTOList) {
          bool insertElement = false;
          if (localAssetTypesDTOList.isEmpty) {
            insertElement = true;
          } else {
            Iterable<AssetTypesDTO> myListFiltered = localAssetTypesDTOList
                .where((e) => e.assetTypeId == element.assetTypeId);

            if (myListFiltered.isNotEmpty) {
              // the entry exists, so update
              AssetTypesDTO assetTypesDTO = myListFiltered.first;
              if (element.lastUpdatedDate != assetTypesDTO.lastUpdatedDate) {
                assetTypesDTO.RefreshServerValues(element);
                int status = await AssetTypesDbHandler(_executionContext!)
                    .updateAssetGroups(assetTypesDTO);
                if (status != -1) {
                  count = count! + 1;
                  if (count == serverAssetGroupDTOList.length) {
                    var syncdetails = SyncDetails(
                        type: DatabaseTableName.TABLE_ASSETTYPE,
                        insertedcount: count,
                        totalcount: serverAssetGroupDTOList.length,
                        syncstatus: serverAssetGroupDTOList.length == count
                            ? "Completed"
                            : "Syncing");
                    syncdataList?.add(syncdetails);
                    assetTypeCrudCount.value =
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
            AssetTypesDTO assetTypesDTO = AssetTypesDTO();
            assetTypesDTO.RefreshServerValues(element);
            int status = await AssetTypesDbHandler(_executionContext!)
                .insertAssetTypes(assetTypesDTO);
            if (status != -1) {
              count = count! + 1;
              if (count == serverAssetGroupDTOList.length) {
                var syncdetails = SyncDetails(
                    type: DatabaseTableName.TABLE_ASSETTYPE,
                    insertedcount: count,
                    totalcount: serverAssetGroupDTOList.length,
                    syncstatus: serverAssetGroupDTOList.length == count
                        ? "Completed"
                        : "Syncing");
                syncdataList?.add(syncdetails);
                assetTypeCrudCount.value =
                    SyncData(percent: 10.00, syncdetails: syncdataList);
              }
            }
          }
        }
      }
    }
    localAssetTypesDTOList =
        await assetTypesLocalDataHandler.getAssetGroupsList(searchParams);
    return localAssetTypesDTOList;
  }
}

final ValueNotifier<SyncData> assetTypeCrudCount =
    ValueNotifier<SyncData>(SyncData(percent: 0.00, syncdetails: []));
