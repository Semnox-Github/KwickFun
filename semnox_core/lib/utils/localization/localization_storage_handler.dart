import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:semnox_core/utils/storage_service/local_storage.dart';
import 'package:semnox_core/setup.dart';
import 'package:semnox_core/utils/localization/localization_handler.dart';

class AppLocalizationStorageHandler with LocalizationStorageHandler {
  @override
  Future<Map<String, dynamic>> getStoredServerLocale(Locale locale) async {
    LocalStorage localStorage = LocalStorage();

    String? storedTranslation = localStorage
        .get("localization-" + locale.toStringWithSeparator(separator: "-"));

    if (storedTranslation?.isEmpty ?? false) return {};

    Map<String, dynamic> translation =
        await compute(decodeJson, storedTranslation ?? "{}");
    return translation;
  }

  @override
  Future<void> storeTranslation(
      Map<String, dynamic> translations, String languageCode) async {
    LocalStorage localStorage = LocalStorage();
    await localStorage.save(
        "localization-" + languageCode, json.encode(translations));
  }
}
