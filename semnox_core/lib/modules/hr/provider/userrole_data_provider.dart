import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/hr/bl/user_role_bl.dart';
import 'package:semnox_core/modules/hr/bl/users_bl.dart';
import 'package:semnox_core/modules/hr/model/user_container_dto.dart';
import 'package:semnox_core/modules/hr/model/user_role_dto.dart';
import 'package:semnox_core/modules/hr/model/users_dto.dart';

class UserRoleDataProvider {
  static ExecutionContextDTO? _executionContextDTO;
  static final Map<int, UserRoleDTO> _userrolemap = {};
  UserRoleDataProvider({ExecutionContextDTO? executionContextDTO}) {
    _executionContextDTO = executionContextDTO;
  }

  initialize() async {
    Map<UserDTOSearchParameter, dynamic> userparams = {
      UserDTOSearchParameter.SITEID: _executionContextDTO?.siteId ?? -1,
      //_executionContextDTO?.userPKId
      UserDTOSearchParameter.REBUILDCACHE: true
    };
//here it starts to go HR/Users

    var userDTO = await UserBL.dto(executionContext: _executionContextDTO)
        .getUserDTO(userparams);
    print('UserDTOCheck:$userDTO');
    //this was getting null for normal user
    //  if (userDTO != null) {
    // Map<UserRoleViewDTOSearchParameter, dynamic> userroleparams = {
    //   UserRoleViewDTOSearchParameter.roleId: userDTO.roleId,
    //   UserRoleViewDTOSearchParameter.loadChildRecords: false,
    //   UserRoleViewDTOSearchParameter.isActive: true,
    // };

    var userRoleDTOList =
        await UserRoleListBL(_executionContextDTO).getUserRoleDTOList(userDTO!);
    if (userRoleDTOList != null) {
      _loaduserrole(userRoleDTOList, userDTO.roleId);
    }
    // }
  }

  //calls here
  static Iterable<UserRoleDTO> getuserroleDTO() {
    return (_userrolemap.values);
  }

  void _loaduserrole(List<UserRoleDTO> userroleDTOList, roleId) {
    _userrolemap.clear();
    for (var item in userroleDTOList) {
      // print('userDtoget$usersDto');
      if (item.roleId == roleId) {
        _userrolemap[item.roleId!] = item;
        break;
      }
    }
  }
}
