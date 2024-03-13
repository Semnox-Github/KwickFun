import 'dart:collection';

class ParafaitCache<T> {
  HashMap<String, ParafaitCacheItem>? _cache;
  int _dataLifeInMins = 60;

  ParafaitCache(int dataLifeInMins) {
    _cache = HashMap<String, ParafaitCacheItem>();
    _dataLifeInMins = dataLifeInMins;
  }

  Future<T?> get(String hash) async {
    var cacheItem = _cache?[hash];

    if (cacheItem == null) return null;

    if (cacheItem.isDataStale()) {
      _cache?.remove(hash);
      return null;
    }
    return cacheItem.getcacheObjectList();
  }

  addToCache(String hash, T? viewDTOMap) async {
    var cacheItem = _cache?.putIfAbsent(
        hash, () => ParafaitCacheItem(_dataLifeInMins, viewDTOMap));

    if (cacheItem!.isDataStale()) {
      _cache?.remove(hash);
      cacheItem = _cache?.putIfAbsent(
          hash, () => ParafaitCacheItem(_dataLifeInMins, viewDTOMap));
    }
  }
}

class ParafaitCacheItem<T> {
  T? _cacheObjectList;
  DateTime? _lastRefreshedTime;
  int _dataLifeInMins = 60;

  ParafaitCacheItem(int dataLifeInMins, T? cacheObjectList) {
    _dataLifeInMins = dataLifeInMins;
    _cacheObjectList = cacheObjectList;
    _lastRefreshedTime = DateTime.now();
  }

  // Check the data is stale or not stale
  bool isDataStale() {
    if (_lastRefreshedTime == null) {
      return true;
    }

    if (_lastRefreshedTime!.isBefore(
        DateTime.now().subtract(Duration(minutes: _dataLifeInMins)))) {
      // _dataLifeInMins = 1440
      return true;
    } else {
      return false;
    }
  }

  T? getcacheObjectList() {
    return _cacheObjectList;
  }
}
