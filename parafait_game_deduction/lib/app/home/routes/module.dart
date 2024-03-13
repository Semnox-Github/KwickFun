import 'package:flutter_modular/flutter_modular.dart';
import 'package:game_ride/routes.dart';

import '../../game_ride/routes/module.dart';
import '../../settings/routes/guard/authentication_guard.dart';
import '../../settings/routes/route.dart';

class HomeModule extends Module {
  // static String game = "game";
  static String card = "card";

  @override
  List<ModularRoute> get routes => [
        // ChildRoute("/", child: (context, args) => SemnoxHomeScreen()),
        ModuleRoute("/", module: GameModule()),
        ModuleRoute(AppRoutes.settings, module: SettingsModule(), guards: [
          SettingsAuthGuard("/"),
        ]),
      ];
}
