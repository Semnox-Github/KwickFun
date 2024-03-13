import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';

class SemnoxListTileWithIcon extends StatelessWidget {
  const SemnoxListTileWithIcon({
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.padding,
    this.onPressed,
    this.color,
    this.showtrailingIcon,
  }) : super(key: key);
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final Color? color;
  final EdgeInsets? padding;
  final bool? showtrailingIcon;
  @override
  Widget build(BuildContext context) {
    return SemnoxListTile(
      title: title,
      color: SemnoxConstantColor.cardBackgroundColor(context),
      onPressed: onPressed,
      subtitle: subtitle,
      leading: leading,
      trailing: IconTheme.merge(
        data: IconThemeData(
            color: SemnoxConstantColor.inactiveTextColor(context)),
        child: Row(
          children: [
            if (trailing != null) Container(child: trailing),
            if (showtrailingIcon ?? onPressed != null)
              Padding(
                padding:
                    EdgeInsets.only(left: SemnoxPadding.mediumSpace(context)),
                child: RotatedBox(
                  quarterTurns: 3,
                  child: SemnoxIcons.caretDown.toIcon(
                    size: 20,
                  ),
                ),
              ),
          ],
        ),
      ),
      isSelected: false,
      padding: padding ??
          EdgeInsets.symmetric(
              vertical: SemnoxPadding.largeSpace(context),
              horizontal: SemnoxPadding.mediumSpace(context)),
    );
  }
}
