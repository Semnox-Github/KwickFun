import  'package:flutter/material.dart';

class SemnoxPadding {
  SemnoxPadding._();

  static EdgeInsets get zero {
    return EdgeInsets.zero;
  }

  static double mediumSpace(BuildContext context) {
    return 10.0;
  }

  static double largeSpace(BuildContext context) {
    return 20.0;
  }

  static EdgeInsets verticalMediumPadding(BuildContext context) {
    return EdgeInsets.symmetric(vertical: mediumSpace(context));
  }

  static EdgeInsets verticalLargePadding(BuildContext context) {
    return EdgeInsets.symmetric(vertical: largeSpace(context));
  }

  static EdgeInsets horizontalMediumPadding(BuildContext context) {
    return EdgeInsets.symmetric(horizontal: mediumSpace(context));
  }

  static EdgeInsets horizontalLargePadding(BuildContext context) {
    return EdgeInsets.symmetric(horizontal: largeSpace(context));
  }

  static EdgeInsets mediumPadding(BuildContext context) {
    return EdgeInsets.all(mediumSpace(context));
  }

  static EdgeInsets largePadding(BuildContext context) {
    return EdgeInsets.all(largeSpace(context));
  }

  static EdgeInsets horizontalSpacingPadding(BuildContext context) {
    return EdgeInsets.symmetric(horizontal: mediumSpace(context));
  }

  static EdgeInsets verticalSpacingPadding(BuildContext context) {
    return EdgeInsets.symmetric(vertical: mediumSpace(context));
  }

  static EdgeInsets spacingPadding(BuildContext context) {
    return EdgeInsets.all(mediumSpace(context));
  }

  static EdgeInsets leftPaddingMedium(BuildContext context) {
    return EdgeInsets.only(left: mediumSpace(context));
  }

  static EdgeInsets rightPaddingMedium(BuildContext context) {
    return EdgeInsets.only(right: mediumSpace(context));
  }

  static EdgeInsets leftPaddingLarge(BuildContext context) {
    return EdgeInsets.only(left: largeSpace(context));
  }

  static EdgeInsets rightPaddingLarge(BuildContext context) {
    return EdgeInsets.only(right: largeSpace(context));
  }

  //left top bottom padding
  static EdgeInsets ltbMediumPadding(BuildContext context) {
    return EdgeInsets.only(
      left: mediumSpace(context),
      top: mediumSpace(context),
      bottom: mediumSpace(context),
    );
  }

  static EdgeInsets tbrMediumPadding(BuildContext context) {
    return EdgeInsets.only(
      right: mediumSpace(context),
      top: mediumSpace(context),
      bottom: mediumSpace(context),
    );
  }

  static EdgeInsets ltbLargePadding(BuildContext context) {
    return EdgeInsets.only(
      left: largeSpace(context),
      top: largeSpace(context),
      bottom: largeSpace(context),
    );
  }

  static topMediumPadding(BuildContext context) {
    return EdgeInsets.only(top: mediumSpace(context));
  }
}
