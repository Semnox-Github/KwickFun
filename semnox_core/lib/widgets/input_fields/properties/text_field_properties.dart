import 'package:flutter/cupertino.dart';
import 'package:semnox_core/widgets/input_fields/properties/input_field_properties.dart';

class SemnoxTextFieldProperties extends SemnoxInputFieldProperties<String> {
  TextEditingController? textEditingController;
  final TextInputType inputType;
  final int maxLines;
  final String? hintText;
  SemnoxTextFieldProperties({
    String? text,
    String? label,
    this.hintText,
    this.inputType = TextInputType.text,
    this.maxLines = 1,
    List<ValidatorFunction<String>> validators = const [],
    bool isObscured = false,
  }) : super(
            label: label,
            validators: validators,
            isObscured: isObscured,
            hintText: hintText) {
    textEditingController = TextEditingController(text: text);
    textEditingController?.addListener(() {
      onChange(value);
    });
  }

  @override
  void setInitialValue(String value) {
    textEditingController?.text = value;
  }

  @override
  String get value => textEditingController!.text;

  TextInputType get keyboardType => inputType;
}
