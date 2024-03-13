import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nfc/nfc.dart';
import 'package:sunmi_barcode_scanner/sunmi_barcode_scanner.dart';
import '../../../semnox_core.dart';
import 'package:barcode_reader/barcode_reader.dart';
import 'semnox_ride_tap_card.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:barcode_reader/sunmi_reader.dart';

part 'properties.dart';

class NfcCardReader extends StatelessWidget {
  const NfcCardReader(
      {Key? key, required this.cardproperties, required this.textproperties})
      : super(key: key);
  final SemnoxNFCReaderProperties cardproperties;
  final SemnoxTextFieldProperties textproperties;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SemnoxRideTapCard(
            title: "Tap Card"
                "${cardproperties.canReadBarcode ? " Or Scan Code" : ""}",
            disableShadow: true,
            enableQrScan: cardproperties.canReadBarcode,
            callback: ((bool val) {})),
        const SemnoxText.bodyMed2(text: "--OR--"),
        Padding(
          padding: EdgeInsets.only(
            top: 32.mapToIdealWidth(context),
            // left: 32.mapToIdealWidth(context),
            // right: 32.mapToIdealWidth(context),
          ),
          child: Column(
            children: [
              SemnoxTextFormField(properties: textproperties),
              SizedBox(
                height: 32.mapToIdealHeight(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
