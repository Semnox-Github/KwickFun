import 'package:hive_flutter/hive_flutter.dart';

import 'local_storage.dart';
// import  'package:shared_preferences/shared_preferences.dart';

class HiveLocalStorage with LocalStorage {
  // late HiveBo sharedPreferences;

  static HiveLocalStorage instance = HiveLocalStorage._();
  HiveLocalStorage._();
  late Box box;
  @override
  Future<void> initialize([Box? initialBox]) async {
    if (initialBox != null) {
      box = initialBox;
      return;
    }
    await Hive.initFlutter();
    box = await Hive.openBox('semnox_storage_box');
  }

  @override
  Future<void> save(String key, String value) async {
    await box.put(key, value);
    // sharedPreferences.setString(key, value);
  }

  @override
  String? get(String key) {
    return box.get(key);
    // return sharedPreferences.getString(key);
  }

  @override
  Future<void> delete(String key) {
    return box.delete(key);
  }
}
