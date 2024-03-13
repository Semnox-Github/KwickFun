import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart' show AssetLoader;
import 'package:flutter/services.dart';
import 'localization_handler.dart';

class SemnoxLocalizationLoader extends AssetLoader {
  final LocalizationStorageHandler localizationHandler;

  SemnoxLocalizationLoader(this.localizationHandler);
  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) async {
    // LocalizationStorageHandler localizationHandler =
    //     LocalizationStorageHandler();
    final localePath = _getLocalePath(path, locale);

    ///
    ///Load App Locales
    ///
    Map<String, dynamic> appLocals = {};
    log('''
      ********************

      Loading Asset Translations For $locale

      ********************
      ''');
    try {
      appLocals = jsonDecode(await rootBundle.loadString(localePath));
    } catch (e) {
      log('''
      ********************

      No Asset File For Locale $locale

      ********************
      ''');
    }

    log('''
      ********************

      Loading Stored Server Translations For $locale

      ********************
      ''');

    ///
    ///  Get Server Localizations.
    ///
    Map<String, dynamic> storedServerLocale = {};

    try {
      storedServerLocale =
          await localizationHandler.getStoredServerLocale(locale);
    } catch (e) {}

    ///
    ///  Merge App translationss & server translations.
    ///
    return storedServerLocale..addAll(appLocals);
  }

  String _getLocalePath(String basePath, Locale locale) {
    return '$basePath/${localeToString(locale, separator: "-")}.json';
  }

  String localeToString(Locale locale, {String separator = '_'}) {
    return locale.toString().split('_').join(separator);
  }
}
