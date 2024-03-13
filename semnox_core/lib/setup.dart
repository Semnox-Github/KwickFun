import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:semnox_core/utils/localization/localization_handler.dart';

import 'utils/localization/localization_loader.dart';

export 'package:easy_localization/easy_localization.dart';
export 'package:easy_localization/easy_localization.dart';

Future<void> semnoxInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
}

class SemnoxLocalizationBuilder extends StatelessWidget {
  final String path;
  final Widget child;
  final LocalizationStorageHandler handler;
  const SemnoxLocalizationBuilder(
      {Key? key,
      required this.child,
      this.path = "assets/translations",
      required this.handler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      path: path,
      supportedLocales: const [Locale("en", "US")],
      fallbackLocale: const Locale("en", "US"),
      startLocale: const Locale("en", "US"),
      assetLoader: SemnoxLocalizationLoader(handler),
      child: child,
    );
  }
}
