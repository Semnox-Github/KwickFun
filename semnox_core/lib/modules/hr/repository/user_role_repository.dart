import 'dart:async';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/hr/model/user_role_dto.dart';
import 'package:semnox_core/modules/hr/model/users_dto.dart';
import 'package:semnox_core/modules/hr/repository/request/user_role_service.dart';
import 'package:semnox_core/utils/parafait_cache/parafait_cache.dart';
import 'package:semnox_core/utils/parafait_cache/parafait_storage.dart';

// class UserRoleRepository {
//   UserRoleService? _userRoleService;

//   UserRoleRepository(ExecutionContextDTO? executionContextDTO) {
//     _userRoleService = UserRoleService(executionContextDTO);
//   }

//   Future<List<UserRoleDTO>?> getUserRoleDTOList(
//       Map<UserRoleViewDTOSearchParameter, dynamic> params) async {
//     return await _userRoleService?.getUserRoleDTOList(params);
//   }
// }

class UserRoleRepository {
  static String get _storageKey => "userrole";
  static int get _cacheLife => 60 * 24;
  static ParafaitCache? _viewCache;
  static ParafaitStorage? _parafaitStorage;
  UserRoleRepository._internal();
  static final _singleton = UserRoleRepository._internal();

  static List? _list = [];

  factory UserRoleRepository() {
    _viewCache ??= ParafaitCache(_cacheLife);
    _parafaitStorage ??= ParafaitStorage(_storageKey, _cacheLife);
    return _singleton;
  }

  Future<List<UserRoleDTO>?> getUserRoleDTOList(
      ExecutionContextDTO? executionContext, UsersDto userDTO) async {
    _list = await _getLocalData(executionContext!);
    _list ??= await _getRemoteData(executionContext, userDTO);
    var lookupsContainerDTOList = UserRoleDTO.getUserRoleDTOList(_list);
    return lookupsContainerDTOList;
  }

  static Future<List?> _getLocalData(
      ExecutionContextDTO executionContext) async {
    _list = await _viewCache?.get(_getKey("cache", executionContext));
    if (_list == null) {
      _list = await _parafaitStorage
          ?.getDataFromLocalStorage(_getKey("storage", executionContext));
      if (_list != null) {
        await _viewCache?.addToCache(_getKey("cache", executionContext), _list);
      }
    }
    return _list;
  }

  static setLocalData(ExecutionContextDTO? executionContext, List? data,
      String? serverHash) async {
    await _viewCache?.addToCache(_getKey("cache", executionContext), data);
    _parafaitStorage?.addToLocalStorage(
        _getKey("storage", executionContext), data, serverHash);
  }

  static Future<List?> _getRemoteData(
      ExecutionContextDTO? executionContext, UsersDto userDTO) async {
    UserRoleService? viewservice = UserRoleService(executionContext);

    Map<UserRoleViewDTOSearchParameter, dynamic> userroleparams = {
      // UserRoleViewDTOSearchParameter.roleId: userDTO.roleId,
      // UserRoleViewDTOSearchParameter.loadChildRecords: false,
      // UserRoleViewDTOSearchParameter.isActive: true,
      UserRoleViewDTOSearchParameter.siteId: executionContext?.siteId,
      UserRoleViewDTOSearchParameter.rebuildCache: true,
    };
    var apiResponse = await viewservice.getUserRoleDTOList(userroleparams);

    await setLocalData(executionContext, apiResponse, null);
    return apiResponse;
  }

  static String _getKey(String type, ExecutionContextDTO? executionContext) {
    String storageKey = "";
    switch (type) {
      case "cache":
        storageKey = executionContext!.longsiteHash();
        break;
      case "storage":
        storageKey = executionContext!.longsiteHash();
        break;
    }
    return storageKey;
  }
}
