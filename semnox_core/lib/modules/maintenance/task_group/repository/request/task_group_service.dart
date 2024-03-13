import 'dart:async';
import 'dart:io';
import 'package:retry/retry.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/task_group/model/task_group_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';

class TaskGroupsService extends ModuleService {
  final r = const RetryOptions(maxAttempts: 3);
  TaskGroupsService(ExecutionContextDTO executionContextDTO)
      : super(executionContextDTO);
  static final Map<TaskGroupsDTOSearchParameter, dynamic> _queryParams = {
    TaskGroupsDTOSearchParameter.TASKGROUPID: "taskGroupId",
    TaskGroupsDTOSearchParameter.TASKGROUPNAME: "taskGroupName",
    TaskGroupsDTOSearchParameter.ISACTIVE: "isActive",
    TaskGroupsDTOSearchParameter.HASACTIVETASK: "hasActiveTask"
  };

  Future<List<TaskGroupsDTO>> getTaskGroupsList(
      Map<TaskGroupsDTOSearchParameter, dynamic> searchParams) async {
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          .get("/api/Maintenance/TaskGroups",
              queryParameters:
                  await _constructContainerQueryParams(searchParams))
          .timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var data = response.data;
    if (data is! Map) throw AppException("Invalid response.");
    List<TaskGroupsDTO> dtos = [];
    if (data["data"] != null) {
      List rawList = data["data"];
      for (var item in rawList) {
        dtos.add(TaskGroupsDTO.fromMap(item));
      }
    }
    return dtos;
  }

  Future<Map<String, dynamic>> _constructContainerQueryParams(
      Map<TaskGroupsDTOSearchParameter, dynamic> searchParams) async {
    Map<String, dynamic> queryparameter = {};
    _queryParams.forEach((key, value) {
      var valu = searchParams[key];
      if (valu != null) {
        queryparameter.addAll({value: valu});
      }
    });
    return queryparameter;
  }
}
