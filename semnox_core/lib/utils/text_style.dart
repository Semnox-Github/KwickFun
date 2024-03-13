import 'package:flutter/material.dart';

class SemnoxTextStyle {
  SemnoxTextStyle._();

  ///
  ///H1
  ///

  static TextStyle h1(BuildContext context) =>
      Theme.of(context).textTheme.headline1 ?? TextStyle();

  ///
  ///H2
  ///

  static TextStyle h2(BuildContext context) =>
      Theme.of(context).textTheme.headline2 ?? TextStyle();

  ///
  ///H3
  ///
  static TextStyle h3(BuildContext context) =>
      Theme.of(context).textTheme.headline3 ?? TextStyle();

  ///
  ///H4
  ///
  static TextStyle h4(BuildContext context) =>
      Theme.of(context).textTheme.headline4 ?? TextStyle();

  ///
  ///H5
  ///
  static TextStyle h5(BuildContext context) =>
      (Theme.of(context).textTheme.headline5 ?? TextStyle())
          .copyWith(fontWeight: FontWeight.w700);

  ///
  ///H5
  ///

  static TextStyle h6(BuildContext context) =>
      Theme.of(context).textTheme.headline6 ?? TextStyle();

  ///
  ///bodyTextMedium1
  ///

  static TextStyle bodyTextMedium1(BuildContext context) =>
      (Theme.of(context).textTheme.bodyText1 ?? TextStyle())
          .copyWith(inherit: true, fontSize: 25);

  ///
  ///bodyTextMedium2
  ///

  static TextStyle bodyTextMedium2(BuildContext context) =>
      (Theme.of(context).textTheme.bodyText1 ?? TextStyle()).copyWith(
        inherit: true,
        // fontSize: 16 ,
      );

  ///
  ///bodyTextMedium2
  ///
  static TextStyle bodyTextRegular1(BuildContext context) =>
      (Theme.of(context).textTheme.bodyText2 ?? TextStyle())
          .copyWith(inherit: true, fontSize: 18);
  //
  ///bodyTextRegular2
  ///
  static TextStyle bodyTextRegular2(BuildContext context) =>
      (Theme.of(context).textTheme.bodyText2 ?? TextStyle())
          .copyWith(inherit: true);
  //
  ///subtitle
  ///
  static TextStyle subtitle(BuildContext context) =>
      (Theme.of(context).textTheme.subtitle1 ?? TextStyle()).copyWith(
          inherit: true, fontSize: 30
          // color: enabled ? SemnoxConstantColor.primaryColor(context): SemnoxConstantColor.inactiveCardColor(context)
          );
  //
  ///buttonTitle
  ///
  static TextStyle buttonTitle(BuildContext context) =>
      (Theme.of(context).textTheme.button ?? TextStyle()).copyWith(
        inherit: true,
        // fontSize: 50
        // color: enabled ? SemnoxConstantColor.primaryColor(context): SemnoxConstantColor.inactiveCardColor(context)
      );
  //
  ///label
  ///
  static TextStyle label(BuildContext context) =>
      Theme.of(context).textTheme.overline ?? TextStyle();
  //
  ///caption
  ///
  static TextStyle caption(BuildContext context) =>
      Theme.of(context).textTheme.caption ?? TextStyle();
}
