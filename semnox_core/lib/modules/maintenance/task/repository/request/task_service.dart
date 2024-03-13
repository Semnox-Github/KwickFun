import 'dart:async';
import 'dart:io';
import 'package:retry/retry.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/task/model/task_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';

class TaskService extends ModuleService {
  final r = const RetryOptions(maxAttempts: 3);
  TaskService(ExecutionContextDTO executionContextDTO)
      : super(executionContextDTO);

  static final Map<TaskDTOSearchParameter, dynamic> _queryParams = {
    TaskDTOSearchParameter.TASKID: "taskId",
    TaskDTOSearchParameter.ISACTIVE: "isActive",
    TaskDTOSearchParameter.TASKGROUPID: "taskGroupId",
    TaskDTOSearchParameter.TASKNAME: "taskName",
    TaskDTOSearchParameter.SITEID: "siteId"
  };

  Future<List<TaskDto>> getTaskDTOList(
      Map<TaskDTOSearchParameter, dynamic> searchparms) async {
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          .get("/api/Maintenance/Tasks",
              queryParameters:
                  await _constructContainerQueryParams(searchparms))
          .timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var data = response.data;
    if (data is! Map) throw AppException("Invalid response.");
    List<TaskDto> dtos = [];
    if (data["data"] != null) {
      List rawList = data["data"];
      for (var item in rawList) {
        dtos.add(TaskDto.fromMap(item));
      }
    }
    return dtos;
  }

  Future<Map<String, dynamic>> _constructContainerQueryParams(
      Map<TaskDTOSearchParameter, dynamic> searchParams) async {
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
