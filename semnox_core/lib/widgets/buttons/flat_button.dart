import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/text_style.dart';
import 'package:semnox_core/widgets/buttons/semnox_circle_loader.dart';

// ignore: must_be_immutable
class SemnoxFlatButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final bool isLoading;
  SemnoxFlatButton(
      {Key? key, this.onPressed, required this.child, this.isLoading = false})
      : super(key: key);

  Widget? icon;

  SemnoxFlatButton.icon(
      {Key? key,
      this.onPressed,
      required this.child,
      required this.icon,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          textStyle: MaterialStateProperty.resolveWith<TextStyle>((state) {
            if (state.contains(MaterialState.disabled))
              return TextStyle(
                  color: SemnoxConstantColor.inactiveTextColor(context));
            return TextStyle(
              color: SemnoxConstantColor.white(context),
            );
          }),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled))
                return SemnoxConstantColor.disabledButtonColor(context);
              return Theme.of(context).primaryColor;
            },
          ),
        ),
        child: DefaultTextStyle(
          style: SemnoxTextStyle.buttonTitle(context).copyWith(
              color: onPressed != null
                  ? SemnoxConstantColor.white(context)
                  : SemnoxConstantColor.inactiveTextColor(context)),
          child: IconTheme.merge(
            data: IconThemeData(
                color: onPressed != null
                    ? SemnoxConstantColor.white(context)
                    : SemnoxConstantColor.inactiveTextColor(context)),
            child: Padding(
              padding: SemnoxPadding.verticalMediumPadding(context),
              child: AnimatedContainer(
                // constraints: BoxConstraints(minHeight: 30),
                duration: SemnoxConstants.animationDuration,
                child: isLoading
                    ? SemnoxCircleLoader()
                    : (icon == null)
                        ? child
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (icon != null) ...{
                                Padding(
                                  padding:
                                      SemnoxPadding.horizontalSpacingPadding(
                                          context),
                                  child: icon,
                                ),
                              },
                              child,
                            ],
                          ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
