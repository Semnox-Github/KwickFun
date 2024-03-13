import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/messages/model/translation_view_dto.dart';
import 'package:semnox_core/modules/messages/repository/request/translation_service.dart';
import 'package:semnox_core/utils/parafait_cache/parafait_cache.dart';
import 'package:semnox_core/utils/parafait_cache/parafait_storage.dart';

class TranslationViewRepository {
  static String get _storageKey => "translation";
  static int get _cacheLife => 60 * 24;
  static ParafaitCache? _viewCache;
  static ParafaitStorage? _parafaitStorage;
  TranslationViewRepository._internal();
  static final _singleton = TranslationViewRepository._internal();

  static List? _list = [];

  factory TranslationViewRepository() {
    _viewCache ??= ParafaitCache(_cacheLife);
    _parafaitStorage ??= ParafaitStorage(_storageKey, _cacheLife);
    return _singleton;
  }

  Future<List<TranslationViewDTOList>?> getTranslationViewDTOList(
      ExecutionContextDTO executionContext) async {
    _list = await _getLocalData(executionContext);
    _list ??= await _getRemoteData(executionContext);
    var translationViewDTOList =
        TranslationViewDTOList.getTranslationViewDTOList(_list);
    return translationViewDTOList;
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
    TranslationService? viewservice = TranslationService(executionContext);
    // var _serverHash = LocalStorage().get(_getKey("serverhash"));
    var serverHash = await _parafaitStorage
        ?.getServerHash(_getKey("storage", executionContext!));

    //Create search parmeters
    Map<TranslationViewDTOSearchParameter, dynamic> searchparams = {
      TranslationViewDTOSearchParameter.SITEID: executionContext?.siteId,
      TranslationViewDTOSearchParameter.HASH: serverHash,
      TranslationViewDTOSearchParameter.LANGUAGEID:
          executionContext?.languageId,
      TranslationViewDTOSearchParameter.REBUILDCACHE: true
    };
    var apiResponse =
        await viewservice.gettranslation(searchParams: searchparams);
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
        storageKey = executionContext!.siteHash() +
            executionContext.languageId.toString();
        break;
      case "storage":
        storageKey = executionContext!.siteHash() +
            executionContext.languageId.toString();
        break;
    }
    return storageKey;
  }
}
