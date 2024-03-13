import 'package:flutter/material.dart';
import 'package:semnox_core/widgets/input_fields/properties/input_field_properties.dart';

class SemnoxDropdownProperties<T> extends SemnoxInputFieldProperties<T> {
  T? _value;

  final TextInputType inputType;
  final int maxLines;
  final List<DropdownMenuItem<T>> items;
  final bool enabled;
  SemnoxDropdownProperties({
    required this.items,
    String? label,
    this.inputType = TextInputType.text,
    this.maxLines = 1,
    List<ValidatorFunction> validators = const [],
    bool isObscured = false,
    this.enabled = true,
  }) : super(label: label, validators: validators, isObscured: isObscured);

  @override
  void setInitialValue(T value) {
    _value = value;
  }

  @override
  void onChange(T value) {
    super.onChange(value);
    _value = value;
  }

  @override
  T? get value => _value;

  TextInputType get keyboardType => inputType;
}
