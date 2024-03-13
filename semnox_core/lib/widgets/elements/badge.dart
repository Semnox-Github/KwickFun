import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/text_style.dart';

///
/// A Badge Widget
///
/// Use [SemnoxBadge.count] constuctor if you wanted to animate on count change
///
// ignore: must_be_immutable
class SemnoxBadge extends StatelessWidget {
  SemnoxBadge(
      {Key? key,
      required this.child,
      this.diameter = 50,
      this.enableShadow = false,
      this.color})
      : super(key: key);
  SemnoxBadge.count(
      {Key? key,
      required int count,
      this.diameter = 50,
      TextStyle? textStyle,
      this.enableShadow = false,
      this.color}) {
    child = SemnoxText(
      text: "$count",
      style: textStyle,
      key: ValueKey(count),
    );
  }
  late Widget child;
  final double diameter;
  final bool enableShadow;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SemnoxElevatedCard.circular(
      padding: SemnoxPadding.zero,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          boxShadow: enableShadow
              ? [
                  BoxShadow(
                    offset: Offset(0, 5),
                    color: SemnoxConstantColor.shadowColor(context),
                    spreadRadius: 2,
                    blurRadius: 10,
                  ),
                ]
              : null,
          shape: BoxShape.circle,
        ),
        height: diameter,
        width: diameter,
        child: AnimatedDefaultTextStyle(
          child: IconTheme.merge(
              data: IconThemeData(
                color: SemnoxConstantColor.primaryColor(context),
              ),
              child: AnimatedSwitcher(
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                duration: SemnoxConstants.animationDuration,
                child: child,
              )),
          style: SemnoxTextStyle.label(context).copyWith(
            color: SemnoxConstantColor.primaryColor(context),
          ),
          duration: SemnoxConstants.animationDuration,
        ),
      ),
    );
  }
}
