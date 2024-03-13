import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:semnox_core/utils/index.dart';

class AppThemes {
  static const int light = 0;
  static const Map<int, String> names = {0: "Light", 1: "Dark"};
  static const int dark = 1;
}

final themeCollection = ThemeCollection(
  themes: {
    AppThemes.light: SemnoxTheme.kwickFunlightTheme(),
    AppThemes.dark: SemnoxTheme.kwickFundarkTheme(),
  },
  fallbackTheme: SemnoxTheme.kwickFunlightTheme(),
);
