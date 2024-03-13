import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/task_group/model/task_group_dto.dart';
import 'package:semnox_core/modules/maintenance/task_group/model/taskgroupsummary_dto.dart';
import 'package:semnox_core/modules/maintenance/task_group/repository/task_group_repositories.dart';

class TaskGroupsBL {
  TaskGroupsDTO? _taskGroupsDTO;
  ExecutionContextDTO? _executionContextDTO;
  TaskGroupRepositories? _taskGroupRepositories;

  TaskGroupsBL.id(ExecutionContextDTO executionContextDTO, int id) {
    _executionContextDTO = executionContextDTO;
    _taskGroupRepositories = TaskGroupRepositories(_executionContextDTO!);
  }

  TaskGroupsBL.dto(
      ExecutionContextDTO executionContextDTO, TaskGroupsDTO taskGroupsDTO) {
    _executionContextDTO = executionContextDTO;
    _taskGroupsDTO = taskGroupsDTO;
    _taskGroupRepositories = TaskGroupRepositories(_executionContextDTO!);
  }
}

class TaskGroupsListBL {
  late ExecutionContextDTO _executionContextDTO;
  TaskGroupRepositories? _taskGroupRepositories;
  TaskGroupsListBL(ExecutionContextDTO executionContextDTO) {
    _executionContextDTO = executionContextDTO;
    _taskGroupRepositories = TaskGroupRepositories(_executionContextDTO);
  }

  Future<List<TaskGroupsDTO>?> getTaskGroupsDTOList(
      Map<TaskGroupsDTOSearchParameter, dynamic> taskGroupsSearchParams) async {
    return await _taskGroupRepositories
        ?.getTaskGroupDTOList(taskGroupsSearchParams);
  }

  Future<List<TaskGroupViewSummaryDTO>> getTaskgroupSummaryFromLocalDB(
      Map<TaskGroupSummaryDTOSearchParameter, dynamic> searchParameter) async {
    List<TaskGroupViewSummaryDTO> taskgroupsummarydto;
    taskgroupsummarydto = (await _taskGroupRepositories
        ?.getTaskgroupSummaryFromLocalDB(searchParameter))!;
    return taskgroupsummarydto;
  }
}
