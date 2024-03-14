part of 'nfc_reader.dart';

class SemnoxNFCReaderProperties extends SemnoxTextFieldProperties {
  SemnoxNFCReaderProperties({
    ///
    ///Defaults to true,
    ///
    bool autoStartListening = true,
    String? initialValue,
    bool isObscured = false,
    String? label,
    String? hintText,
    TextInputType inputType = TextInputType.text,
    int maxLines = 1,
    List<ValidatorFunction> validators = const [],
    this.canReadBarcode = true,
    // bool enableTyping = true,
  }) : super(
          label: label,
          inputType: inputType,
          isObscured: isObscured,
          hintText: hintText,
          maxLines: maxLines,
          validators: validators,
        ) {
    if (autoStartListening) startListening();
  }
  StreamSubscription<NFCReadData>? _subscription;
  final bool canReadBarcode;

Future<bool> isSunmiDevice() async {
  final deviceInfo = await DeviceInfoPlugin().androidInfo;
  //print('deviceCheck $deviceInfo');
  return deviceInfo.brand == "SUNMI"; // Adjust the criteria as needed
  }
  ///
  /// Starts to listning the NFC Card Tap.
  ///
  Future<void> startListening() async {
    print('Starting to listen...');
    _subscription = _nfcManager.dataStream.listen((event) {
      textEditingController?.text = extractIdFromMessage(event.data) ?? "";
    });

    _nfcManager.startScan();
    if (canReadBarcode)
    {
      if(await isSunmiDevice())
      {
        SunmiBarcodeReader.instance.registerCallback(_readBarcode);
      }
      else
      {
      BarcodeReader.instance.registerCallback(_readBarcode);
      }
    }
  }

  void _readBarcode(String data) {
    textEditingController?.text = data;
  }

  ///
  /// Stops to listning the NFC Card Tap.
  ///
  void stop() {
    DateTime now = DateTime.now();
    print('NFC Stop Listining in properties: $now');
    print('Stopping...');
    _subscription?.cancel();
    _nfcManager.stop();
    BarcodeReader.instance.unregisterCallback(_readBarcode);
  }

  final NFCManager _nfcManager = NFCManager();

  String? extractIdFromMessage(Map<String, dynamic> message) {
    final nfcadata = message["nfca"];
    if (nfcadata != null) {
      List identifierList = nfcadata["identifier"];
      String identifier = "";

      for (var item in identifierList) {
        identifier +=
            int.tryParse("$item")?.toRadixString(16).padLeft(2, "0") ?? "";
      }
      return identifier.toUpperCase();
    }
    return null;
  }
}
