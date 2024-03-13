import 'dart:async';
import 'package:flutter/services.dart';

class BarcodeReader {
  static BarcodeReader instance = BarcodeReader._();
  BarcodeReader._() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    if (call.method == "on_data") {
      _onData("${call.arguments}");
    }
  }

  void _onData(String data) {
    _dataStreamController.add(data);

    for (var item in _listners) {
      item.call(data);
    }
  }

  static const MethodChannel _channel = MethodChannel('barcode_reader');
  final StreamController<String> _dataStreamController =
      StreamController<String>.broadcast();

  Stream<String> get scanResult => _dataStreamController.stream;

  final List<ValueChanged<String>> _listners = [];

  void registerCallback(ValueChanged<String> callback) {
    _listners.add(callback);
  }

  void unregisterCallback(ValueChanged<String> callback) {
    _listners.remove(callback);
  }
}
