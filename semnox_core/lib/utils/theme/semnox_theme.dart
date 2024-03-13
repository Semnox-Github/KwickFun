import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox_core/generator/fonts.generator.dart';

class SemnoxTheme {
  SemnoxTheme._();
  static const Color kwickfunprimaryColor = Color(0xFFf5cf10);
  static const Color maintprimaryColor = Color(0xFFEE8664);
  static const Color primaryColorDark = Color(0xFFEB7075);
  static const Color primaryColorLight = Color(0xFFEA9556);
  static const Color deepRed = Color(0xFFA44236);

  static ThemeData kwickFunlightTheme() {
    return ThemeData(
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepOrange,
            primaryColorDark: primaryColorDark,
            accentColor: Colors.orangeAccent,
            backgroundColor: Colors.white),
        primaryColor: kwickfunprimaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryColorLight,
        textTheme: generateKwickFunTextTheme(Colors.black),
        appBarTheme: generateAppBarTheme(kwickfunprimaryColor),
        shadowColor: Colors.black.withOpacity(0.08),
        inputDecorationTheme:
            const InputDecorationTheme(border: OutlineInputBorder()));
  }

  static ThemeData kwickFundarkTheme() {
    return ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepOrange,
          primaryColorDark: primaryColorDark,
          accentColor: Colors.orangeAccent,
          backgroundColor: const Color.fromARGB(255, 36, 8, 0),
          brightness: Brightness.dark,
        ),
        primaryColor: kwickfunprimaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryColorLight,
        textTheme: generateKwickFunTextTheme(Colors.white),
        appBarTheme: generateAppBarTheme(const Color.fromARGB(255, 36, 8, 0)),
        shadowColor: Colors.black.withOpacity(0.08),
        inputDecorationTheme:
            const InputDecorationTheme(border: OutlineInputBorder()));
  }

  static ThemeData maintlightTheme() {
    return ThemeData(
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepOrange,
            primaryColorDark: primaryColorDark,
            accentColor: Colors.orangeAccent,
            backgroundColor: Colors.white),
        primaryColor: maintprimaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryColorLight,
        textTheme: generateMaintenanceTextTheme(Colors.black),
        appBarTheme: generateAppBarTheme(maintprimaryColor),
        shadowColor: Colors.black.withOpacity(0.08),
        inputDecorationTheme:
            const InputDecorationTheme(border: OutlineInputBorder()));
  }

  static ThemeData maintdarkTheme() {
    return ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepOrange,
          primaryColorDark: primaryColorDark,
          accentColor: Colors.orangeAccent,
          backgroundColor: const Color.fromARGB(255, 36, 8, 0),
          brightness: Brightness.dark,
        ),
        primaryColor: maintprimaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryColorLight,
        textTheme: generateMaintenanceTextTheme(Colors.white),
        appBarTheme: generateAppBarTheme(const Color.fromARGB(255, 36, 8, 0)),
        shadowColor: Colors.black.withOpacity(0.08),
        inputDecorationTheme:
            const InputDecorationTheme(border: OutlineInputBorder()));
  }

  static AppBarTheme generateAppBarTheme(Color color) {
    return AppBarTheme(
      backgroundColor: color,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.white,
      ),
    );
  }

  static TextTheme generateKwickFunTextTheme(Color color) {
    double factor = 1.0;
    // Color color = Colors.black;
    return TextTheme(
      headline1: TextStyle(
        fontFamily: FontFamily.gothamRounded,
        package: "semnox_core",
        fontWeight: FontWeight.w700,
        fontSize: 56 * factor,
        height: 67.2 / 56.0,
        color: color,
      ),
      headline2: TextStyle(
        fontFamily: FontFamily.gothamRounded,
        package: "semnox_core",
        fontWeight: FontWeight.w700,
        fontSize: 48 * factor,
        height: 57.6 / 48,
        color: color,
      ),
      headline3: TextStyle(
        fontFamily: FontFamily.gothamRounded,
        package: "semnox_core",
        fontWeight: FontWeight.w700,
        fontSize: 40 * factor,
        height: 48 / 40,
        color: color,
      ),
      headline4: TextStyle(
        fontFamily: FontFamily.gothamRounded,
        package: "semnox_core",
        fontSize: 32 * factor,
        height: 38.4 / 32,
        color: color,
      ),
      headline5: TextStyle(
        fontFamily: FontFamily.gothamRounded,
        package: "semnox_core",
        fontWeight: FontWeight.w700,
        fontSize: 24 * factor,
        height: 40 / 24,
        color: color,
      ),
      headline6: TextStyle(
        fontFamily: FontFamily.gothamRounded,
        package: "semnox_core",
        fontWeight: FontWeight.w700,
        fontSize: 20 * factor,
        height: 24 / 20,
        color: color,
      ),
      subtitle1: TextStyle(
        fontFamily: FontFamily.gothamRounded,
        package: "semnox_core",
        fontWeight: FontWeight.w400,
        fontSize: 20 * factor,
        height: 24 / 20,
        color: color,
      ),
      subtitle2: TextStyle(
        fontFamily: FontFamily.gothamRounded,
        package: "semnox_core",
        fontWeight: FontWeight.w400,
        fontSize: 20 * factor,
        height: 24 / 20,
        color: color,
      ),
      bodyText1: GoogleFonts.rubik(
        fontWeight: FontWeight.w500,
        color: color,
      ),
      bodyText2: GoogleFonts.rubik(
        fontWeight: FontWeight.w400,
        color: color,
      ),
      caption: GoogleFonts.rubik(
        fontWeight: FontWeight.w400,
        fontSize: 14.0 * factor,
        color: color,
      ),
      button: GoogleFonts.rubik(
        fontWeight: FontWeight.w500,
        fontSize: 20 * factor,
        color: color,
      ),
      overline: GoogleFonts.rubik(
        fontSize: 12 * factor,
        fontWeight: FontWeight.w400,
        color: color,
      ),
    );
  }

  static TextTheme generateMaintenanceTextTheme(Color color) {
    double factor = 1.0;
    // Color color = Colors.black;
    return TextTheme(
      headline1: TextStyle(
        fontFamily: FontFamily.rubik,
        package: "semnox_core",
        fontWeight: FontWeight.w700,
        fontSize: 56 * factor,
        height: 67.2 / 56.0,
        color: color,
      ),
      headline2: TextStyle(
        fontFamily: FontFamily.rubik,
        package: "semnox_core",
        fontWeight: FontWeight.w700,
        fontSize: 48 * factor,
        height: 57.6 / 48,
        color: color,
      ),
      headline3: TextStyle(
        fontFamily: FontFamily.rubik,
        package: "semnox_core",
        fontWeight: FontWeight.w700,
        fontSize: 40 * factor,
        height: 48 / 40,
        color: color,
      ),
      headline4: TextStyle(
        fontFamily: FontFamily.rubik,
        package: "semnox_core",
        fontSize: 32 * factor,
        height: 38.4 / 32,
        color: color,
      ),
      headline5: TextStyle(
        fontFamily: FontFamily.rubik,
        package: "semnox_core",
        fontWeight: FontWeight.w700,
        fontSize: 24 * factor,
        height: 40 / 24,
        color: color,
      ),
      headline6: TextStyle(
        fontFamily: FontFamily.rubik,
        package: "semnox_core",
        fontWeight: FontWeight.w700,
        fontSize: 20 * factor,
        height: 24 / 20,
        color: color,
      ),
      subtitle1: TextStyle(
        fontFamily: FontFamily.rubik,
        package: "semnox_core",
        fontWeight: FontWeight.w400,
        fontSize: 20 * factor,
        height: 24 / 20,
        color: color,
      ),
      subtitle2: TextStyle(
        fontFamily: FontFamily.rubik,
        package: "semnox_core",
        fontWeight: FontWeight.w400,
        fontSize: 20 * factor,
        height: 24 / 20,
        color: color,
      ),
      bodyText1: GoogleFonts.rubik(
        fontWeight: FontWeight.w500,
        color: color,
      ),
      bodyText2: GoogleFonts.rubik(
        fontWeight: FontWeight.w400,
        color: color,
      ),
      caption: GoogleFonts.rubik(
        fontWeight: FontWeight.w400,
        fontSize: 14.0 * factor,
        color: color,
      ),
      button: GoogleFonts.rubik(
        fontWeight: FontWeight.w500,
        fontSize: 20 * factor,
        color: color,
      ),
      overline: GoogleFonts.rubik(
        fontSize: 12 * factor,
        fontWeight: FontWeight.w400,
        color: color,
      ),
    );
  }
}
