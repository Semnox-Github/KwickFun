import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/parafait_login_authentication/view/parafait_login_screen.dart';
import 'package:parafait_maintainence/app/parafait_login_authentication/view_model/login_view_model.dart';
import 'module_config.dart';

class AuthenticationModule extends Module {
  final AuthModuleConfig config;

  AuthenticationModule(this.config);

  @override
  List<Bind<Object>> get binds => [Bind((_) => config)];

  ///
  /// Possible Routes
  ///

  static const loginPage = "/login";
  @override
  List<ModularRoute> get routes => [
        ChildRoute("/",
            child: (context, _) => Consumer(builder: (context, ref, child) {
                  return ParafaitLoginScreen(
                    viewModel: ref.watch(LoginViewModel.provider),
                    onAuthenticationComplete: config.onAuthenticationComplete,
                  );
                }))
      ];
}
