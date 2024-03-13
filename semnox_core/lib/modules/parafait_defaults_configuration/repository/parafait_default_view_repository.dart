import 'dart:async';

import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/parafait_defaults_configuration/model/parafait_default_values_dto.dart';
import 'package:semnox_core/modules/parafait_defaults_configuration/repository/request/parafait_default_view_service.dart';
import 'package:semnox_core/utils/parafait_cache/parafait_cache.dart';
import 'package:semnox_core/utils/parafait_cache/parafait_storage.dart';

class ParafaitDefaultViewRepository {
  static String get _storageKey => "default_config";
  static int get _cacheLife => 60 * 24;
  static ParafaitCache? _viewCache;
  static ParafaitStorage? _parafaitStorage;
  ParafaitDefaultViewRepository._internal();
  static final _singleton = ParafaitDefaultViewRepository._internal();
  static List? _list = [];

  factory ParafaitDefaultViewRepository() {
    _viewCache ??= ParafaitCache(_cacheLife);
    _parafaitStorage ??= ParafaitStorage(_storageKey, _cacheLife);
    return _singleton;
  }

  Future<List<ParafaitDefaultValueDto>?> getParfaitDefaultViewDTO(
      ExecutionContextDTO executionContext) async {
    _list = await _getLocalData(executionContext);
    _list ??= await _getRemoteData(executionContext);
    var parafaitDefaultValueDTOList =
        ParafaitDefaultValueDto.getParafaitDefaultDTOList(_list);
    return parafaitDefaultValueDTOList;
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
      ExecutionContextDTO executionContext) async {
    ParafaitDefaultViewService? viewservice =
        ParafaitDefaultViewService(executionContext);
    // var _serverHash = LocalStorage().get(_getKey("serverhash"));
    var serverHash = await _parafaitStorage
        ?.getServerHash(_getKey("storage", executionContext));

    //Create search parmeters
    Map<ParafaitDefaultValueDTOSearchParameter, dynamic> searchparams = {
      ParafaitDefaultValueDTOSearchParameter.hash: serverHash,
      ParafaitDefaultValueDTOSearchParameter.siteId: executionContext.siteId,
      ParafaitDefaultValueDTOSearchParameter.rebuildcache: true,
    };
    var apiResponse = await viewservice.getParafaitDefaultContainer(
        searchParams: searchparams);
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
