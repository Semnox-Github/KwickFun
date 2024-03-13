import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/pos_machines/model/pos_machine_dto.dart';
import 'package:semnox_core/modules/pos_machines/repository/request/pos_machine_service.dart';
import 'package:semnox_core/utils/parafait_cache/parafait_cache.dart';
import 'package:semnox_core/utils/parafait_cache/parafait_storage.dart';

class PosMachineViewRespository {
  static String get _storageKey => "posMachine";
  static int get _cacheLife => 60 * 24;
  static ParafaitCache? _viewCache;
  static ParafaitStorage? _parafaitStorage;
  PosMachineViewRespository._internal();
  static final _singleton = PosMachineViewRespository._internal();
  factory PosMachineViewRespository() {
    _viewCache ??= ParafaitCache(_cacheLife);
    _parafaitStorage ??= ParafaitStorage(_storageKey, _cacheLife);
    return _singleton;
  }

  Future<List<PosMachineDTO>?> getPosMachineViewDTOList(
      ExecutionContextDTO executionContext) async {
    List? list = [];
    list = await _getLocalData(executionContext);
    list ??= await _getRemoteData(executionContext);
    var posMachineDTOList = PosMachineDTO.getPosMachineDTOList(list);
    return posMachineDTOList;
  }

  static Future<List?> _getLocalData(
      ExecutionContextDTO executionContext) async {
    List? cacheList = [];
    cacheList = await _viewCache?.get(_getKey("cache", executionContext));
    if (cacheList == null) {
      cacheList = await _parafaitStorage
          ?.getDataFromLocalStorage(_getKey("storage", executionContext));
      if (cacheList != null) {
        await _viewCache?.addToCache(
            _getKey("cache", executionContext), cacheList);
      }
    }
    return cacheList;
  }

  static setLocalData(ExecutionContextDTO? executionContext, List? data,
      String? serverHash) async {
    await _viewCache?.addToCache(_getKey("cache", executionContext), data);
    _parafaitStorage?.addToLocalStorage(
        _getKey("storage", executionContext), data, serverHash);
  }

  static Future<List?> _getRemoteData(
      ExecutionContextDTO? executionContext) async {
    PosMachineViewService? viewservice =
        PosMachineViewService(executionContext);
    var serverHash = await _parafaitStorage
        ?.getServerHash(_getKey("storage", executionContext!));
    Map<PosMachineDTOSearchParameter, dynamic> searchparams = {
      PosMachineDTOSearchParameter.hash: serverHash,
      PosMachineDTOSearchParameter.siteId: executionContext?.siteId,
    };
    var apiResponse =
        await viewservice.getPosMachines(searchParams: searchparams);
    if (apiResponse?.data != null) {
      await setLocalData(
          executionContext, apiResponse?.data, apiResponse?.hash);
    }
    return apiResponse?.data;
  }

  static String _getKey(String type, ExecutionContextDTO? executionContext) {
    String storageKey = "";
    switch (type) {
      case "cache":
        storageKey = executionContext!.siteHash();
        break;
      case "storage":
        storageKey = executionContext!.siteHash();
        break;
    }
    return storageKey;
  }
}
