import 'package:flutter/material.dart';
import '../../semnox_core.dart';

class SemnoxCheckBox extends StatelessWidget {
  const SemnoxCheckBox(
      {Key? key, required this.properties, this.isActive = true})
      : super(key: key);
  final SemnoxCheckBoxProperties properties;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool?>(
        stream: properties.valueChangeStream,
        builder: (context, snapshot) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 48.0,
                height: 48.0,
                child: InkWell(
                  radius: 50,
                  onTap: () {
                    properties.onChange(!(properties.value ?? false));
                  },
                  child: Center(
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: SemnoxConstantColor.black(context))),
                      child: AnimatedSwitcher(
                        duration: SemnoxConstants.animationDuration,
                        child: properties.value == true
                            ? const Icon(
                                Icons.check,
                                size: 18,
                              )
                            : Container(),
                      ),
                    ),
                  ),
                ),
              ),
              // Checkbox(
              //     value: properties.value,
              //     activeColor: SemnoxConstantColor.black(context),

              //     onChanged: isActive
              //         ? properties.onChange
              //         : null),
              SizedBox(
                width: 10,
              ),
              SemnoxText.bodyReg1(text: properties.label)
            ],
          );
        });
  }
}
