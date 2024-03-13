import  'package:flutter/material.dart';
import  'package:semnox_core/utils/color.dart';
import  'package:semnox_core/utils/constants.dart';

///
///Badge With Gradient Background
///
///Default [child] color is  [SemnoxConstantColor.white(context),]
///
///
///
class GradientBadge extends StatelessWidget {
  const GradientBadge({Key? key, this.diameter = 50.0, required this.child})
      : super(key: key);
  final double diameter;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: SemnoxConstantColor.greadientColor(context),
        ),
      ),
      child: AnimatedDefaultTextStyle(
        style: TextStyle(
          color: SemnoxConstantColor.white(context),
        ),
        duration: SemnoxConstants.animationDuration,
        child: IconTheme.merge(
          data: IconThemeData(
            color: SemnoxConstantColor.white(context),
          ),
          child: child,
        ),
      ),
    );
  }
}
