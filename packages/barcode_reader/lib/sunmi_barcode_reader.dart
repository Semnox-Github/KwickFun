import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sunmi_barcode_scanner/sunmi_barcode_scanner.dart';
class SunmiBarcodeReader {
  static final SunmiBarcodeReader instance = SunmiBarcodeReader._();
  final StreamController<String> _dataStreamController = StreamController<String>.broadcast();
  final List<ValueChanged<String>> _listners = [];

  SunmiBarcodeReader._() {
    _initScanner();
  }

  Future<void> _initScanner() async {
    try {
      final _sunmiBarcodeScanner = SunmiBarcodeScanner();
      _sunmiBarcodeScanner.onBarcodeScanned().listen((barcode) {
        _dataStreamController.add(barcode);
        for (var item in _listners) {
          item.call(barcode);
        }
      });
    } catch (error) {
      if (kDebugMode) {
        print("Error initializing Sunmi scanner: $error");
      }
      // Handle potential errors here
    }
  }

  Stream<String> get scanResult => _dataStreamController.stream;

  void registerCallback(ValueChanged<String> callback) {
    _listners.add(callback);
  }

  void unregisterCallback(ValueChanged<String> callback) {
    _listners.remove(callback);
  }
}
