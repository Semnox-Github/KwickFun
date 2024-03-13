import 'hive_local_storage_service.dart';

export 'hive_local_storage_service.dart';

abstract class LocalStorage {
  factory LocalStorage() => HiveLocalStorage.instance;
  Future<void> initialize();
  Future<void> save(String key, String value);
  String? get(String key);
  Future<void> delete(String key);
}
