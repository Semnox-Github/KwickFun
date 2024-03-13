import 'dart:async';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';
import 'package:semnox_core/modules/sites/repository/request/site_view_service.dart';
import 'package:semnox_core/utils/parafait_cache/parafait_cache.dart';
import 'package:semnox_core/utils/parafait_cache/parafait_storage.dart';

class SiteViewRepository {
  static String get _storageKey => "site";
  static int get _cacheLife => 60 * 24;
  static ParafaitCache? _viewCache;
  static ParafaitStorage? _parafaitStorage;
  SiteViewRepository._internal();
  static final _singleton = SiteViewRepository._internal();

  static List? _list = [];

  factory SiteViewRepository() {
    _viewCache ??= ParafaitCache(_cacheLife);
    _parafaitStorage ??= ParafaitStorage(_storageKey, _cacheLife);
    return _singleton;
  }

  Future<List<SiteViewDTO>?> getSiteViewDTOList(
      ExecutionContextDTO executionContext) async {
    _list = await _getLocalData(executionContext);
    _list ??= await _getRemoteData(executionContext);
    var siteViewDTOList = SiteViewDTO.getSiteDTOList(_list);
    return siteViewDTOList;
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
    SiteViewService? viewservice = SiteViewService(executionContext);
    var serverHash = await _parafaitStorage
        ?.getServerHash(_getKey("storage", executionContext!));
    //Create search parmeters
    Map<SiteViewDTOSearchParameter, dynamic> searchparams = {
      SiteViewDTOSearchParameter.hash: serverHash,
      SiteViewDTOSearchParameter.siteId: executionContext?.siteId,
      SiteViewDTOSearchParameter.rebuildcache: true,
    };
    // get sites data from API
    var apiResponse = await viewservice.getSites(searchParams: searchparams);
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

  SiteViewDTO? getSiteById(int id) {
    return null;
  }
}
