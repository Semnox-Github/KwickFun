import  'package:flutter/material.dart';

import  '../../semnox_core.dart';

class SemnoxToggleSwitch extends StatelessWidget {
  const SemnoxToggleSwitch(
      {Key? key, required this.properties, this.isActive = true})
      : super(key: key);
  final SemnoxToggleSwitchProperties properties;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: properties.valueChangeStream,
      builder: (context, snapshot) {
        return Switch(
            value: properties.value,
            activeColor: SemnoxConstantColor.primaryColor(context),
            onChanged: isActive
                ? properties.onChange
                : null);
      }
    );
  }
}
