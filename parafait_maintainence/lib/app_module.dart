import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:parafait_maintainence/app/parafait_home/route/module.dart';
import 'package:parafait_maintainence/app/parafait_login_authentication/routes/module_config.dart';
import 'package:parafait_maintainence/app/parafait_login_authentication/routes/routes.dart';
import 'package:parafait_maintainence/app/parafait_network_configuration/view/parafait_network_configuration_screen.dart';
import 'package:parafait_maintainence/app/parafait_splash/view/parafait_splash_screen.dart';
import 'package:parafait_maintainence/app/settings/routes/guard/authentication_guard.dart';
import 'package:parafait_maintainence/app/settings/routes/route.dart';
import 'package:parafait_maintainence/app/settings/view/pages/semnox_app_settings_screen.dart';
import 'package:parafait_maintainence/app_module_manager.dart';
import 'package:parafait_maintainence/routes.dart';
import 'app/parafait_splash/view/parafait_site_selection_screen.dart';
import 'app/parafait_system_credential_configuration/view/parafait_system_credential_config_screen.dart';

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
      ];
}
