import 'package:flutter_modular/flutter_modular.dart';
import '../settings.dart';
import 'guard/authentication_guard.dart';

class SettingsModule extends Module {
  static String appsetting = "appsetting";

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
      ];
}
