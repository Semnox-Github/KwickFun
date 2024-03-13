import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/bl/maintainence_bl.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/maintainence_service_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/repositories/comments_repositories.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/repositories/dbhandler/maintainence_dbhandler.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/repositories/image_repositories.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/repositories/request/maintainence_service.dart';
import 'package:semnox_core/utils/database/dataConstant.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckListDetailRepositories {
  static int get _cacheLife => 60;
  static int count = 0;
  static List<SyncDetails>? syncdataList = [];
  static CheckListDetailService? _checkListDetailService;
  static ExecutionContextDTO? _executionContextDTO;
  static CheckListDetailDbHandler? _checkListDetailLocalDataHandler;
  CheckListDetailRepositories._internal();
  static final _singleton = CheckListDetailRepositories._internal();
  static List? _list = [];

  factory CheckListDetailRepositories(ExecutionContextDTO executionContext) {
    _executionContextDTO = executionContext;
    _checkListDetailService = CheckListDetailService(_executionContextDTO!);
    _checkListDetailLocalDataHandler =
        CheckListDetailDbHandler(_executionContextDTO!, _cacheLife);
    return _singleton;
  }

  Future<List<CheckListDetailDTO>?> sync(
      Map<CheckListDetailSearchParameter, dynamic> searchparams) async {
    if (_executionContextDTO?.inWebMode == false) {
      _list = await _getLocalData(_executionContextDTO, searchparams);
    }
    _list ??= await _getRemoteData(_executionContextDTO, searchparams);
    return CheckListDetailDTO.getCheckListDetailDTOList(_list);
  }

  Future<List<CheckListDetailDTO>?> getData(
      Map<CheckListDetailSearchParameter, dynamic> searchparams) async {
    if (_executionContextDTO?.inWebMode == false) {
      _list = await _getLocalData(_executionContextDTO, searchparams);
    } else {
      _list = await _getRemoteData(_executionContextDTO, searchparams);
    }
    return CheckListDetailDTO.getCheckListDetailDTOList(_list);
  }

  static Future<List?> _getLocalData(ExecutionContextDTO? executionContext,
      Map<CheckListDetailSearchParameter, dynamic> searchparams) async {
    var list = await _checkListDetailLocalDataHandler?.getData(
        searchparams: searchparams);
    return list?.map((json) => CheckListDetailDTO.fromMap(json)).toList();
  }

  static Future<List?> _getRemoteData(ExecutionContextDTO? executionContext,
      Map<CheckListDetailSearchParameter, dynamic> searchparams) async {
    var apiResponse =
        await _checkListDetailService?.getData(searchparams: searchparams);
    if (apiResponse!.isNotEmpty) {
      _list = CheckListDetailDTO.getCheckListDetailDTOList(apiResponse);
    }
    return _list ?? [];
  }

  Future<List<CheckListDetailDTO>?> postData(
      CheckListDetailDTO? dto, Map? params) async {
    if (_executionContextDTO?.inWebMode == true) {
      _list = await _checkListDetailService?.postData(dto, params);
    } else {
      _list = await _checkListDetailLocalDataHandler?.postData(dto, params);
    }
    return CheckListDetailDTO.getCheckListDetailDTOList(_list);
  }

  Future<List<CheckListDetailDTO>?> getLocaldatafromDB(
      Map<CheckListDetailSearchParameter, dynamic> searchparams) async {
    var dtoList = await _getLocalData(_executionContextDTO, searchparams);
    return dtoList != null
        ? CheckListDetailDTO.getCheckListDetailDTOList(_list)
        : [];
  }

  /// ************************

  Future<List<CheckListDetailDTO>> getCheckListDetailsDTOList(
      Map<CheckListDetailSearchParameter, dynamic> searchparams) async {
    late List<CheckListDetailDTO>? localCheckListDetailsDTOList;
    CommentRepositories commentRepositories =
        CommentRepositories(_executionContextDTO!);
    ImageRepositories imageRepositories =
        ImageRepositories(_executionContextDTO!);
    final result = await Connectivity().checkConnectivity();
    if (result.name != "none") {
      print('Connected to a network');
      List<CheckListDetailDTO> serverCheckListDetailsDTOList =
          await _checkListDetailService!
              .getCheckListDetailsDTOList(searchparams);
      if (serverCheckListDetailsDTOList.isNotEmpty) {
        localCheckListDetailsDTOList = await _checkListDetailLocalDataHandler!
            .getCheckListDetailDTOList(searchparams);
        for (var element in serverCheckListDetailsDTOList) {
          bool insertElement = false;
          if (localCheckListDetailsDTOList.isEmpty) {
            insertElement = true;
          } else {
            Iterable<CheckListDetailDTO> myListFiltered =
                localCheckListDetailsDTOList.where(
                    (e) => e.maintChklstdetId == element.maintChklstdetId);
            if (myListFiltered.isNotEmpty) {
              //value exists
              CheckListDetailDTO checkListDetailDTO = myListFiltered.first;
              if (element.lastUpdatedDate !=
                  checkListDetailDTO.lastUpdatedDate) {
                checkListDetailDTO.refreshServerValues(element);
                if (checkListDetailDTO.maintChklstdetId != null) {
                  await commentRepositories.getcommentfromserver(
                      checkListDetailDTO.maintChklstdetId);
                  await imageRepositories
                      .getimagefromserver(checkListDetailDTO.maintChklstdetId);
                }
                int status = await _checkListDetailLocalDataHandler!
                    .updateCheckListTable(checkListDetailDTO);
                if (status != -1) {
                  count = count + 1;
                  if (count == serverCheckListDetailsDTOList.length) {
                    var syncdetails = SyncDetails(
                        type: DatabaseTableName.TABLE_CHECKLIST_DETAIL,
                        insertedcount: count,
                        totalcount: serverCheckListDetailsDTOList.length,
                        syncstatus:
                            serverCheckListDetailsDTOList.length == count
                                ? "Completed"
                                : "Syncing");
                    syncdataList?.add(syncdetails);
                    maintCheckListCrudCount.value =
                        SyncData(percent: 20.00, syncdetails: syncdataList);
                  }
                }
              }
            } else {
              insertElement = true;
            }
          }
          if (insertElement == true) {
            // insert object
            CheckListDetailDTO checkListDetailDTO = CheckListDetailDTO();
            checkListDetailDTO.refreshServerValues(element);
            if (checkListDetailDTO.maintChklstdetId != null) {
              await commentRepositories
                  .getcommentfromserver(checkListDetailDTO.maintChklstdetId);
              await imageRepositories
                  .getimagefromserver(checkListDetailDTO.maintChklstdetId);
            }

            int status = await _checkListDetailLocalDataHandler!
                .insertCheckListDetail(checkListDetailDTO);

            if (status != -1) {
              count = count + 1;
              if (count == serverCheckListDetailsDTOList.length) {
                var syncdetails = SyncDetails(
                    type: DatabaseTableName.TABLE_CHECKLIST_DETAIL,
                    insertedcount: count,
                    totalcount: serverCheckListDetailsDTOList.length,
                    syncstatus: serverCheckListDetailsDTOList.length == count
                        ? "Completed"
                        : "Syncing");
                syncdataList?.add(syncdetails);
                maintCheckListCrudCount.value =
                    SyncData(percent: 20.00, syncdetails: syncdataList);
              }
            }
          }
        }
      }
    }
    localCheckListDetailsDTOList = await _checkListDetailLocalDataHandler!
        .getCheckListDetailDTOList(searchparams);
    return localCheckListDetailsDTOList;
  }

  Future<List<CheckListDetailDTO>?> getCheckListDetailDTOListByTaskGroupId(
      Map<CheckListDetailSearchParameter, dynamic> checkListDetailSearchParams,
      int? taskgroupId) async {
    List<CheckListDetailDTO>? checkListDetailDTO =
        await _checkListDetailLocalDataHandler
            ?.getCheckListDetailDTOListByTaskGroupId(
                checkListDetailSearchParams, taskgroupId);
    return checkListDetailDTO;
  }

  Future<List<CheckListDetailDTO>> getCheckListDetailsList(
      Map<CheckListDetailSearchParameter, dynamic> searchparams) async {
    List<CheckListDetailDTO> checkListDTOList = [];
    if (_executionContextDTO?.inWebMode == true) {
      checkListDTOList = await _checkListDetailService!
          .getCheckListDetailsDTOList(searchparams);
    } else {
      checkListDTOList = await _checkListDetailLocalDataHandler!
          .getCheckListDetailDTOList(searchparams);
    }
    return checkListDTOList;
  }

  Future<List<CheckListDetailDTO>> getCheckListDetailsDTOListFromLocalDB(
      Map<CheckListDetailSearchParameter, dynamic> searchParams) async {
    late List<CheckListDetailDTO> localCheckListDetailsDTOList;
    print('Fetch data from local');
    localCheckListDetailsDTOList = await _checkListDetailLocalDataHandler!
        .getCheckListDetailDTOList(searchParams);
    return localCheckListDetailsDTOList;
  }

  Future<Iterable<CheckListDetailDTO>>
      getCheckListDetailsDTOListFromLocalDBbyLocalMaintID(
          int localmaintCheckId) async {
    late Iterable<CheckListDetailDTO> listDetailDTO;
    print('Fetch data from local');
    listDetailDTO = await _checkListDetailLocalDataHandler!
        .getCheckListDetailDTOListByLocalMaintID(localmaintCheckId);
    return listDetailDTO;
  }

  Future<int> updateCheckListTable(
      CheckListDetailDTO maintainenceservicedto) async {
    return await _checkListDetailLocalDataHandler!
        .updateCheckListTable(maintainenceservicedto);
  }

  Future<int> saveDraftRequest(CheckListDetailDTO checkListDetailDTO) async {
    int status = await _checkListDetailLocalDataHandler!
        .insertCheckListDetail(checkListDetailDTO);
    return status;
  }

  Future<void> checkpref(
      SharedPreferences sharedPreferences, CheckListDetailDTO? checkdto) async {
    List<CheckListDetailDTO>? checklistdto = [];
    var result = sharedPreferences.getStringList("RecentChecklistDTO");
    print('The Result is $result');
    if (result != null) {
      checklistdto =
          result.map((json) => CheckListDetailDTO.fromJson(json)).toList();
    }

    if (checklistdto.isNotEmpty) {
      var contain = checklistdto.where(
          (element) => element.maintChklstdetId == checkdto!.maintChklstdetId);
      if (contain.isEmpty) {
        checklistdto.add(checkdto!);
        List<String> checklistdtoEncoded = checklistdto
            .map((checklist) => jsonEncode(checklist.toMap()))
            .toList();
        bool statusResult = await sharedPreferences.setStringList(
            'RecentChecklistDTO', checklistdtoEncoded);
        if (statusResult == true) {
          print("Success");
        }
        print('$checklistdto');
      } else {
        List<String> checklistdtoEncoded = checklistdto
            .map((checklist) => jsonEncode(checklist.toMap()))
            .toList();
        bool statusResult = await sharedPreferences.setStringList(
            'RecentChecklistDTO', checklistdtoEncoded);
        if (statusResult == true) {
          print("Success");
        }
        print('$checklistdto');
      }
    } else {
      checklistdto.add(checkdto!);
      List<String> checklistdtoEncoded = checklistdto
          .map((checklist) => jsonEncode(checklist.toMap()))
          .toList();
      bool statusResult = await sharedPreferences.setStringList(
          'RecentChecklistDTO', checklistdtoEncoded);
      if (statusResult == true) {
        print("Success");
      }
      print('$checklistdto');
    }
  }

  Future<void> saveRecentmaintainenceDTO(CheckListDetailDTO? checkdto) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await checkpref(sharedPreferences, checkdto);
  }

  Future<int> postChecklistDTOServer(
      CheckListDetailDTO localcheckListDetailsDTO,
      Map<CheckListDetailSearchParameter, dynamic> postsearchparams) async {
    final result = await Connectivity().checkConnectivity();
    if (result.name != "none") {
      print('Connected to a network');
      try {
        List<CheckListDetailDTO> serverCheckListDetailsDTO =
            await _checkListDetailService!
                .postchecklistdto(localcheckListDetailsDTO, postsearchparams);
        if (serverCheckListDetailsDTO.isNotEmpty) {
          for (var dto in serverCheckListDetailsDTO) {
            localcheckListDetailsDTO.refreshServerValues(dto);
            localcheckListDetailsDTO.serverSync = true;
            int result = await CheckListDetailDbHandler(
                    _executionContextDTO!, _cacheLife)
                .updateCheckListTable(localcheckListDetailsDTO);
            return result;
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('No Connection');
    }
    return -1;
  }

  Future<void> saveRecentCheckListDTO(CheckListDetailDTO? checkdto) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await checkPreference(sharedPreferences, checkdto);
  }

  checkPreference(
      SharedPreferences sharedPreferences, CheckListDetailDTO? checkdto) async {
    List<CheckListDetailDTO>? checklistdto = [];
    var result = sharedPreferences.getStringList("RecentChecklistDTO");
    print('The Result is $result');
    if (result != null) {
      checklistdto =
          result.map((json) => CheckListDetailDTO.fromJson(json)).toList();
    }

    if (checklistdto.isNotEmpty) {
      var contain = checklistdto.where(
          (element) => element.maintChklstdetId == checkdto!.maintChklstdetId);
      if (contain.isEmpty) {
        checklistdto.add(checkdto!);
        List<String> checklistdtoEncoded = checklistdto
            .map((checklist) => jsonEncode(checklist.toMap()))
            .toList();
        bool statusResult = await sharedPreferences.setStringList(
            'RecentChecklistDTO', checklistdtoEncoded);
        if (statusResult == true) {
          print("Success");
        }
      } else {
        List<String> checklistdtoEncoded = checklistdto
            .map((checklist) => jsonEncode(checklist.toMap()))
            .toList();
        bool statusResult = await sharedPreferences.setStringList(
            'RecentChecklistDTO', checklistdtoEncoded);
        if (statusResult == true) {
          print("Success");
        }
        print('$checklistdto');
      }
    } else {
      checklistdto.add(checkdto!);
      List<String> checklistdtoEncoded = checklistdto
          .map((checklist) => jsonEncode(checklist.toMap()))
          .toList();
      bool statusResult = await sharedPreferences.setStringList(
          'RecentChecklistDTO', checklistdtoEncoded);
      if (statusResult == true) {
        print("Success");
      }
      print('$checklistdto');
    }
  }

  Future<ActionCount?> getactionitem(
      Map<CheckListDetailSearchParameter, dynamic> checkListDetailssearchParams,
      int? taskClosedStatusId,
      int? srClosedStatusId,
      {int? taskgroupid}) async {
    ActionCount? pendingAction =
        await _checkListDetailLocalDataHandler?.getPendingAction(
            checkListDetailssearchParams, taskClosedStatusId, srClosedStatusId,
            taskgroupid: taskgroupid);
    return pendingAction;
  }

  static String _getKey(String type, ExecutionContextDTO? executionContext) {
    String storageKey = "";
    switch (type) {
      case "cache":
        storageKey = executionContext!.siteHash();
        break;
      case "storage":
        storageKey = executionContext!.siteHash();
        break;
    }
    return storageKey;
  }
}

final ValueNotifier<SyncData> maintCheckListCrudCount =
    ValueNotifier<SyncData>(SyncData(percent: 0.00, syncdetails: []));
