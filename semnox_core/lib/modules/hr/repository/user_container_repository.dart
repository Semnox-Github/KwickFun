import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/hr/model/user_container_dto.dart';
import 'package:semnox_core/modules/hr/repository/request/user_container_service.dart';
import 'package:semnox_core/utils/parafait_cache/parafait_cache.dart';
import 'package:semnox_core/utils/parafait_cache/parafait_storage.dart';

class UserContainerRepository {
  static String get _storageKey => "user";
  static int get _cacheLife => 60 * 24;
  static ParafaitCache? _viewCache;
  static ParafaitStorage? _parafaitStorage;
  UserContainerRepository._internal();
  static final _singleton = UserContainerRepository._internal();

  static List? _list = [];

  factory UserContainerRepository() {
    _viewCache ??= ParafaitCache(_cacheLife);
    _parafaitStorage ??= ParafaitStorage(_storageKey, _cacheLife);
    return _singleton;
  }

  Future<List<UserContainerDto>?> getUserContainerDTOList(
      ExecutionContextDTO executionContext) async {
    _list = await _getLocalData(executionContext);
    _list ??= await _getRemoteData(executionContext);
    return null;
    // var lookupsContainerDTOList =
    //     UserContainerDto.getUserContainerDtoList(_list);
    // return lookupsContainerDTOList;
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
      ExecutionContextDTO? executionContext) async {
    var userPkid = executionContext?.userPKId;
    UserContainerService? viewservice = UserContainerService(executionContext);
    var serverHash = await _parafaitStorage
        ?.getServerHash(_getKey("storage", executionContext));
    Map<UserContainerDTOSearchParameter, dynamic> searchparams = {
      UserContainerDTOSearchParameter.HASH: serverHash,
      UserContainerDTOSearchParameter.SITEID: executionContext?.siteId ?? -1,
      UserContainerDTOSearchParameter.REBUILDCACHE: true,
    };
    var apiResponse =
        await viewservice.getUserContainer(searchParams: searchparams);
    if (apiResponse?.data != null) {
      var users = apiResponse?.data;

      // Assuming apiResponse?.data is a list of user objects
      List<Map<String, dynamic>> userIdConfirm = [];

      for (var user in users!) {
        // Check if the current user has UserId equal to 18
        if (user['UserId'] == userPkid!) {
          // If the userId is found, do something with it
          print('Found user: $user');
          userIdConfirm.add(user);

          await setLocalData(
              executionContext, userIdConfirm, apiResponse?.hash);
          break; // Exit the loop once the user is found
        }
      }
    }
    return apiResponse?.data;
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
