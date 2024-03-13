import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/hr/model/user_role_dto.dart';
import 'package:semnox_core/modules/hr/model/users_dto.dart';
import 'package:semnox_core/modules/hr/repository/user_role_repository.dart';

class UserRoleBL {
  UserRoleDTO? _userRoleDTO;

  UserRoleBL.id(ExecutionContextDTO executionContext, int id) {}

  UserRoleBL.dto(
      ExecutionContextDTO executionContext, UserRoleDTO userRoleDTO) {
    _userRoleDTO = userRoleDTO;
  }

  UserRoleDTO? getUserRoleDTO() {
    return _userRoleDTO;
  }
}

class UserRoleListBL {
  UserRoleRepository? _userRoleViewRepository;
  ExecutionContextDTO? _executionContextDTO;

  UserRoleListBL(ExecutionContextDTO? executionContext) {
    _executionContextDTO = executionContext;
    _userRoleViewRepository = UserRoleRepository();
  }

  Future<List<UserRoleDTO>?> getUserRoleDTOList(UsersDto userDTO) async {
    return await _userRoleViewRepository?.getUserRoleDTOList(_executionContextDTO,userDTO);
  }
}
