import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:parafait_maintainence/app/lookupRules/MaintainanceLookupsAndRulesBL.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/maintenance/assets/bl/assetGroup_Assets_BL.dart';
import 'package:semnox_core/modules/maintenance/assets/bl/asset_types_BL.dart';
import 'package:semnox_core/modules/maintenance/assets/bl/assetgroups_BL.dart';
import 'package:semnox_core/modules/maintenance/assets/bl/assets_bl.dart';
import 'package:semnox_core/modules/maintenance/assets/model/asset_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/asset_type_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/assetgroup_Assets_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/assets_group_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/repository/asset_type_repositories.dart';
import 'package:semnox_core/modules/maintenance/assets/repository/assets_repositories.dart';
import 'package:semnox_core/modules/maintenance/assets/repository/assetsgroup_assets_repositories.dart';
import 'package:semnox_core/modules/maintenance/assets/repository/assetsgroup_repositories.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/bl/comments_bl.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/bl/image_bl.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/bl/maintainence_BL.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/comments_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/images_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/maintainence_service_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/repositories/maintainence_repositories.dart';
import 'package:semnox_core/modules/maintenance/task/bl/task_BL.dart';
import 'package:semnox_core/modules/maintenance/task/model/task_dto.dart';
import 'package:semnox_core/modules/maintenance/task/repository/task_repositories.dart';
import 'package:semnox_core/modules/maintenance/task_group/bl/task_group_BL.dart';
import 'package:semnox_core/modules/maintenance/task_group/model/task_group_dto.dart';
import 'package:semnox_core/modules/maintenance/task_group/repository/task_group_repositories.dart';
import 'package:semnox_core/modules/parafait_defaults_configuration/provider/default_config.dart';
import 'package:semnox_core/utils/database/dataConstant.dart';
import 'package:semnox_core/utils/storage_service/local_storage.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:logger/logger.dart';

class SyncViewmodel extends ChangeNotifier {
  static final provider = ChangeNotifierProvider<SyncViewmodel>((ref) {
    return SyncViewmodel();
  });
  static String get _fromserverSync => "fromServerSync";
  static String get _toserverSync => "toServerSync";
  static String get _lastSyncDateTimestorageKey => "lastsyncDatetime";
  int syncpercentage = 0;
  static const bool _timerStarted = false;
  ExecutionContextDTO? _executionContextDTO;
  static SyncViewmodel? _instance;
  MaintainanceLookupsAndRulesBL? maintainanceLookupsAndRulesRepository;
  late int syncfreqtime = 60;
  SyncData? fromSyncevent, toSyncevent;
  UploadandDownload? uploadanddownload = UploadandDownload();
  SyncViewmodel._() {
    sync();
  }

  factory SyncViewmodel() {
    _instance ??= SyncViewmodel._();
    return _instance!;
  }
  Future<void> sync() async {
    _executionContextDTO =
        await ExecutionContextProvider().getExecutionContext();
    syncfreqtime = int.parse(
        DefaultConfigProvider.getConfigFor("THIRD_PARTY_SYSTEM_SYNCH_FREQUENCY")
            .toString());
    String dateFormat = 'yyyy-MM-dd h:mm';
    //DateFormat(DefaultConfigProvider.getConfigFor("DATETIME_FORMAT"));
    var lastsyncDatetime = LocalStorage().get(_lastSyncDateTimestorageKey);
    int elpasedTimeinSeconds = 0;
    if (lastsyncDatetime == null) {
      elpasedTimeinSeconds = 999999;
    } else {
      DateTime currentDt =
          DateFormat(dateFormat).parse(DateTime.now().toString());
      Duration diff = currentDt.difference(
          DateFormat(dateFormat).parse(json.decode(lastsyncDatetime)));
      elpasedTimeinSeconds = 30;
      // diff.inMinutes;
    }
    if (elpasedTimeinSeconds >= 20) {
      await _uploadServer();
      await _downloadServer();
      LocalStorage().save(
          _lastSyncDateTimestorageKey, json.encode(DateTime.now().toString()));
      LocalStorage().save(_fromserverSync, json.encode(fromSyncevent?.toMap()));
      LocalStorage().save(_toserverSync, json.encode(toSyncevent?.toMap()));
    }
    if (!_timerStarted) {
      await uploadanddownload?.fromServer(fromSyncevent =
          SyncData.fromMap(json.decode(LocalStorage().get(_fromserverSync)!)));
      await uploadanddownload?.toServer(toSyncevent =
          SyncData.fromMap(json.decode(LocalStorage().get(_toserverSync)!)));
      // timerMethod();
    }
  }

  Future<void> _uploadServer() async {
    maintainanceLookupsAndRulesRepository =
        MaintainanceLookupsAndRulesBL(_executionContextDTO!);

    Logger().d('''
              ${"*" * 10}
              Entity: "File Upload POST" : Start Time: ${DateTime.now()}
              ${"*" * 10}
      ''');

    await postfileupload();

    Logger().d('''
              ${"*" * 10}
              Entity: "File Upload POST" :  End Time: ${DateTime.now()},
              Total Record: ${fileUploadCount.value.syncdetails!.isNotEmpty ? fileUploadCount.value.syncdetails?.first.totalcount : 0}
              Inserted Record To server: ${fileUploadCount.value.syncdetails!.isNotEmpty ? fileUploadCount.value.syncdetails?.first.insertcount : 0}
              ${"*" * 10}
      ''');

    Logger().d('''
              ${"*" * 10}
              Entity: "SR POST" : Start Time: ${DateTime.now()}
              ${"*" * 10}
      ''');

    await postsr();

    Logger().d('''
              ${"*" * 10}
              Entity: "SR POST" : End Time: ${DateTime.now()}
              Total Record: ${checkListCount.value.syncdetails!.isNotEmpty ? checkListCount.value.syncdetails?.first.totalcount : 0}
              Inserted Record To server : ${checkListCount.value.syncdetails!.isNotEmpty ? checkListCount.value.syncdetails?.first.insertcount : 0}
              ${"*" * 10}
      ''');

    Logger().d('''
              ${"*" * 10}
              Entity: "TASK POST" : Start Time: ${DateTime.now()}
              ${"*" * 10}
      ''');

    await posttask();

    Logger().d('''
              ${"*" * 10}
              Entity: "TASK POST" : End Time: ${DateTime.now()}
              Total Record: ${taskCount.value.syncdetails!.isNotEmpty ? taskCount.value.syncdetails?.first.totalcount : 0}
              Inserted Record To server : ${taskCount.value.syncdetails!.isNotEmpty ? taskCount.value.syncdetails?.first.insertcount : 0}
              ${"*" * 10}
      ''');

    Logger().d('''
              ${"*" * 10}
              Entity: "IMAGES POST" : Start Time: ${DateTime.now()}
              ${"*" * 10}
      ''');

    await postimages();

    Logger().d('''
              ${"*" * 10}
              Entity: "IMAGES POST" : End Time: ${DateTime.now()}
              Total Record: ${imageCount.value.syncdetails!.isNotEmpty ? imageCount.value.syncdetails?.first.totalcount : 0}
              Inserted Record To server : ${imageCount.value.syncdetails!.isNotEmpty ? imageCount.value.syncdetails?.first.insertcount : 0}
              ${"*" * 10}
      ''');

    Logger().d('''
              ${"*" * 10}
              Entity: "COMMENT POST" : Start Time: ${DateTime.now()}
              ${"*" * 10}
      ''');

    await postcomments();

    Logger().d('''
              ${"*" * 10}
              Entity: "COMMENT POST" : End Time: ${DateTime.now()}
              Total Record: ${commentCount.value.syncdetails!.isNotEmpty ? commentCount.value.syncdetails?.first.totalcount : 0}
              Inserted Record To server : ${commentCount.value.syncdetails!.isNotEmpty ? commentCount.value.syncdetails?.first.insertcount : 0}
              ${"*" * 10}
      ''');
  }

  Future<void> postfileupload() async {
    int? count = 0;
    List<SyncDetails>? syncdataList = [];
    ImageListBL imageListBL = ImageListBL(_executionContextDTO!);
    Map<ImageSearchParameter, dynamic> searchparams = {
      ImageSearchParameter.SITEID: _executionContextDTO!.siteId,
      ImageSearchParameter.ISACTIVE: 1,
      ImageSearchParameter.SERVERSYNC: 0
    };
    List<ImageDTO> imagedtolist =
        await imageListBL.getimageDTOList(searchparams);
    if (imagedtolist.isNotEmpty) {
      for (var imagedto in imagedtolist) {
        ImageBL imageBL = ImageBL.dto(_executionContextDTO!, imagedto);
        bool result = await imageBL.postfileupload();
        if (result == true) {
          count = count! + 1;
          if (count == imagedtolist.length) {
            var syncdetails = SyncDetails(
                type: DatabaseTableName.TABLE_IMAGE,
                insertedcount: count,
                totalcount: imagedtolist.length,
                syncstatus:
                    imagedtolist.length == count ? "Completed" : "Syncing");
            syncdataList.add(syncdetails);
            fileUploadCount.value =
                SyncData(percent: 10.00, syncdetails: syncdataList);
          }
        }
      }
    }
    toSyncevent = fileUploadCount.value;
    await uploadanddownload?.toServer(toSyncevent!);
  }

  Future<void> postsr() async {
    int? count = 0;
    List<SyncDetails>? syncdataList = [];
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
        var result = await checkListDetailsRepository
            .postChecklistDTOServer(postsearchparams);
        if (result != -1) {
          count = count! + 1;
          if (count == srDto.length) {
            var syncdetails = SyncDetails(
                type: DatabaseTableName.TABLE_CHECKLIST_DETAIL,
                insertedcount: count,
                totalcount: srDto.length,
                syncstatus: srDto.length == count ? "Completed" : "Syncing");
            syncdataList.add(syncdetails);
            checkListCount.value =
                SyncData(percent: 10.00, syncdetails: syncdataList);
          }
        }
      }
    }
    toSyncevent = checkListCount.value;
    await uploadanddownload?.toServer(toSyncevent!);
  }

  Future<void> posttask() async {
    int? count = 0;
    List<SyncDetails>? syncdataList = [];
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
        var result = await checkListDetailsRepository
            .postChecklistDTOServer(postsearchparams);
        if (result != -1) {
          count = count! + 1;
          if (count == taskDto.length) {
            var syncdetails = SyncDetails(
                type: DatabaseTableName.TABLE_TASK,
                insertedcount: count,
                totalcount: taskDto.length,
                syncstatus: taskDto.length == count ? "Completed" : "Syncing");
            syncdataList.add(syncdetails);
            taskCount.value =
                SyncData(percent: 10.00, syncdetails: syncdataList);
          }
        }
      }
    }
    toSyncevent = taskCount.value;
    await uploadanddownload?.toServer(toSyncevent!);
  }

  Future<void> postimages() async {
    int? count = 0;
    List<SyncDetails>? syncdataList = [];
    ImageListBL imageListBL = ImageListBL(_executionContextDTO!);
    Map<ImageSearchParameter, dynamic> searchparams = {
      ImageSearchParameter.SITEID: _executionContextDTO!.siteId,
      ImageSearchParameter.ISACTIVE: 1,
      ImageSearchParameter.SERVERSYNC: 0
    };
    List<ImageDTO> imagedtolist =
        await imageListBL.getimageDTOList(searchparams);
    if (imagedtolist.isNotEmpty) {
      for (var imagedto in imagedtolist) {
        Map<ImageSearchParameter, dynamic> postsearchparams = {
          ImageSearchParameter.ISACTIVE: 1
        };
        ImageBL imageBL = ImageBL.dto(_executionContextDTO!, imagedto);
        var result = await imageBL.postImageDTO(postsearchparams);
        if (result != -1) {
          count = count! + 1;
          if (count == imagedtolist.length) {
            var syncdetails = SyncDetails(
                type: DatabaseTableName.TABLE_IMAGE,
                insertedcount: count,
                totalcount: imagedtolist.length,
                syncstatus:
                    imagedtolist.length == count ? "Completed" : "Syncing");
            syncdataList.add(syncdetails);
            imageCount.value =
                SyncData(percent: 10.00, syncdetails: syncdataList);
          }
        }
      }
    }
    toSyncevent = imageCount.value;
    await uploadanddownload?.toServer(toSyncevent!);
  }

  Future<void> postcomments() async {
    int? count = 0;
    List<SyncDetails>? syncdataList = [];
    CommentsListBL commentsListBL = CommentsListBL(_executionContextDTO!);
    Map<CommentsSearchParameter, dynamic> searchparams = {
      CommentsSearchParameter.SITEID: _executionContextDTO!.siteId,
      CommentsSearchParameter.ISACTIVE: 1,
      CommentsSearchParameter.SERVERSYNC: 0
    };
    List<CommentsDTO> commentdtoList =
        await commentsListBL.getcommentDTOList(searchparams);
    if (commentdtoList.isNotEmpty) {
      for (var commentdto in commentdtoList) {
        Map<CommentsSearchParameter, dynamic> postsearchparams = {
          CommentsSearchParameter.ISACTIVE: 1
        };
        CommentsBL commentsBL =
            CommentsBL.dto(_executionContextDTO!, commentdto);
        var result = await commentsBL.postCommentDTo(postsearchparams);
        if (result != -1) {
          count = count! + 1;
          if (count == commentdtoList.length) {
            var syncdetails = SyncDetails(
                type: DatabaseTableName.TABLE_CHECKLIST_DETAIL,
                insertedcount: count,
                totalcount: commentdtoList.length,
                syncstatus:
                    commentdtoList.length == count ? "Completed" : "Syncing");
            syncdataList.add(syncdetails);
            commentCount.value =
                SyncData(percent: 10.00, syncdetails: syncdataList);
          }
        }
      }
    }
    toSyncevent = commentCount.value;
    await uploadanddownload?.toServer(toSyncevent!);
  }

  Future<void> _downloadServer() async {
    Logger().d('''
              ${"*" * 10}
              Entity: "ASSETS GET" : Start Time: ${DateTime.now()}
              ${"*" * 10}
      ''');
    //AssetsListRepository ---->
    AssetsListBL assetsGenericListRepository =
        AssetsListBL(_executionContextDTO!);
    Map<AssetsGenericDTOSearchParameter, dynamic> genericAssetsSearchParams = {
      AssetsGenericDTOSearchParameter.SITEID: _executionContextDTO!.siteId,
      AssetsGenericDTOSearchParameter.ISACTIVE: 1,
    };
    await assetsGenericListRepository
        .getAssetsDTOList(genericAssetsSearchParams);
    fromSyncevent = assetCrudCount.value;
    await uploadanddownload?.fromServer(fromSyncevent!);

    Logger().d('''
              ${"*" * 10}
              Entity: "ASSETS GET" : End Time: ${DateTime.now()}
              Total Record: ${assetCrudCount.value.syncdetails!.isNotEmpty ? assetCrudCount.value.syncdetails?.first.totalcount : 0}
              Inserted Record To DB: ${assetCrudCount.value.syncdetails!.isNotEmpty ? assetCrudCount.value.syncdetails?.first.insertcount : 0}
              ${"*" * 10}
      ''');

    Logger().d('''
              ${"*" * 10}
              Entity: "ASSETGROUP GET" : Start Time: ${DateTime.now()}
              ${"*" * 10}
      ''');

    AssetGroupListBL assetGroupsListRepository =
        AssetGroupListBL(_executionContextDTO!);
    Map<AssetGroupsDTOSearchParameter, dynamic> assetGroupssearchParams = {
      AssetGroupsDTOSearchParameter.SITEID: _executionContextDTO!.siteId,
      AssetGroupsDTOSearchParameter.ISACTIVE: 1,
    };
    await assetGroupsListRepository
        .getAssetGroupsDTOList(assetGroupssearchParams);
    fromSyncevent?.percent = assetGroupCrudCount.value.percent;
    fromSyncevent?.addsyncdetails = assetGroupCrudCount.value.syncdetails;
    await uploadanddownload?.fromServer(fromSyncevent!);

    Logger().d('''
              ${"*" * 10}
              Entity: "ASSETGROUP GET" : End Time: ${DateTime.now()}
              Total Record: ${assetGroupCrudCount.value.syncdetails!.isNotEmpty ? assetGroupCrudCount.value.syncdetails?.first.totalcount : 0}
              Inserted Record To DB: ${assetGroupCrudCount.value.syncdetails!.isNotEmpty ? assetGroupCrudCount.value.syncdetails?.first.insertcount : 0}
              ${"*" * 10}
      ''');

    Logger().d('''
              ${"*" * 10}
              Entity: "ASSETTYPE GET" : Start Time: ${DateTime.now()}
              ${"*" * 10}
      ''');

    AssetTypesListBL assetsTypeListRepository =
        AssetTypesListBL(_executionContextDTO!);
    Map<AssetsTypesDTOSearchParameter, dynamic> assetstypesearchParams = {
      AssetsTypesDTOSearchParameter.SITEID: _executionContextDTO!.siteId,
      AssetsTypesDTOSearchParameter.ISACTIVE: 1,
    };
    await assetsTypeListRepository.assetsTypeDTOList(assetstypesearchParams);
    fromSyncevent?.percent = assetTypeCrudCount.value.percent;
    fromSyncevent?.addsyncdetails = assetTypeCrudCount.value.syncdetails;
    await uploadanddownload?.fromServer(fromSyncevent!);

    Logger().d('''
              ${"*" * 10}
              Entity: "ASSETTYPE GET" : End Time: ${DateTime.now()}
              Total Record: ${assetTypeCrudCount.value.syncdetails!.isNotEmpty ? assetTypeCrudCount.value.syncdetails?.first.totalcount : 0}
              Inserted Record To DB : ${assetTypeCrudCount.value.syncdetails!.isNotEmpty ? assetTypeCrudCount.value.syncdetails?.first.insertcount : 0}
              ${"*" * 10}
      ''');

    Logger().d('''
              ${"*" * 10}
              Entity: "ASSETGROUPASSET GET" : Start Time: ${DateTime.now()}
              ${"*" * 10}
      ''');

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
    fromSyncevent?.percent = assetgroupassetCrudCount.value.percent;
    fromSyncevent?.addsyncdetails = assetgroupassetCrudCount.value.syncdetails;
    await uploadanddownload?.fromServer(fromSyncevent!);

    Logger().d('''
              ${"*" * 10}
              Entity: "ASSETGROUPASSET GET" : End Time: ${DateTime.now()}
              Total Record: ${assetgroupassetCrudCount.value.syncdetails!.isNotEmpty ? assetgroupassetCrudCount.value.syncdetails?.first.totalcount : 0}
              Inserted Record To DB : ${assetgroupassetCrudCount.value.syncdetails!.isNotEmpty ? assetgroupassetCrudCount.value.syncdetails?.first.insertcount : 0}
              ${"*" * 10}
      ''');

    Logger().d('''
              ${"*" * 10}
              Entity: "TASK GET" : Start Time: ${DateTime.now()}
              ${"*" * 10}
      ''');

    // Task Repository -->
    TaskListBL taskListRepository = TaskListBL(_executionContextDTO!);
    Map<TaskDTOSearchParameter, dynamic> taskSearchParams = {
      TaskDTOSearchParameter.SITEID: _executionContextDTO!.siteId,
      TaskDTOSearchParameter.ISACTIVE: 1,
    };
    await taskListRepository.getTaskDTOList(taskSearchParams);
    fromSyncevent?.percent = taskCrudCount.value.percent;
    fromSyncevent?.addsyncdetails = taskCrudCount.value.syncdetails;
    await uploadanddownload?.fromServer(fromSyncevent!);

    Logger().d('''
              ${"*" * 10}
              Entity: "TASK GET" : End Time: ${DateTime.now()}
              Total Record: ${taskCrudCount.value.syncdetails!.isNotEmpty ? taskCrudCount.value.syncdetails?.first.totalcount : 0}
              Inserted Record To DB : ${taskCrudCount.value.syncdetails!.isNotEmpty ? taskCrudCount.value.syncdetails?.first.insertcount : 0}
              ${"*" * 10}
      ''');

    Logger().d('''
              ${"*" * 10}
              Entity: "TASKGROUP GET" : Start Time: ${DateTime.now()}
              ${"*" * 10}
      ''');
    //TaskGroupRepository ------->
    TaskGroupsListBL taskGroupsListRepository =
        TaskGroupsListBL(_executionContextDTO!);
    Map<TaskGroupsDTOSearchParameter, dynamic> taskGroupSearchParams = {
      TaskGroupsDTOSearchParameter.SITEID: _executionContextDTO!.siteId,
      TaskGroupsDTOSearchParameter.ISACTIVE: 1,
    };
    await taskGroupsListRepository.getTaskGroupsDTOList(taskGroupSearchParams);
    fromSyncevent?.percent = taskgroupCrudCount.value.percent;
    fromSyncevent?.addsyncdetails = taskgroupCrudCount.value.syncdetails;
    await uploadanddownload?.fromServer(fromSyncevent!);

    Logger().d('''
              ${"*" * 10}
              Entity: "TASKGROUP GET" : End Time: ${DateTime.now()}
              Total Record: ${taskgroupCrudCount.value.syncdetails!.isNotEmpty ? taskgroupCrudCount.value.syncdetails?.first.totalcount : 0}
              Inserted Record To DB : ${taskgroupCrudCount.value.syncdetails!.isNotEmpty ? taskgroupCrudCount.value.syncdetails?.first.insertcount : 0}
              ${"*" * 10}
      ''');

    Logger().d('''
              ${"*" * 10}
              Entity: "SR & JOB GET" : Start Time: ${DateTime.now()}
              ${"*" * 10}
      ''');

    // MaintenanceServicesListRepository --->
    CheckListDetailsListBL checkListDetailsListRepository =
        CheckListDetailsListBL(_executionContextDTO!);
    Map<CheckListDetailSearchParameter, dynamic> checkListDetailssearchParams =
        {
      CheckListDetailSearchParameter.ACTIVITYTYPE: "MAINTENANCEREQUESTS",
      CheckListDetailSearchParameter.SCHEDULEFROMDATE:
          DateTime.now().subtract(const Duration(days: 7)),
      CheckListDetailSearchParameter.SCHEDULETODATE:
          DateTime.now().add(const Duration(days: 7)),
      CheckListDetailSearchParameter.SITEID: _executionContextDTO!.siteId,
      CheckListDetailSearchParameter.ISACTIVE: 1
    };
    await checkListDetailsListRepository
        .getCheckListDetailsDTOList(checkListDetailssearchParams);

    // JobDetailsListRepository --->
    CheckListDetailsListBL jobDetailsCheclistRepository =
        CheckListDetailsListBL(_executionContextDTO!);
    Map<CheckListDetailSearchParameter, dynamic> jobDetailssearchParams = {
      CheckListDetailSearchParameter.ACTIVITYTYPE: "MAINTENANCEJOBDETAILS",
      CheckListDetailSearchParameter.SCHEDULEFROMDATE:
          DateTime.now().subtract(const Duration(days: 7)),
      CheckListDetailSearchParameter.SCHEDULETODATE:
          DateTime.now().add(const Duration(days: 7)),
      CheckListDetailSearchParameter.SITEID: _executionContextDTO!.siteId,
      CheckListDetailSearchParameter.ISACTIVE: 1,
    };
    await jobDetailsCheclistRepository
        .getCheckListDetailsDTOList(jobDetailssearchParams);
    fromSyncevent?.percent = maintCheckListCrudCount.value.percent;
    fromSyncevent?.addsyncdetails = maintCheckListCrudCount.value.syncdetails;
    await uploadanddownload?.fromServer(fromSyncevent!);

    Logger().d('''
              ${"*" * 10}
              Entity: "SR & JOB GET" : End Time: ${DateTime.now()}
              Total Record: ${maintCheckListCrudCount.value.syncdetails!.isNotEmpty ? maintCheckListCrudCount.value.syncdetails?.first.totalcount : 0}
              Inserted Record To DB : ${maintCheckListCrudCount.value.syncdetails!.isNotEmpty ? maintCheckListCrudCount.value.syncdetails?.first.insertcount : 0}
              ${"*" * 10}
      ''');
  }

  void timerMethod() {
    Timer.periodic(const Duration(seconds: 120), (timer) async {
      sync();
    });
  }
}

final ValueNotifier<SyncData> fileUploadCount =
    ValueNotifier<SyncData>(SyncData(percent: 0.00, syncdetails: []));
final ValueNotifier<SyncData> checkListCount =
    ValueNotifier<SyncData>(SyncData(percent: 0.00, syncdetails: []));
final ValueNotifier<SyncData> taskCount =
    ValueNotifier<SyncData>(SyncData(percent: 0.00, syncdetails: []));
final ValueNotifier<SyncData> imageCount =
    ValueNotifier<SyncData>(SyncData(percent: 0.00, syncdetails: []));
final ValueNotifier<SyncData> commentCount =
    ValueNotifier<SyncData>(SyncData(percent: 0.00, syncdetails: []));
