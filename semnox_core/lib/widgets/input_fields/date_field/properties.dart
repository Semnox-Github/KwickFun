import 'package:flutter/cupertino.dart';
import 'package:semnox_core/utils/extension/date_time.dart';
import '../index.dart';

class DateFieldProperties extends SemnoxInputFieldProperties<DateTime> {
  DateFieldProperties(
      {this.initial,
      DateTime? from,
      DateTime? till,
      String? label,
      List<ValidatorFunction<DateTime>> validators = const [],
      this.pickTime = false})
      : super(label: label, validators: validators) {
    _start = from;
    _end = till;
    setInitialValue(initial ?? DateTime.now());
  }
  final bool pickTime;
  DateTime? initial;
  DateTime? dateTime;
  DateTime get from =>
      _start ??
      (initial ?? DateTime.now()).subtract(const Duration(days: 365 * 100));
  DateTime get till =>
      _end ?? (initial ?? DateTime.now()).add(const Duration(days: 365 * 100));
  DateTime? _start;
  DateTime? _end;
  final TextEditingController _textEditingController = TextEditingController();
  TextEditingController get textEditingController => _textEditingController;

  @override
  void setInitialValue(DateTime value) {
    // dateTime = value;
    onChange(value);
  }

  @override
  DateTime? get value => dateTime;

  @override
  void onChange(DateTime value) {
    dateTime = value;
    _textEditingController.text =
        pickTime ? value.formatWithTime() : value.formatToToday();
    super.onChange(value);
  }
}
