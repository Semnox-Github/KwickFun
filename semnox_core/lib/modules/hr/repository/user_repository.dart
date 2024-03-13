import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/hr/model/users_dto.dart';
import 'package:semnox_core/modules/hr/repository/request/user_service.dart';

class UserRepository {
  UserService? _userService;

  UserRepository(ExecutionContextDTO? executionContextDTO) {
    _userService = UserService(executionContextDTO);
  }

  Future<List<UsersDto>?> getUserDTOList(
      Map<UserDTOSearchParameter, dynamic> params) async {
    return await _userService?.getUserDTOList(params);
  }
}

// import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
// import 'package:semnox_core/modules/hr/model/user_container_dto.dart';
// import 'package:semnox_core/modules/hr/model/users_dto.dart';
// import 'package:semnox_core/modules/hr/repository/request/user_container_service.dart';
// import 'package:semnox_core/utils/parafait_cache/parafait_cache.dart';
// import 'package:semnox_core/utils/parafait_cache/parafait_storage.dart';

// class UserRepository {
//   static String get _storageKey => "user";
//   static int get _cacheLife => 60 * 24;
//   static ParafaitCache? _viewCache;
//   static ParafaitStorage? _parafaitStorage;
//   UserRepository._internal();
//   static final _singleton = UserRepository._internal();

//   static List? _list = [];

//   factory UserRepository(ExecutionContextDTO executionContextDTO) {
//     _viewCache ??= ParafaitCache(_cacheLife);
//     _parafaitStorage ??= ParafaitStorage(_storageKey, _cacheLife);
//     return _singleton;
//   }

//   Future<List<UserContainerDto>?> getUserContainerDTOList(
//       ExecutionContextDTO executionContext) async {
//     _list = await _getLocalData(executionContext);
//     _list ??= await _getRemoteData(executionContext);
//     var lookupsContainerDTOList =
//         UserContainerDto.getUserContainerDtoList(_list);
//     return lookupsContainerDTOList;
//   }

//   static Future<List?> _getLocalData(
//       ExecutionContextDTO executionContext) async {
//     _list = await _viewCache?.get(_getKey("cache", executionContext));
//     if (_list == null) {
//       _list = await _parafaitStorage
//           ?.getDataFromLocalStorage(_getKey("storage", executionContext));
//       if (_list != null) {
//         await _viewCache?.addToCache(_getKey("cache", executionContext), _list);
//       }
//     }
//     return _list;
//   }

//   static setLocalData(ExecutionContextDTO? executionContext, List? data,
//       String? serverHash) async {
//     await _viewCache?.addToCache(_getKey("cache", executionContext), data);
//     _parafaitStorage?.addToLocalStorage(
//         _getKey("storage", executionContext), data, serverHash);
//   }

//   static Future<List?> _getRemoteData(
//       ExecutionContextDTO? executionContext) async {
//     UserContainerService? viewservice = UserContainerService(executionContext);
//     var serverHash = await _parafaitStorage
//         ?.getServerHash(_getKey("storage", executionContext));
//     Map<UserContainerDTOSearchParameter, dynamic> searchparams = {
//       UserContainerDTOSearchParameter.HASH: serverHash,
//       UserContainerDTOSearchParameter.SITEID: executionContext?.siteId ?? -1,
//       UserContainerDTOSearchParameter.REBUILDCACHE: true,
//     };
//     var apiResponse =
//         await viewservice.getUserContainer(searchParams: searchparams);
//     if (apiResponse?.data != null) {
//       await setLocalData(
//           executionContext, apiResponse?.data, apiResponse?.hash);
//     }
//     return apiResponse?.data;
//   }

//   static String _getKey(String type, ExecutionContextDTO? executionContext) {
//     String storageKey = "";
//     switch (type) {
//       case "cache":
//         storageKey = executionContext!.longsiteHash();
//         break;
//       case "storage":
//         storageKey = executionContext!.longsiteHash();
//         break;
//     }
//     return storageKey;
//   }

//   getUserDTOList(Map<UserDTOSearchParameter, dynamic> params) {}
// }
