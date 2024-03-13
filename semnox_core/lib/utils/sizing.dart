import 'package:flutter/cupertino.dart';

class SemnoxSizing {
  SemnoxSizing._();

  static const IdealWidth = 720.0;
  static const IdealHeight = 1280.0;
}

extension SemnoxSizingExtension on num {
  ///
  ///Use this method to map ideal [value] to current `width`
  ///
  ///usage:
  ///
  ///```dart
  ///   130.mapToIdealWidth(context), //130 is width value from Reference design
  ///
  ///```
  ///
  ///
  ///
  double mapToIdealWidth(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.shortestSide;
    double scaleFactor = MediaQuery.of(context).textScaleFactor * 2;
    return map(this, 0, SemnoxSizing.IdealWidth, 0, currentWidth / scaleFactor);
  }

  ///
  ///Use this method to map ideal [value] to current `height`
  ///
  ///usage:
  ///
  ///```dart
  ///   130.mapToIdealHeight(context), //130 is height value from Reference design
  ///
  ///```
  ///
  ///
  ///
  double mapToIdealHeight(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.longestSide;
    double scaleFactor = MediaQuery.of(context).textScaleFactor * 2;
    // log("DEVICE SIZE: $scaleFactor");
    return map(
        this, 0, SemnoxSizing.IdealHeight, 0, currentHeight / scaleFactor);
  }
}

double map(num x, num inMin, num inMax, num outMin, num outMax) {
  return (x - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
}
