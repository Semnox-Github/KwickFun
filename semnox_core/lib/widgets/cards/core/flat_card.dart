import 'package:flutter/material.dart';
import 'package:semnox_core/utils/index.dart';
import 'package:semnox_core/utils/text_style.dart';

class SemnoxFlatCard extends StatelessWidget {
  const SemnoxFlatCard({
    Key? key,
    required this.child,
    this.padding,
    this.color,
    this.borderRadius,
  })  : _boxShape = BoxShape.rectangle,
        super(key: key);

  const SemnoxFlatCard.circular({
    Key? key,
    required this.child,
    this.padding,
    this.color,
    this.borderRadius,
  })  : _boxShape = BoxShape.circle,
        super(key: key);

  final BoxShape _boxShape;
  final BorderRadiusGeometry? borderRadius;

  final EdgeInsetsGeometry? padding;
  final Widget child;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: SemnoxConstants.animationDuration,
      padding: padding ?? SemnoxPadding.mediumPadding(context),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).primaryColor,
        borderRadius: _boxShape == BoxShape.circle
            ? null
            : borderRadius ?? SemnoxShape.roundCorner(context),
        shape: _boxShape,
      ),
      clipBehavior: Clip.hardEdge,
      child: color != null
          ? child
          : DefaultTextStyle(
              style: SemnoxTextStyle.bodyTextRegular1(context).copyWith(
                color: SemnoxConstantColor.white(context),
              ),
              child: child,
            ),
    );
  }
}
