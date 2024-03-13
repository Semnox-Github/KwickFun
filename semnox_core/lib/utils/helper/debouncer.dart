
import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final Duration duration;
  Timer? _timer;

  Debouncer({required this.duration});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer?.cancel();
    }
    _timer = Timer(duration, action);
  }

  cancel() {
    if (null != _timer) {
      _timer?.cancel();
    }
  }
}
