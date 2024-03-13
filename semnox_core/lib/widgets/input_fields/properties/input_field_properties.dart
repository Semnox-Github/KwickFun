import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

typedef ValidatorFunction<T> = String? Function(T? value);

abstract class SemnoxInputFieldProperties<T> {
  T? get value;
  void setInitialValue(T value);
  final List<ValidatorFunction<T>> validators;
  final String? label;
  final String? hintText;
  final bool isObscured;
  final BehaviorSubject<T> _behaviorSubject = BehaviorSubject<T>();
  ValueStream<T> get valueChangeStream => _behaviorSubject.stream;
  final FocusNode focusNode = FocusNode();
  void onChange(T value) {
    _behaviorSubject.add(value);
  }

  @mustCallSuper
  SemnoxInputFieldProperties({
    this.validators = const [],
    this.label,
    this.hintText,
    this.isObscured = false,
  });

  String? validate(T? value) {
    for (var validator in validators) {
      String? error = validator.call(value);
      if (error != null) return error;
    }
    return null;
  }
}

enum LabelPosition {
  top,
  inside,
}
