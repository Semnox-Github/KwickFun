import 'dart:io';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app_information_builder.dart';
import 'package:parafait_maintainence/app_module_manager.dart';
import 'package:parafait_maintainence/my_http_overrides.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:semnox_core/modules/app_information/provider/app_Information_provider.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/storage_service/local_storage.dart';
import 'app_module.dart';
import 'themes.dart';

void startApp() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await semnoxInit();
  await LocalStorage().initialize();
  await AppInformationProvider().buildAppInformation(
      await AppInformationBuilder().buildAppInformationFromPackage());

  final context = SecurityContext.defaultContext;
  context.allowLegacyUnsafeRenegotiation = true;
  HttpClient(context: context);

  runApp(ProviderScope(
      child: ModularApp(
    module: AppModule(MainModuleManager()),
    child: const App(),
  )));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        themeCollection: themeCollection,
        defaultThemeId: AppThemes.light,
        builder: (context, theme) {
          return MaterialApp.router(
            scaffoldMessengerKey: SemnoxSnackbar.rootScaffoldMessengerKey,
            debugShowCheckedModeBanner: false,
            theme: theme,
            title: "Semnox",
            routeInformationParser: Modular.routeInformationParser,
            routerDelegate: Modular.routerDelegate,
            builder: (BuildContext context, Widget? child) {
              double currentWidth = MediaQuery.of(context).size.shortestSide;
              MediaQueryData mediaQueryData = MediaQuery.of(context);
              return ResponsiveWrapper.builder(
                  MediaQuery(
                    data: mediaQueryData.copyWith(
                        textScaleFactor:
                            (currentWidth / SemnoxSizing.IdealWidth) *
                                mediaQueryData.textScaleFactor),
                    child: Container(child: child),
                  ),
                  debugLog: !kReleaseMode);
            },
          );
        });
  }
}
