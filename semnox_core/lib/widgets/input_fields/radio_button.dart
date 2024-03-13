import 'package:flutter/material.dart';

import '../../semnox_core.dart';

class SemnoxRadioButton<T> extends StatelessWidget {
  const SemnoxRadioButton(
      {Key? key, required this.properties, this.isActive = true})
      : super(key: key);
  final SemnoxRadioButtonProperties<T> properties;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SemnoxRadioItem<T>>(
      stream: properties.valueChangeStream,
      builder: (context, snapshot) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...properties.options.map((e) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<T>(
                        value: e.value,
                        activeColor: SemnoxConstantColor.black(context),
                        groupValue: properties.value.value,
                        onChanged: properties.onRadioSelect),
                    SizedBox(
                      width: 10,
                    ),
                    SemnoxText.bodyReg1(text: e.label)
                  ],
                )),
          ],
        );
      },
    );
  }
}
