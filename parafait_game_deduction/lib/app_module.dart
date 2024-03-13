import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:game_ride/app/game_ride/view/pages/set_game_machine.dart';
import 'package:game_ride/app/parafait_network_configuration/view/parafait_network_configuration_screen.dart';
import 'package:game_ride/app/parafait_splash/view/parafait_splash_screen.dart';
import 'package:game_ride/app/parafait_system_credential_configuration/view/parafait_system_credential_config_screen.dart';
import 'package:game_ride/app/settings/routes/guard/authentication_guard.dart';
import 'package:game_ride/app/settings/routes/route.dart';
import 'package:game_ride/app/settings/view/pages/semnox_app_settings_screen.dart';
import 'package:game_ride/app_module_manager.dart';
import 'package:game_ride/routes.dart';
import 'app/home/routes/module.dart';
import 'app/parafait_login_authentication/routes/module_config.dart';
import 'app/parafait_login_authentication/routes/routes.dart';
import 'app/parafait_splash/view/parafait_site_selection_screen.dart';

class AppModule extends Module {
  final MainModuleManager manager;
  AppModule(this.manager);
  @override
  List<ModularRoute> get routes => [
        ChildRoute(AppRoutes.splash,
            transition: TransitionType.fadeIn,
            child: (context, args) => const ParafaitSplashScreen()),
        ChildRoute(AppRoutes.sitePage,
            transition: TransitionType.fadeIn,
            child: (context, args) => const ParafaitSiteSelectionScreen()),
        ChildRoute(AppRoutes.networkConfiguartion,
            transition: TransitionType.fadeIn,
            child: (context, args) => ParafaitNetworkConfiguration()),
        ModuleRoute(
          AuthenticationModule.loginPage,
          module: AuthenticationModule(
            AuthModuleConfig(
              onAuthenticationComplete: manager.onAuthenticationComplete,
            ),
          ),
        ),
        ChildRoute(AppRoutes.systemcredsave,
            transition: TransitionType.fadeIn,
            child: (context, args) => const ParafaitSystemCredentialConfig()),
        ModuleRoute(
          AppRoutes.home,
          module: HomeModule(),
        ),
        ModuleRoute(AppRoutes.settings, module: SettingsModule(), guards: [
          SettingsAuthGuard(AppRoutes.home),
        ]),
        ChildRoute(
          AppRoutes.appsetting,
          child: (context, args) => const SemnoxAppSettingsScreen(),
        ),
        ChildRoute(AppRoutes.machines,
            child: (context, args) => const GameMachineList(),
            guards: [
              // SettingsAuthGuard(),
            ]),
      ];
}
