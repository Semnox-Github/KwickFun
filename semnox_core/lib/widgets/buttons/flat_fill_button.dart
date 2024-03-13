import 'package:flutter/material.dart';
import 'package:semnox_core/utils/color.dart';
import 'package:semnox_core/utils/padding.dart';
import 'package:semnox_core/utils/text_style.dart';

// ignore: must_be_immutable
class SemnoxFlatFillButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final MainAxisAlignment? alignment;
  final Color? backgroundColor;
  SemnoxFlatFillButton(
      {Key? key,
      this.onPressed,
      required this.child,
      this.alignment,
      this.backgroundColor})
      : super(key: key);

  IconData? iconData;

  SemnoxFlatFillButton.icon(
      {Key? key,
      this.onPressed,
      required this.child,
      required this.iconData,
      this.alignment,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        side: MaterialStateProperty.resolveWith<BorderSide>((states) {
          if (states.contains(MaterialState.disabled)) {
            return BorderSide(
              color: SemnoxConstantColor.inactiveTextColor(context),
            );
          }
          return BorderSide(color: Theme.of(context).primaryColor);
        }),
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return SemnoxConstantColor.disabledButtonColor(context);
            }
            return backgroundColor == null
                ? Theme.of(context).primaryColor
                : backgroundColor!;
          },
        ),
      ),
      child: DefaultTextStyle(
        style: SemnoxTextStyle.buttonTitle(context).copyWith(
            color: onPressed != null
                ? SemnoxConstantColor.white(context)
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
