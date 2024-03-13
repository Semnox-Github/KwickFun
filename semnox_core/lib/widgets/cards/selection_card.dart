import  'package:animate_do/animate_do.dart';
import  'package:flutter/material.dart';
import  'package:semnox_core/semnox_core.dart';

///
///
///A Card for Product Selection
///
///[isActive] : to show Badge, By default false
///
class SelectionCard extends StatelessWidget {
  const SelectionCard({
    Key? key,
    this.isActive = false,
    this.badge,
    required this.child,
    this.borderRadius,
    this.badgeDiameter = 30.0,
  }) : super(key: key);
  final bool isActive;
  final Widget? badge;
  final Widget child;
  final BorderRadius? borderRadius;
  final double badgeDiameter;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedSwitcher(
          duration: SemnoxConstants.animationDuration,
          child: isActive
              ? SemnoxFlatCard(
                  child: child,
                  borderRadius: borderRadius,
                )
              : SemnoxElevatedCard(
                  child: child,
                  borderRadius: borderRadius,
                ),
        ),
        if (isActive)
          Positioned(
            top: -badgeDiameter / 2,
            right: -badgeDiameter / 2,
            child: FlipInY(
              child: Container(
                width: badgeDiameter,
                height: badgeDiameter,
                child: badge,
              ),
            ),
          )
      ],
    );
  }
}
