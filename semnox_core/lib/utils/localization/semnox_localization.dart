import 'package:easy_localization/easy_localization.dart';
// ignore: implementation_imports
import 'package:easy_localization/src/localization.dart';
import 'package:flutter/cupertino.dart';

class SemnoxLocalization {
  static loadLocalization(BuildContext context, String languageCode,
      Map<String, dynamic> translations) {
// LocalizationStorageHandler _handler = LocalizationStorageHandler();

// _handler.storeTranslation(translations, languageCode);
    final localizationController =
        EasyLocalization.of(context)?.delegate.localizationController;

    localizationController?.loadTranslations().then((_) => Localization.load(
          EasyLocalization.of(context)!.locale,
          translations: localizationController.translations,
        ));
  }
}
