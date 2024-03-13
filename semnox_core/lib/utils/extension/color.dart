import 'package:flutter/material.dart';

extension ColorGenerator on String {
  Color? toColor() {
    List<String> rgbStrings = split(",");

    if (rgbStrings.length < 3) return _staticColors[toLowerCase()];

    List<int> rgbCodes = [];
    for (var item in rgbStrings) {
      final code = int.tryParse(item);
      if (code == null) return null;
      rgbCodes.add(code);
    }

    return Color.fromRGBO(rgbCodes[0], rgbCodes[1], rgbCodes[2],
        rgbCodes.length > 3 ? rgbCodes.last.toDouble() : 1.0);
  }
}

const _staticColors = {
  "white": Colors.white,
  "blue": Colors.blue,
  "green": Colors.green,
  "red": Colors.red,
  "yellow": Colors.yellow,
};
