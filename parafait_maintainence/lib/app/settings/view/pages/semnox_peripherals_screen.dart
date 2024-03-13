import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';

class SemnoxPeripheralsScreen extends StatelessWidget {
  const SemnoxPeripheralsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SemnoxScaffold(
      bodyPadding: SemnoxPadding.zero,
      appBar: SemnoxAppBar(
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: SemnoxIcons.arrowLeft.toIcon(
            size: 40.mapToIdealWidth(context),
          ),
        ),
        title: SemnoxText.h6(
          text: "Peripherals",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(children: [
        Row(
          children: [
            Padding(
              padding: SemnoxPadding.largePadding(context),
              child: SemnoxText.h6(text: "Connected Devices"),
            ),
          ],
        ),
        ListTileGroup(
          backgroundColor: SemnoxConstantColor.white(context),
          children: [
            SemnoxListTileWithIcon(
              // visualDensity: VisualDensity.compact,
              title: Text("Printer"),
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (_) => _PeripheralsDetailsScreen()));
              },
              trailing: SemnoxText(
                text: "Bluetooth Printer",
                style: const TextStyle(fontSize: 18),
              ),
            ),
            SemnoxListTileWithIcon(
              title: Text("Credit Card Reader"),
              trailing: SemnoxText(
                text: "Reader 1989",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class _PeripheralsDetailsScreen extends StatelessWidget {
  const _PeripheralsDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SemnoxScaffold(
      bodyPadding: SemnoxPadding.zero,
      appBar: SemnoxAppBar(
        leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: SemnoxIcons.arrowLeft
                .toIcon(size: 40.mapToIdealWidth(context))),
        title: SemnoxText.h6(
          text: "Peripherals",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: SemnoxPadding.largePadding(context),
                child: SemnoxText.h6(text: "Available Printers"),
              ),
            ],
          ),
          SemnoxListTileWithIcon(
            title: SemnoxText.bodyMed1(text: "Bluetooth Printer"),
          ),
          SemnoxListTileWithIcon(
            title: SemnoxText.bodyMed1(text: "Printer 2"),
          ),
          SemnoxListTileWithIcon(
            title: SemnoxText.bodyMed1(text: "Printer 3"),
          ),
        ],
      ),
    );
  }
}
