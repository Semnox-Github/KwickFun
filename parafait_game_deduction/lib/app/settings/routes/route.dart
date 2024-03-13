import 'package:flutter_modular/flutter_modular.dart';

import '../../game_ride/view/pages/set_game_machine.dart';
import '../settings.dart';
import 'guard/authentication_guard.dart';

class SettingsModule extends Module {
  static String appsetting = "appsetting";
  static String machines = "machines";

  @override
  List<Bind<Object>> get binds =>
      [Bind.singleton<AuthGuardState>((_) => AuthGuardState())];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/$appsetting",
            child: (context, args) => const SemnoxAppSettingsScreen(),
            guards: [
              // SettingsAuthGuard(),
            ]),
        ChildRoute("/$machines",
            child: (context, args) => const GameMachineList(),
            guards: [
              // SettingsAuthGuard(),
            ]),
      ];
}
