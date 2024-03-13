import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/task/model/task_dto.dart';
import 'package:semnox_core/modules/maintenance/task/repository/dbhandler/task_dbhandler.dart';
import 'package:semnox_core/modules/maintenance/task/repository/request/task_service.dart';
import 'package:semnox_core/utils/database/dataConstant.dart';
import 'package:semnox_core/utils/utils.dart';

class TaskRepositories {
  TaskService? _taskService;
  ExecutionContextDTO? _executionContext;
  int? count = 0;
  List<SyncDetails>? syncdataList = [];

  TaskRepositories(ExecutionContextDTO executionContext) {
    _executionContext = executionContext;
    _taskService = TaskService(_executionContext!);
  }
  Future<List<TaskDto>> getTaskDTOList(
      Map<TaskDTOSearchParameter, dynamic> tasksearchParams) async {
    late List<TaskDto> localTaskDTOList;
    TaskDbHandler taskDataHandler = TaskDbHandler(_executionContext!);
    final result = await Connectivity().checkConnectivity();
    if (result.name != "none") {
      List<TaskDto> serverTaskDTOList =
          await _taskService!.getTaskDTOList(tasksearchParams);

      if (serverTaskDTOList.isNotEmpty) {
        localTaskDTOList =
            await taskDataHandler.getTaskDTOList(tasksearchParams);

        for (var element in serverTaskDTOList) {
          bool insertElement = false;
          if (localTaskDTOList.isEmpty) {
            insertElement = true;
          } else {
            Iterable<TaskDto> myListFiltered =
                localTaskDTOList.where((e) => e.jobTaskId == element.jobTaskId);

            if (myListFiltered.isNotEmpty) {
              // the entry exists, so update
              TaskDto taskDTO = myListFiltered.first;
              if (element.lastupdatedDate != taskDTO.lastupdatedDate) {
                taskDTO.refreshServerValues(element);
                int status =
                    await TaskDbHandler(_executionContext!).updateTask(taskDTO);
                if (status != -1) {
                  count = count! + 1;
                  if (count == serverTaskDTOList.length) {
                    var syncdetails = SyncDetails(
                        type: DatabaseTableName.TABLE_TASK,
                        insertedcount: count,
                        totalcount: serverTaskDTOList.length,
                        syncstatus: serverTaskDTOList.length == count
                            ? "Completed"
                            : "Syncing");
                    syncdataList?.add(syncdetails);
                    taskCrudCount.value =
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
            TaskDto taskDTO = TaskDto();
            taskDTO.refreshServerValues(element);
            int status =
                await TaskDbHandler(_executionContext!).insertTask(taskDTO);
            if (status != -1) {
              count = count! + 1;
              if (count == serverTaskDTOList.length) {
                var syncdetails = SyncDetails(
                    type: DatabaseTableName.TABLE_TASK,
                    insertedcount: count,
                    totalcount: serverTaskDTOList.length,
                    syncstatus: serverTaskDTOList.length == count
                        ? "Completed"
                        : "Syncing");
                syncdataList?.add(syncdetails);
                taskCrudCount.value =
                    SyncData(percent: 20.00, syncdetails: syncdataList);
              }
            }
          }
        }
      }
    }
    localTaskDTOList = await taskDataHandler.getTaskDTOList(tasksearchParams);
    return localTaskDTOList;
  }
}

final ValueNotifier<SyncData> taskCrudCount =
    ValueNotifier<SyncData>(SyncData(percent: 0.00, syncdetails: []));
