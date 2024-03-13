import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/maintainence_service_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/repositories/maintainence_repositories.dart';
import 'package:semnox_core/utils/database/dataConstant.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckListDetailsBL {
  CheckListDetailDTO? _checkListDetailsDTO;
  ExecutionContextDTO? _executionContextDTO;
  CheckListDetailRepositories? _checkListDetailRepositories;
  int? _id;

  CheckListDetailsBL.id(ExecutionContextDTO executionContext, int? id) {
    _id = id;
    _executionContextDTO = executionContext;
    _checkListDetailRepositories =
        CheckListDetailRepositories(_executionContextDTO!);
  }

  CheckListDetailsBL.dto(ExecutionContextDTO executionContext,
      CheckListDetailDTO checkListDetailDTO) {
    _executionContextDTO = executionContext;
    _checkListDetailsDTO = checkListDetailDTO;
    _checkListDetailRepositories =
        CheckListDetailRepositories(_executionContextDTO!);
  }

  CheckListDetailsBL(ExecutionContextDTO executionContext) {
    _executionContextDTO = executionContext;
  }

  Future<int> updateCheckListDTO(BuildContext context) async {
    _checkListDetailsDTO!.refreshServerValues(_checkListDetailsDTO!);
    return await _checkListDetailRepositories!
        .updateCheckListTable(_checkListDetailsDTO!);
  }

  Future<int> postChecklistDTOServer(
      Map<CheckListDetailSearchParameter, dynamic> postsearchparams) async {
    int? result = await _checkListDetailRepositories?.postChecklistDTOServer(
        _checkListDetailsDTO!, postsearchparams);
    return result!;
  }

  Future<void> saveRecentCheckListDTO(CheckListDetailDTO? checkdto) async {
    await _checkListDetailRepositories?.saveRecentCheckListDTO(checkdto);
  }
}

class CheckListDetailsListBL {
  late ExecutionContextDTO _executionContextDTO;
  CheckListDetailRepositories? _checkListDetailRepositories;
  static int count = 0;
  static List<SyncDetails>? syncdataList = [];
  CheckListDetailsListBL(ExecutionContextDTO executionContext) {
    _executionContextDTO = executionContext;
    _checkListDetailRepositories =
        CheckListDetailRepositories(_executionContextDTO);
  }

  Future<List<CheckListDetailDTO>?> sync(
      Map<CheckListDetailSearchParameter, dynamic> searchparams) async {
    List<CheckListDetailDTO>? checkListDetailDTO =
        await _checkListDetailRepositories?.getData(searchparams);
    if (checkListDetailDTO!.isNotEmpty &&
        _executionContextDTO.inWebMode == false) {
      checkListDetailDTO = await setLocalData(
          _executionContextDTO,
          CheckListDetailDTO.getCheckListDetailDTOList(checkListDetailDTO),
          searchparams);
    }
    // else if (checkListDetailDTO.isNotEmpty &&
    //     _executionContextDTO.inWebMode == true) {
    //   checkListDetailDTO =
    //       CheckListDetailDTO.getCheckListDetailDTOList(checkListDetailDTO);
    // }
    return checkListDetailDTO;
  }

  Future<List<CheckListDetailDTO>?> getData(
      Map<CheckListDetailSearchParameter, dynamic> searchparams) async {
    List<CheckListDetailDTO>? checkListDetailDTO =
        await _checkListDetailRepositories?.getData(searchparams);
    return checkListDetailDTO;
  }

  setLocalData(ExecutionContextDTO? executionContext, List? dtoList,
      Map<CheckListDetailSearchParameter, dynamic> searchparams) async {
    var serverCheckListDetailsDTOList =
        CheckListDetailDTO.getCheckListDetailDTOList(dtoList);
    // final result = await Connectivity().checkConnectivity();
    // if (result.name != "none") {
    if (serverCheckListDetailsDTOList!.isNotEmpty) {
      var localCheckListDetailsDTOList =
          CheckListDetailDTO.getCheckListDetailDTOList(
              await _checkListDetailRepositories
                  ?.getLocaldatafromDB(searchparams));
      for (var element in serverCheckListDetailsDTOList) {
        bool insertElement = false;
        if (localCheckListDetailsDTOList!.isEmpty) {
          insertElement = true;
        } else {
          Iterable<CheckListDetailDTO> myListFiltered =
              localCheckListDetailsDTOList
                  .where((e) => e.maintChklstdetId == element.maintChklstdetId);
          if (myListFiltered.isNotEmpty) {
            //value exists
            CheckListDetailDTO checkListDetailDTO = myListFiltered.first;
            if (element.lastUpdatedDate != checkListDetailDTO.lastUpdatedDate) {
              checkListDetailDTO.refreshServerValues(element);
              var result = await _checkListDetailRepositories!
                  .postData(checkListDetailDTO, searchparams);
              if (result!.isNotEmpty) {
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
          } else {
            insertElement = true;
          }
        }
        if (insertElement == true) {
          // insert object
          CheckListDetailDTO checkListDetailDTO = CheckListDetailDTO();
          checkListDetailDTO.refreshServerValues(element);
          var result = await _checkListDetailRepositories!
              .postData(checkListDetailDTO, searchparams);
          if (result!.isNotEmpty) {
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
    // }
  }

  Future<List<CheckListDetailDTO>?> getCheckListDetailsDTOList(
      Map<CheckListDetailSearchParameter, dynamic>
          checkListDetailSearchParams) async {
    List<CheckListDetailDTO>? checkListDetailDTO =
        await _checkListDetailRepositories
            ?.getCheckListDetailsList(checkListDetailSearchParams);
    return checkListDetailDTO;
  }

  Future<List<CheckListDetailDTO>?> getCheckListDetailDTOListByTaskGroupId(
      Map<CheckListDetailSearchParameter, dynamic> checkListDetailSearchParams,
      int? taskgroupId) async {
    List<CheckListDetailDTO>? checkListDetailDTO =
        await _checkListDetailRepositories
            ?.getCheckListDetailDTOListByTaskGroupId(
                checkListDetailSearchParams, taskgroupId);
    return checkListDetailDTO;
  }

  Future<List<CheckListDetailDTO>> getRecentCheckListDTO(
      Map<CheckListDetailSearchParameter, dynamic> checkListDetailssearchParams,
      BuildContext? context) async {
    List<CheckListDetailDTO> checklistdto = [];
    List<CheckListDetailDTO> statuschecklistdto = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    var result = pref.getStringList("RecentChecklistDTO");
    if (result != null) {
      checklistdto =
          result.map((json) => CheckListDetailDTO.fromJson(json)).toList();

      for (var element in checklistdto) {
        if (element.localmaintChklstdetId != null) {
          CheckListDetailRepositories checkListDetailLocalDataHandler =
              CheckListDetailRepositories(_executionContextDTO);
          Iterable<CheckListDetailDTO> checkListDetailDTO =
              await checkListDetailLocalDataHandler
                  .getCheckListDetailsDTOListFromLocalDBbyLocalMaintID(
                      element.localmaintChklstdetId!);
          if (checkListDetailDTO.isNotEmpty) {
            statuschecklistdto.add(checkListDetailDTO.first);
          }
        }

        // if (element.status ==
        //     checkListDetailssearchParams[
        //         CheckListDetailSearchParameter.STATUS]) {
        //   statuschecklistdto.add(checkListDetailDTO.first);
        // }
      }

      if (statuschecklistdto.isNotEmpty) {
        checklistdto = [];
        if (statuschecklistdto.length > 10) {
          Utils().showSemnoxDialog(context!,
              "Recent list more then 10 records do you want clear the list");
        }

        checklistdto = statuschecklistdto;
      } else {
        if (checkListDetailssearchParams[
                CheckListDetailSearchParameter.STATUS] !=
            -1) {
          checklistdto = [];
        }
      }
      print('$checklistdto');
    }
    return checklistdto;
  }

  getactionitem(
      Map<CheckListDetailSearchParameter, dynamic> checkListDetailssearchParams,
      int? taskClosedStatusId,
      int? srClosedStatusId,
      {int? taskgroupid}) async {
    var pendingAction = await _checkListDetailRepositories?.getactionitem(
        checkListDetailssearchParams, taskClosedStatusId, srClosedStatusId,
        taskgroupid: taskgroupid);
    return pendingAction;
  }

  void purgeJobDetails() async {}

  Future<List<CheckListDetailDTO>> getCheckListDetailsDTOListFromLocalDB(
      Map<CheckListDetailSearchParameter, dynamic>
          checkListDetailSearchParams) async {
    CheckListDetailRepositories checkListDetailLocalDataHandler =
        CheckListDetailRepositories(_executionContextDTO);
    List<CheckListDetailDTO> checkListDetailDTO =
        await checkListDetailLocalDataHandler
            .getCheckListDetailsDTOListFromLocalDB(checkListDetailSearchParams);
    return checkListDetailDTO;
  }
}

class ActionCount {
  double pendingcount, totalcount, percent;
  ActionCount(this.pendingcount, this.totalcount, this.percent);
}
