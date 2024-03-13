import  'package:semnox_core/widgets/input_fields/properties/index.dart';

class SemnoxToggleSwitchProperties extends SemnoxInputFieldProperties<bool> {

  bool _value = false;
  @override
  void setInitialValue(bool value) {
    _value = value;
  }


  @override
  bool get value => _value;

  @override
  void onChange(bool value) {
    
    super.onChange(value);
    _value = value;
  }

}