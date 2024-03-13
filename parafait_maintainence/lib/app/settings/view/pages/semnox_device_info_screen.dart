import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';

class SemnoxDeviceInfoScreen extends StatelessWidget {
  const SemnoxDeviceInfoScreen({Key? key}) : super(key: key);

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
          text: "Device Information",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: ListTileGroup(
          backgroundColor: SemnoxConstantColor.white(context),
          children: [
            SemnoxListTileWithIcon(
              color: Colors.transparent,
              // visualDensity: VisualDensity.compact,
              leading: SemnoxIcons.wifi.toIcon(),
              title: Text("Network"),
              subtitle: Text("Arun's Network"),
              showtrailingIcon: false,
            ),
            // Divider(),
            SemnoxListTileWithIcon(
              leading: SemnoxIcons.ipAddress.toIcon(),
              title: Text("IP Address"),
              subtitle: Text("192.168.20.85"),
            ),
            // Divider(),
            SemnoxListTileWithIcon(
              leading: SemnoxIcons.macAddress.toIcon(),
              title: Text("MAC Address"),
              subtitle: Text("192.168.20.85"),
            ),
            // Divider(),
            SemnoxListTileWithIcon(
              leading: SemnoxIcons.server.toIcon(),
              title: Text("Server IP"),
              subtitle: Text("192.168.20.54:46C"),
            ),
            // Divider(),
          ],
        ),
      ),
    );
  }
}
