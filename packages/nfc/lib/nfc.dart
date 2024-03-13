library nfc;

import 'dart:async';

import 'package:nfc_manager/nfc_manager.dart';

class NFCManager {
  StreamController<NFCReadData> _streamController =
      StreamController<NFCReadData>.broadcast();

  ///
  ///Use [dataStream] to Read Data
  ///
  Stream<NFCReadData> get dataStream => _streamController.stream;
  NFCReadData? _value;

  ///
  ///Use to get Data
  ///
  NFCReadData? get value => _value;

  ///
  ///Start Listning for Card Tap.
  ///
  ///
  Stream<NFCReadData> startScan() {
    NfcManager.instance.startSession(
      onDiscovered: (tag) async {
        var nfcReadData = NFCReadData(handle: tag.handle, data: tag.data);
        _value = nfcReadData;
        _streamController.add(nfcReadData);
      },
    );

    return dataStream;
  }

  ///
  ///
  ///Stop Listning for Card Tap.
  ///
  void stop() {
    NfcManager.instance.stopSession();
  }
}

class NFCReadData {
  String handle;
  Map<String, dynamic> data;
  NFCReadData({
    required this.handle,
    required this.data,
  });
}
