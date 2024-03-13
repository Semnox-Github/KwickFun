import  'package:semnox_core/widgets/input_fields/properties/index.dart';

class SemnoxCheckBoxProperties extends SemnoxInputFieldProperties<bool?> {
final String label;
  bool? _value = false;

  SemnoxCheckBoxProperties({required this.label});
  @override
  void setInitialValue(bool? value) {
    _value = value;
  }


  @override
  bool? get value => _value;

  @override
  void onChange(bool? value) {
    
    super.onChange(value);
    _value = value;
  }

}