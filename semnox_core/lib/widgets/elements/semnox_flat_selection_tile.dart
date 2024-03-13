import  'package:flutter/material.dart';
import  'package:semnox_core/semnox_core.dart';


class SemnoxFlatSelectionTile extends StatelessWidget {
  final String label;
  final Function()? onPresssed;
  final BorderRadius? borderRadius;

  const SemnoxFlatSelectionTile(
      {Key? key, required this.label, this.onPresssed, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPresssed,
      child: SemnoxFlatCard(
        borderRadius: borderRadius ?? BorderRadius.zero,
        color: SemnoxConstantColor.primaryOpacityColor(context),
        child: Container(
          alignment: Alignment.center,
          width: 180.mapToIdealWidth(context),
          height: 145.mapToIdealHeight(context),
          child: SemnoxText.bodyReg1(
            text: label,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
