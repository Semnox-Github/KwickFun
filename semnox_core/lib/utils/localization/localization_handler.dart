import 'dart:convert';

import 'package:flutter/material.dart';

mixin LocalizationStorageHandler {
  Future<Map<String, dynamic>> getStoredServerLocale(Locale locale);

  Future<void> storeTranslation(
      Map<String, dynamic> translations, String languageCode);
}

Map<String, dynamic> decodeJson(String string) {
  return json.decode(string);
}
