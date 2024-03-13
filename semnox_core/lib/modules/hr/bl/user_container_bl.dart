import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/hr/model/user_container_dto.dart';
import 'package:semnox_core/modules/hr/model/users_dto.dart';
import 'package:semnox_core/modules/hr/repository/user_container_repository.dart';

class UserContainerBL {
  UsersDto? _usersDto;

  UserContainerBL.id(ExecutionContextDTO executionContext, int id) {}

  UserContainerBL.dto(
      {ExecutionContextDTO? executionContext, UsersDto? usersDto}) {
    _usersDto = usersDto;
  }
}

class UserContainerListBL {
  UserContainerRepository? _lookupViewRepository;
  ExecutionContextDTO? _executionContext;

  UserContainerListBL(ExecutionContextDTO? executionContext) {
    _lookupViewRepository = UserContainerRepository();
    _executionContext = executionContext;
  }

  Future<List<UserContainerDto>?> getUserContainerDTOList() async {
    return await _lookupViewRepository
        ?.getUserContainerDTOList(_executionContext!);
  }
}
