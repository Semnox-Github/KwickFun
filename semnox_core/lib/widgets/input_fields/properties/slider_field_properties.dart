import  'dart:math';

import  'package:semnox_core/widgets/input_fields/properties/index.dart';

class SemnoxSliderProperties extends SemnoxInputFieldProperties<double> {
  double value;

  final double minimum;
  final double maximum;

  SemnoxSliderProperties({this.value = 0.0, this.minimum = 0.0, this.maximum = 100}){
      value = min(value, minimum);
  }
  @override
  void setInitialValue(double value) {
    value = value;
  }

  // @override
  // double? get value => _value;

  @override
  void onChange(double value) {
   this.value = value;
    super.onChange(value);
  }
}
