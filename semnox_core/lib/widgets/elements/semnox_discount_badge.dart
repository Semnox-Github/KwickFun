import  'package:flutter/material.dart';
import  'package:semnox_core/semnox_core.dart';

class SemnoxDiscountBadge extends StatelessWidget {
  final String title;
  const SemnoxDiscountBadge({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 30.mapToIdealHeight(context),
      width: 120.mapToIdealWidth(context),
      color: Colors.black,
      child: SemnoxText.bodyReg2(
        text: title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
