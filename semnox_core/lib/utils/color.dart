import 'package:flutter/material.dart';

class SemnoxConstantColor {
  SemnoxConstantColor._();

  static Color disabledButtonColor(BuildContext context) => grey(context);
  static Color cardForeground(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceVariant; //white(context);
  static Color shadowColor(BuildContext context) =>
      Theme.of(context).shadowColor.withAlpha(35);

  static Color inactiveCardColor(BuildContext context) {
    return grey(context);
  }

  static Color? cardBackgroundColor(BuildContext context) {
    return Theme.of(context).cardTheme.color;
  }

  static Color primaryColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }

  static Color? appbarBackground(BuildContext context) {
    return Theme.of(context).appBarTheme.backgroundColor;
  }

  static Color scaffoldBackground(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }

  static Color inactiveTextColor(BuildContext context) {
    return Colors.grey.shade600;
  }

  static List<Color> greadientColor(BuildContext context) {
    return [
      Theme.of(context).primaryColorLight,
      Theme.of(context).primaryColorDark,
    ];
  }

  static Color primaryOpacityColor(BuildContext context) {
    return primaryColor(context).withAlpha(100);
  }

  static Color scaffoldBodyBackground(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }

  static Color summaryCardColorBg(BuildContext context) {
    return cardForeground(context);
  }

  static Color lightPrimaryColor(BuildContext context) {
    return Color(0xFFFCE7E0);
  }

  static Color alertStateColor(BuildContext context) {
    return Color(0xFFDF2E2E);
  }

  static Color alertbottom(BuildContext context) {
    return Color(0xFF222222);
  }

  static Color white(BuildContext context) =>
      Theme.of(context).colorScheme.background;
  static Color grey(BuildContext context) => Colors.grey.shade300;
  static Color black(BuildContext context) =>
      Theme.of(context).textTheme.bodyText1?.color ?? Colors.black;
}
