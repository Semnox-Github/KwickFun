import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/task_group/model/task_group_dto.dart';
import 'package:semnox_core/modules/maintenance/task_group/model/taskgroupsummary_dto.dart';
import 'package:semnox_core/modules/maintenance/task_group/repository/dbhandler/task_group_dbhandler.dart';
import 'package:semnox_core/modules/maintenance/task_group/repository/request/task_group_service.dart';
import 'package:semnox_core/utils/database/dataConstant.dart';
import 'package:semnox_core/utils/utils.dart';

class TaskGroupRepositories {
  TaskGroupsService? _taskGroupsService;
  ExecutionContextDTO? _executionContextDTO;
  int? count = 0;
  List<SyncDetails>? syncdataList = [];

  TaskGroupRepositories(ExecutionContextDTO executionContextDTO) {
    _executionContextDTO = executionContextDTO;
    _taskGroupsService = TaskGroupsService(_executionContextDTO!);
  }

  Future<List<TaskGroupsDTO>> getTaskGroupDTOList(
      Map<TaskGroupsDTOSearchParameter, dynamic> searchParams) async {
    late List<TaskGroupsDTO> localTaskGroupsDTOList;
    TaskGroupDbHandler taskGroupLocalDataHandler =
        TaskGroupDbHandler(_executionContextDTO!);

    final result = await Connectivity().checkConnectivity();
    if (result.name != "none") {
      List<TaskGroupsDTO> serverTaskGroupDTOList =
          await _taskGroupsService!.getTaskGroupsList(searchParams);

      if (serverTaskGroupDTOList.isNotEmpty) {
        localTaskGroupsDTOList =
            await taskGroupLocalDataHandler.getTaskGroupsList(searchParams);

        for (var element in serverTaskGroupDTOList) {
          bool insertElement = false;
          if (localTaskGroupsDTOList.isEmpty) {
            insertElement = true;
          } else {
            Iterable<TaskGroupsDTO> myListFiltered = localTaskGroupsDTOList
                .where((e) => e.jobTaskGroupId == element.jobTaskGroupId);

            if (myListFiltered.isNotEmpty) {
              // the entry exists, so update
              TaskGroupsDTO taskGroupsDTO = myListFiltered.first;
              if (element.lastUpdatedDate != taskGroupsDTO.lastUpdatedDate) {
                taskGroupsDTO.RefreshServerValues(element);
                int status = await TaskGroupDbHandler(_executionContextDTO!)
                    .updateTaskGroup(taskGroupsDTO);
                if (status != -1) {
                  count = count! + 1;
                  if (count == serverTaskGroupDTOList.length) {
                    var syncdetails = SyncDetails(
                        type: DatabaseTableName.TABLE_TASKGROUP,
                        insertedcount: count,
                        totalcount: serverTaskGroupDTOList.length,
                        syncstatus: serverTaskGroupDTOList.length == count
                            ? "Completed"
                            : "Syncing");
                    syncdataList?.add(syncdetails);
                    taskgroupCrudCount.value =
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
            TaskGroupsDTO taskGroupsDTO = TaskGroupsDTO();
            taskGroupsDTO.RefreshServerValues(element);
            int status = await TaskGroupDbHandler(_executionContextDTO!)
                .insertTaskGroup(taskGroupsDTO);
            if (status != -1) {
              count = count! + 1;
              if (count == serverTaskGroupDTOList.length) {
                var syncdetails = SyncDetails(
                    type: DatabaseTableName.TABLE_TASKGROUP,
                    insertedcount: count,
                    totalcount: serverTaskGroupDTOList.length,
                    syncstatus: serverTaskGroupDTOList.length == count
                        ? "Completed"
                        : "Syncing");
                syncdataList?.add(syncdetails);
                taskgroupCrudCount.value =
                    SyncData(percent: 20.00, syncdetails: syncdataList);
              }
            }
          }
        }
      }
    }
    localTaskGroupsDTOList =
        await taskGroupLocalDataHandler.getTaskGroupsList(searchParams);
    return localTaskGroupsDTOList;
  }

  Future<List<TaskGroupViewSummaryDTO>> getTaskgroupSummaryFromLocalDB(
      Map<TaskGroupSummaryDTOSearchParameter, dynamic> searchParameter) async {
    List<TaskGroupViewSummaryDTO> taskgroupsummarydto;
    TaskGroupDbHandler taskGroupLocalDataHandler =
        TaskGroupDbHandler(_executionContextDTO!);
    taskgroupsummarydto = (await taskGroupLocalDataHandler
        .getTaskGroupSummaryDTO(searchParameter))!;
    return taskgroupsummarydto;
  }
}

final ValueNotifier<SyncData> taskgroupCrudCount =
    ValueNotifier<SyncData>(SyncData(percent: 0.00, syncdetails: []));
