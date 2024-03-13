import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/text_style.dart';

class SemnoxListTile extends StatelessWidget {
  const SemnoxListTile(
      {Key? key,
      required this.title,
      this.subtitle,
      this.leading,
      this.trailing,
      this.isSelected = false,
      this.padding,
      this.onPressed,
      this.color})
      : super(key: key);
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final bool isSelected;
  final VoidCallback? onPressed;
  final Color? color;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    var iconThemeData = IconThemeData(color: getOverridingColor(context));
    return InkWell(
      onTap: onPressed,
      child: SemnoxFlatCard(
        padding: padding,
        color: color ??
            (isSelected
                ? Theme.of(context).primaryColor
                : SemnoxConstantColor.cardForeground(context)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leading != null) ...{
              AnimatedDefaultTextStyle(
                  style: SemnoxTextStyle.bodyTextRegular1(context).merge(
                    _trailingAndLeadingTextStyle(
                        Theme.of(context), ListTileTheme.of(context), context),
                  ),
                  duration: SemnoxConstants.animationDuration,
                  child: IconTheme.merge(
                    data: iconThemeData,
                    child: Padding(
                        padding:
                            SemnoxPadding.horizontalSpacingPadding(context),
                        child: leading ?? Container()),
                  ))
            },
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedDefaultTextStyle(
                      duration: SemnoxConstants.animationDuration,
                      style: SemnoxTextStyle.bodyTextMedium1(context).copyWith(
                        color: getOverridingColor(context),
                      ),
                      child: title),
                  if (subtitle != null) ...{
                    SizedBox(
                      height: SemnoxPadding.mediumSpace(context),
                    ),
                    AnimatedDefaultTextStyle(
                      style: SemnoxTextStyle.bodyTextRegular1(context).copyWith(
                        color: getOverridingColor(context),
                      ),
                      duration: SemnoxConstants.animationDuration,
                      child: subtitle ?? Container(),
                    ),
                  }
                ],
              ),
            ),
            // Spacer(),
            if (trailing != null) ...{
              AnimatedDefaultTextStyle(
                style: SemnoxTextStyle.bodyTextRegular1(context).merge(
                    _trailingAndLeadingTextStyle(
                        Theme.of(context), ListTileTheme.of(context), context)),
                duration: SemnoxConstants.animationDuration,
                child: IconTheme.merge(
                  data: iconThemeData,
                  child: Padding(
                    padding: SemnoxPadding.horizontalSpacingPadding(context),
                    child: trailing ?? Container(),
                  ),
                ),
              )
            },
          ],
        ),
      ),
    );
  }

  Color? getOverridingColor(BuildContext context) {
    return isSelected ? SemnoxConstantColor.white(context) : null;
  }

  TextStyle _trailingAndLeadingTextStyle(
      ThemeData theme, ListTileThemeData? tileTheme, BuildContext context) {
    final TextStyle style = TextStyle(inherit: true);
    final Color? color = _textColor(theme, tileTheme,
        SemnoxConstantColor.inactiveTextColor(context), context);
    return style.copyWith(color: color);
  }

  Color? _textColor(ThemeData theme, ListTileThemeData? tileTheme,
      Color? defaultColor, context) {
    ListTile();
    if (isSelected && tileTheme?.selectedColor != null)
      return getOverridingColor(context);

    if (!isSelected) return SemnoxConstantColor.inactiveTextColor(context);

    if (isSelected) return getOverridingColor(context);
    return defaultColor;
  }
}
