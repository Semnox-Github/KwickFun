import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/hr/model/users_dto.dart';
import 'package:semnox_core/modules/hr/repository/user_repository.dart';

class UserBL {
  UsersDto? _usersDto;
  UserRepository? _userRepository;
  ExecutionContextDTO? _executionContextDTO;

  UserBL.id(ExecutionContextDTO executionContext, int id) {
    _userRepository = UserRepository(executionContext);
  }

  UserBL.dto({ExecutionContextDTO? executionContext, UsersDto? usersDto}) {
    _usersDto = usersDto;
    _userRepository = UserRepository(executionContext!);
    _executionContextDTO = executionContext;
  }

  Future<UsersDto?> getUserDTO(
      Map<UserDTOSearchParameter, dynamic> params) async {
    var userDTOList = await _userRepository?.getUserDTOList(params);
    if (userDTOList!.isNotEmpty && _executionContextDTO != null) {
      for (var user in userDTOList) {
        if (user.userId == _executionContextDTO?.userPKId) {
          _usersDto = user;
        }
      }
    }
    return _usersDto;
  }
}

class UserListBL {
  UserRepository? _userRepository;

  UserListBL(ExecutionContextDTO? executionContext) {
    _userRepository = UserRepository(executionContext!);
  }

  Future<List<UsersDto>?> getUserDTOList(
      Map<UserDTOSearchParameter, dynamic> params) async {
    return await _userRepository?.getUserDTOList(params);
  }
}

// import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
// import 'package:semnox_core/modules/hr/model/user_container_dto.dart';
// import 'package:semnox_core/modules/hr/model/users_dto.dart';
// import 'package:semnox_core/modules/hr/repository/user_container_repository.dart';

// class UserContainerBL {
//   UserContainerBL.id(ExecutionContextDTO executionContext, int id) {}

//   UserContainerBL.dto(
//       {ExecutionContextDTO? executionContext, UserContainerDto? usersDto}) {}

//   getUserContainerDTOList(Map<UserDTOSearchParameter, dynamic> userparams) {}

//   userContainerBL(Map<UserDTOSearchParameter, dynamic> userparams) {}
// }

// class UserContainerListBL {
//   UserContainerRepository? _lookupViewRepository;
//   ExecutionContextDTO? _executionContext;

//   UserContainerListBL(ExecutionContextDTO? executionContext) {
//     _lookupViewRepository = UserContainerRepository();
//     _executionContext = executionContext;
//   }

//   Future<List<UserContainerDto>?> getUserContainerDTOList() async {
//     return await _lookupViewRepository
//         ?.getUserContainerDTOList(_executionContext!);
//   }
// }
