import 'package:semnox_core/widgets/input_fields/properties/index.dart';

class SemnoxRadioButtonProperties<T>
    extends SemnoxInputFieldProperties<SemnoxRadioItem<T>> {
  final List<SemnoxRadioItem<T>> options;
  late SemnoxRadioItem<T> value;

  SemnoxRadioButtonProperties({
    T? value,
    required this.options,
  }) {
    this.value = value != null
        ? options.firstWhere(
            (element) => element.value == value,
          )
        : options.first;
  }
  @override
  void setInitialValue(SemnoxRadioItem<T> value) {
    value = value;
  }

  // @override
  // T get value => _value;

  // @override
  // void onChange(SemnoxRadioItem<T>? value) {
  // super.onChange(value ?? this.value);
  // value = value;
  // }

  void onRadioSelect(T? item) {
    var selected = options.firstWhere(
      (element) => item == element.value,
    );
    super.onChange(selected);
    value = selected;
  }
}

class SemnoxRadioItem<T> {
  final T value;
  final String label;

  SemnoxRadioItem(this.value, this.label);
}
