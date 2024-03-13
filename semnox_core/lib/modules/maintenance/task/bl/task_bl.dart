import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/task/model/task_dto.dart';
import 'package:semnox_core/modules/maintenance/task/repository/task_repositories.dart';

class TaskBL {
  TaskDto? _taskDto;
  ExecutionContextDTO? _executionContextDTO;
  TaskRepositories? _taskRepositories;

  TaskBL.id(ExecutionContextDTO executionContextDTO, int id) {
    _executionContextDTO = executionContextDTO;
    _taskRepositories = TaskRepositories(_executionContextDTO!);
  }

  TaskBL.dto(ExecutionContextDTO executionContextDTO, TaskDto taskDto) {
    _executionContextDTO = executionContextDTO;
    _taskDto = taskDto;
    _taskRepositories = TaskRepositories(_executionContextDTO!);
  }
}

class TaskListBL {
  late ExecutionContextDTO _executionContextDTO;
  TaskRepositories? _taskRepositories;
  TaskListBL(ExecutionContextDTO executionContext) {
    _executionContextDTO = executionContext;
    _taskRepositories = TaskRepositories(_executionContextDTO);
  }

  Future<List<TaskDto>?> getTaskDTOList(
      Map<TaskDTOSearchParameter, dynamic> tasksearchParams) async {
    return await _taskRepositories?.getTaskDTOList(tasksearchParams);
  }
}
