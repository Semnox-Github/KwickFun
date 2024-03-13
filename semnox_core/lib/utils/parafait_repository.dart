// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:semnox_core/modules/semnoxcore/executioncontext/model/execution_context.dart';
// import 'package:semnox_core/modules/semnoxcore/parafait_network_configuration/repository/module/module_repository.dart';
// import 'package:semnox_core/utils/parafait_cache/parafait_cache.dart';
// import 'package:semnox_core/utils/storage_service/local_storage.dart';

// abstract class ParafaitViewRepository {
//   ExecutionContext? _executionContext;
//   ParafaitCache? _viewCache;
//   String? _storageKey;
//   int? _cacheLife;
//   DateTime? _lastRefreshedTime;

//   ParafaitViewRepository(
//       ExecutionContext? executionContext, String? storageKey, int? cacheLife)
//       : super() {
//     _executionContext = executionContext;
//     _storageKey = storageKey! + "_" + _executionContext!.siteHash();
//     _cacheLife = cacheLife;
//     if (_cacheLife! <= 0) _cacheLife = 120;

//     _viewCache = ParafaitCache(_cacheLife!);

//     if (LocalStorage().get(_storageKey! + "_" + "lrt") != null) {
//       _lastRefreshedTime =
//           DateTime.parse(LocalStorage().get(_storageKey! + "_" + "lrt")!);
//     }
//   }

//   bool _isLocalDataStale() {
//     int cacheLifeinMins = _cacheLife ?? 60;
//     if (_lastRefreshedTime == null) {
//       return true;
//     } else if (_lastRefreshedTime!.isBefore(
//         DateTime.now().subtract(Duration(minutes: cacheLifeinMins)))) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future<List<Object>?> getLocalData() async {
//     List<Object>? _viewDTOList = [];

//     // check if the value is present in the cache
//     _viewDTOList = await _viewCache?.get(_executionContext);

//     // if the value is not there in cache, check if it is in local
//     _viewDTOList ??= await _getLocal();

//     return _viewDTOList;
//   }

//   Future<List<Object>?> getRemoteData();

//   Future<List<Object>?> _getLocal() async {
//     final stored = LocalStorage().get(_storageKey!);
//     if (stored == null || stored.isEmpty) return null;

//     Map<String, dynamic> decoded =
//         await compute(ModuleRepository.jsonDecode, stored);

//     // if the value is there in local and if it is not stale, add it to cache
//     if (!_isLocalDataStale()) {
//       await _viewCache?.add(_executionContext!, decoded.entries.toList());
//       return decoded.entries.toList();
//     } else {
//       return null;
//     }
//   }

//   setLocalData(data) async {
//     await _viewCache?.add(_executionContext!, data);
//     LocalStorage().save(_storageKey!, json.encode(data));
//     LocalStorage()
//         .save(_storageKey! + "_" + "lrt", json.encode(DateTime.now()));

//     // set last refreshed time, only when the data is added to the local
//     // else it will be null, indicating it is not refreshed from server
//     // this is required to support offline mode
//     _lastRefreshedTime = DateTime.now();
//   }

//   ExecutionContext? getExecutionContextState() {
//     return _executionContext;
//   }

//   Future<List<Object>?> getLocalDBData();

//   Future<void>? setLocalDBData(data);

//   String? getServersiteHash() {
//     return LocalStorage().get(_storageKey! + "_" + "hash");
//   }

//   setServerHash(hash) async {
//     LocalStorage().save(_storageKey! + "_" + "hash", hash);
//   }
// }
