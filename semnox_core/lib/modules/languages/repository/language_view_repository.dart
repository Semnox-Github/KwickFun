import 'dart:async';

import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/languages/model/language_container_dto.dart';
import 'package:semnox_core/modules/languages/repository/request/language_view_service.dart';
import 'package:semnox_core/utils/parafait_cache/parafait_cache.dart';
import 'package:semnox_core/utils/parafait_cache/parafait_storage.dart';

class LanguageViewRepository {
  static String get _storageKey => "language";
  static int get _cacheLife => 60 * 24;
  static ParafaitCache? _viewCache;
  static ParafaitStorage? _parafaitStorage;
  LanguageViewRepository._internal();
  static final _singleton = LanguageViewRepository._internal();

  static List? _list = [];

  factory LanguageViewRepository() {
    _viewCache ??= ParafaitCache(_cacheLife);
    _parafaitStorage ??= ParafaitStorage(_storageKey, _cacheLife);
    return _singleton;
  }

  Future<List<LanguageContainerDto>?> getLanguageViewDTOList(
      ExecutionContextDTO executionContext) async {
    _list = await _getLocalData(executionContext);
    _list ??= await _getRemoteData(executionContext);
    var languageContainerDTOList =
        LanguageContainerDto.getLanguageDTOList(_list);
    return languageContainerDTOList;
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
    LanguageViewService? viewservice = LanguageViewService(executionContext);
    var serverHash = await _parafaitStorage
        ?.getServerHash(_getKey("storage", executionContext));

    //Create search parmeters
    Map<LanguageViewDTOSearchParameter, dynamic> searchparams = {
      LanguageViewDTOSearchParameter.hash: serverHash,
      LanguageViewDTOSearchParameter.siteId: executionContext.siteId,
      LanguageViewDTOSearchParameter.rebuildcache: true,
    };

    // get sites data from API
    var apiResponse =
        await viewservice.getLanguageContainer(searchParams: searchparams);
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
