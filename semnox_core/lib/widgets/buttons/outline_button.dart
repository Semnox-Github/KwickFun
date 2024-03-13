import 'package:flutter/material.dart';
import 'package:semnox_core/utils/color.dart';
import 'package:semnox_core/utils/padding.dart';
import 'package:semnox_core/utils/text_style.dart';

// ignore: must_be_immutable
class SemnoxOutlineButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final MainAxisAlignment? alignment;
  SemnoxOutlineButton(
      {Key? key, this.onPressed, required this.child, this.alignment})
      : super(key: key);

  IconData? iconData;

  SemnoxOutlineButton.icon(
      {Key? key,
      this.onPressed,
      required this.child,
      required this.iconData,
      this.alignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          side: MaterialStateProperty.resolveWith<BorderSide>((states) {
        if (states.contains(MaterialState.disabled))
          return BorderSide(
            color: SemnoxConstantColor.disabledButtonColor(context),
          );
        return BorderSide(color: Theme.of(context).primaryColor);
      })),
      child: DefaultTextStyle(
        style: SemnoxTextStyle.buttonTitle(
          context,
        ).copyWith(
            color: onPressed != null
                ? Theme.of(context).primaryColor
                : SemnoxConstantColor.inactiveTextColor(context)),
        child: Padding(
          padding: SemnoxPadding.verticalMediumPadding(context),
          child: Row(
            mainAxisAlignment: alignment ?? MainAxisAlignment.center,
            children: [
              if (iconData != null) ...{
                Padding(
                  padding: SemnoxPadding.horizontalSpacingPadding(context),
                  child: Icon(iconData),
                ),
              },
              child,
            ],
          ),
        ),
      ),
    );
  }
}
