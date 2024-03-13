import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:parafait_maintainence/app/lookupRules/MaintainanceLookupsAndRulesBL.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/bl/assetGroup_Assets_BL.dart';
import 'package:semnox_core/modules/maintenance/assets/bl/asset_types_BL.dart';
import 'package:semnox_core/modules/maintenance/assets/bl/assetgroups_BL.dart';
import 'package:semnox_core/modules/maintenance/assets/bl/assets_bl.dart';
import 'package:semnox_core/modules/maintenance/assets/model/asset_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/asset_type_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/assetgroup_Assets_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/assets_group_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/bl/maintainence_bl.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/maintainence_service_dto.dart';
import 'package:semnox_core/modules/maintenance/task/bl/task_BL.dart';
import 'package:semnox_core/modules/maintenance/task/model/task_dto.dart';
import 'package:semnox_core/modules/maintenance/task_group/bl/task_group_BL.dart';
import 'package:semnox_core/modules/maintenance/task_group/model/task_group_dto.dart';
import 'package:semnox_core/modules/parafait_defaults_configuration/provider/default_config.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/storage_service/local_storage.dart';
import 'package:intl/intl.dart';

class SyncprocessBL {
  static String get _syncpercent => "syncpercent";
  // String? _lastsyncDatetime;
  static String get _lastSyncDateTimestorageKey => "lastsyncDatetime";
  int syncpercentage = 0;
  ExecutionContextDTO? _executionContextDTO;
  static SyncprocessBL? _instance;
  MaintainanceLookupsAndRulesBL? maintainanceLookupsAndRulesRepository;
  late int syncfreqtime = 60;

  SyncprocessBL._(ExecutionContextDTO executionContextDTO) {
    _executionContextDTO = executionContextDTO;
  }

  factory SyncprocessBL(ExecutionContextDTO executionContextDTO) {
    _instance ??= SyncprocessBL._(executionContextDTO);
    return _instance!;
  }

  Future<void> sync() async {
    syncfreqtime = int.parse(
        DefaultConfigProvider.getConfigFor("THIRD_PARTY_SYSTEM_SYNCH_FREQUENCY")
            .toString());
    String dateFormat = 'yyyy-MM-dd h:mm';
    //DateFormat(DefaultConfigProvider.getConfigFor("DATETIME_FORMAT"));
    var lastsyncDatetime = LocalStorage().get(_lastSyncDateTimestorageKey);
    int elpasedTimeinSeconds = 0;
    if (lastsyncDatetime == null) {
      if (lastsyncDatetime == null) {
        elpasedTimeinSeconds = 999999;
      } else {
        DateTime currentDt =
            DateFormat(dateFormat).parse(DateTime.now().toString());
        Duration diff = currentDt.difference(
            DateFormat(dateFormat).parse(json.decode(lastsyncDatetime)));
        elpasedTimeinSeconds = diff.inSeconds;
      }
    } else {
      DateTime currentDt =
          DateFormat(dateFormat).parse(DateTime.now().toString());
      Duration diff = currentDt.difference(
          DateFormat(dateFormat).parse(json.decode(lastsyncDatetime)));
      elpasedTimeinSeconds = diff.inSeconds;
    }

    await _appToServerSync();

    if (elpasedTimeinSeconds > syncfreqtime) {
      // check is there any data in local push first and get the latest from server
      LocalStorage().save(
          _lastSyncDateTimestorageKey, json.encode(DateTime.now().toString()));

      await _serverToAppSync();
      LocalStorage().save(_syncpercent, json.encode(playerPointsToAdd.value));
    }

    // if (!_timerStarted) {
    //   int percent = int.parse(LocalStorage().get(_syncpercent).toString());
    //   playerPointsToAdd.value = percent;
    //   loadstate.value = true;
    //   timerMethod(_executionContextDTO!);
    // }
  }

  Future<void> _appToServerSync() async {
    maintainanceLookupsAndRulesRepository =
        MaintainanceLookupsAndRulesBL(_executionContextDTO!);
    await postsr();
    await posttask();
  }

  Future<void> postsr() async {
    CheckListDetailsListBL checkListDetailsListRepository =
        CheckListDetailsListBL(_executionContextDTO!);
    Map<CheckListDetailSearchParameter, dynamic> srSearchparams = {
      CheckListDetailSearchParameter.SITEID: _executionContextDTO!.siteId,
      CheckListDetailSearchParameter.ISACTIVE: 1,
      CheckListDetailSearchParameter.SERVERSYNC: 0,
      CheckListDetailSearchParameter.ASSIGNEDTO: _executionContextDTO!.userId,
      CheckListDetailSearchParameter.JOBTYPE:
          await maintainanceLookupsAndRulesRepository
              ?.getJobTypeId("Service Request")
    };

    List<CheckListDetailDTO> srDto = await checkListDetailsListRepository
        .getCheckListDetailsDTOListFromLocalDB(srSearchparams);

    log('request-data: $srDto');

    if (srDto.isNotEmpty) {
      for (var checklistdto in srDto) {
        Map<CheckListDetailSearchParameter, dynamic> postsearchparams = {
          CheckListDetailSearchParameter.ACTIVITYTYPE: "MAINTENANCEREQUESTS"
        };

        CheckListDetailsBL checkListDetailsRepository =
            CheckListDetailsBL.dto(_executionContextDTO!, checklistdto);
        await checkListDetailsRepository
            .postChecklistDTOServer(postsearchparams);
      }
    }
  }

  Future<void> posttask() async {
    CheckListDetailsListBL checkListDetailsListRepository =
        CheckListDetailsListBL(_executionContextDTO!);

    Map<CheckListDetailSearchParameter, dynamic> taskSearchparams = {
      CheckListDetailSearchParameter.SITEID: _executionContextDTO!.siteId,
      CheckListDetailSearchParameter.ISACTIVE: 1,
      CheckListDetailSearchParameter.SERVERSYNC: 0,
      CheckListDetailSearchParameter.ASSIGNEDTO: _executionContextDTO!.userId,
      CheckListDetailSearchParameter.JOBTYPE:
          await maintainanceLookupsAndRulesRepository?.getJobTypeId("Job"),
    };

    List<CheckListDetailDTO> taskDto = await checkListDetailsListRepository
        .getCheckListDetailsDTOListFromLocalDB(taskSearchparams);

    if (taskDto.isNotEmpty) {
      for (var checklistdto in taskDto) {
        Map<CheckListDetailSearchParameter, dynamic> postsearchparams = {
          CheckListDetailSearchParameter.ACTIVITYTYPE: "MAINTENANCEJOBDETAILS"
        };

        CheckListDetailsBL checkListDetailsRepository =
            CheckListDetailsBL.dto(_executionContextDTO!, checklistdto);
        await checkListDetailsRepository
            .postChecklistDTOServer(postsearchparams);
      }
    }
  }

  Future<void> _serverToAppSync() async {
    playerPointsToAdd.value = 0;
    //AssetsListRepository ---->
    AssetsListBL assetsGenericListRepository =
        AssetsListBL(_executionContextDTO!);
    Map<AssetsGenericDTOSearchParameter, dynamic> genericAssetsSearchParams = {
      AssetsGenericDTOSearchParameter.SITEID: _executionContextDTO!.siteId,
      AssetsGenericDTOSearchParameter.ISACTIVE: 1,
    };
    await assetsGenericListRepository
        .getAssetsDTOList(genericAssetsSearchParams);
    playerPointsToAdd.value += 10;

    //AssetGroupsRepository--->
    AssetGroupListBL assetGroupsListRepository =
        AssetGroupListBL(_executionContextDTO!);
    Map<AssetGroupsDTOSearchParameter, dynamic> assetGroupssearchParams = {
      AssetGroupsDTOSearchParameter.SITEID: _executionContextDTO!.siteId,
      AssetGroupsDTOSearchParameter.ISACTIVE: 1,
    };
    await assetGroupsListRepository
        .getAssetGroupsDTOList(assetGroupssearchParams);

    playerPointsToAdd.value += 10;

    // AssetsTypeListRepository --->
    AssetTypesListBL assetsTypeListRepository =
        AssetTypesListBL(_executionContextDTO!);
    Map<AssetsTypesDTOSearchParameter, dynamic> assetstypesearchParams = {
      AssetsTypesDTOSearchParameter.SITEID: _executionContextDTO!.siteId,
      AssetsTypesDTOSearchParameter.ISACTIVE: 1,
    };
    await assetsTypeListRepository.assetsTypeDTOList(assetstypesearchParams);
    playerPointsToAdd.value += 10;

    // AssetGroup_Assets Repository --->
    AssetGroupAssetsListBL assetGroupAssetsListBL =
        AssetGroupAssetsListBL(_executionContextDTO!);
    Map<AssetGroupAssetsDTOSearchParameter, dynamic>
        assetgroupassetsearchparams = {
      AssetGroupAssetsDTOSearchParameter.SITEID: _executionContextDTO!.siteId,
      AssetGroupAssetsDTOSearchParameter.ISACTIVE: 1,
    };
    await assetGroupAssetsListBL
        .assetGroupAssetsDTOList(assetgroupassetsearchparams);
    playerPointsToAdd.value += 10;

    // Task Repository -->
    TaskListBL taskListRepository = TaskListBL(_executionContextDTO!);
    Map<TaskDTOSearchParameter, dynamic> taskSearchParams = {
      TaskDTOSearchParameter.SITEID: _executionContextDTO!.siteId,
      TaskDTOSearchParameter.ISACTIVE: 1,
    };
    await taskListRepository.getTaskDTOList(taskSearchParams);
    playerPointsToAdd.value += 10;

    //TaskGroupRepository ------->
    TaskGroupsListBL taskGroupsListRepository =
        TaskGroupsListBL(_executionContextDTO!);
    Map<TaskGroupsDTOSearchParameter, dynamic> taskGroupSearchParams = {
      TaskGroupsDTOSearchParameter.SITEID: _executionContextDTO!.siteId,
      TaskGroupsDTOSearchParameter.ISACTIVE: 1,
    };
    await taskGroupsListRepository.getTaskGroupsDTOList(taskGroupSearchParams);
    playerPointsToAdd.value += 10;

    // MaintenanceServicesListRepository --->
    CheckListDetailsListBL checkListDetailsListRepository =
        CheckListDetailsListBL(_executionContextDTO!);
    Map<CheckListDetailSearchParameter, dynamic> checkListDetailssearchParams =
        {
      CheckListDetailSearchParameter.ACTIVITYTYPE: "MAINTENANCEREQUESTS",
      // CheckListDetailSearchParameter.SCHEDULEFROMDATE: "",
      // CheckListDetailSearchParameter.SCHEDULETODATE: "",
      CheckListDetailSearchParameter.SITEID: _executionContextDTO!.siteId,
      CheckListDetailSearchParameter.ISACTIVE: 1
    };
    await checkListDetailsListRepository
        .getCheckListDetailsDTOList(checkListDetailssearchParams);
    playerPointsToAdd.value += 20;

    // JobDetailsListRepository --->
    CheckListDetailsListBL jobDetailsCheclistRepository =
        CheckListDetailsListBL(_executionContextDTO!);
    Map<CheckListDetailSearchParameter, dynamic> jobDetailssearchParams = {
      CheckListDetailSearchParameter.ACTIVITYTYPE: "MAINTENANCEJOBDETAILS",
      // CheckListDetailSearchParameter.SCHEDULEFROMDATE: "",
      // CheckListDetailSearchParameter.SCHEDULETODATE: "",
      CheckListDetailSearchParameter.SITEID: _executionContextDTO!.siteId,
      CheckListDetailSearchParameter.ISACTIVE: 1
    };
    await jobDetailsCheclistRepository
        .getCheckListDetailsDTOList(jobDetailssearchParams);

    playerPointsToAdd.value += 20;

    loadstate.value = true;
  }

  void timerMethod(ExecutionContextDTO executionContext) {
    Timer.periodic(const Duration(seconds: 60), (timer) async {
      sync();
    });
  }
}

final ValueNotifier<int> playerPointsToAdd = ValueNotifier<int>(0);
final ValueNotifier<bool> loadstate = ValueNotifier<bool>(false);
