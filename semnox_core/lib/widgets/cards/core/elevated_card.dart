import 'package:flutter/material.dart';
import 'package:semnox_core/utils/index.dart';

class SemnoxElevatedCard extends StatelessWidget {
  const SemnoxElevatedCard({
    Key? key,
    required this.child,
    this.padding,
    this.color,
    this.borderRadius,
    this.disableShadow = false,
  })  : _boxShape = BoxShape.rectangle,
        super(key: key);

  const SemnoxElevatedCard.circular({
    Key? key,
    required this.child,
    this.padding,
    this.color,
    this.borderRadius,
    this.disableShadow = false,
  })  : _boxShape = BoxShape.circle,
        super(key: key);

  final BoxShape _boxShape;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Widget child;
  final Color? color;
  final bool disableShadow;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      clipBehavior: Clip.hardEdge,
      duration: SemnoxConstants.animationDuration,
      padding: padding ?? SemnoxPadding.mediumPadding(context),
      decoration: BoxDecoration(
          color: color ?? SemnoxConstantColor.cardForeground(context),
          borderRadius: _boxShape == BoxShape.circle
              ? null
              : borderRadius ?? SemnoxShape.roundCorner(context),
          shape: _boxShape,
          boxShadow: !disableShadow
              ? [
                  BoxShadow(
                      color: SemnoxConstantColor.shadowColor(context),
                      spreadRadius: 0,
                      blurRadius: 10)
                ]
              : null),
      child: child,
    );
  }
}
