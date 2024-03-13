import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:semnox_core/utils/text_style.dart';

enum _TextStyles {
  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  subtitle,
  button,
  bodyMed1,
  bodyMed2,
  bodyReg1,
  bodyReg2,
  caption,
  label,
  custom,
}

///
///A Wraper Widget For [Text] Widget
///
/// Usage:
///   if wanted text of [H5] style with Red color:
///```
///    SemnoxText.h5(
///     text:"My Text",
///     style: TextStyle(color: Colors.red)
///     )
/// ```
///
///
// ignore: must_be_immutable
class SemnoxText extends StatelessWidget {
  const SemnoxText({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
  })  : _selectedStyle = _TextStyles.custom,
        super(key: key);

  const SemnoxText.h1({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
  })  : _selectedStyle = _TextStyles.h1,
        super(key: key);

  const SemnoxText.h2({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
  })  : _selectedStyle = _TextStyles.h2,
        super(key: key);
  const SemnoxText.h3({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
  })  : _selectedStyle = _TextStyles.h3,
        super(key: key);

  const SemnoxText.h4({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
  })  : _selectedStyle = _TextStyles.h4,
        super(key: key);

  const SemnoxText.h5({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
  })  : _selectedStyle = _TextStyles.h5,
        super(key: key);
  const SemnoxText.h6({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
  })  : _selectedStyle = _TextStyles.h6,
        super(key: key);
  const SemnoxText.bodyMed1({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
  })  : _selectedStyle = _TextStyles.bodyMed1,
        super(key: key);
  const SemnoxText.bodyMed2({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
  })  : _selectedStyle = _TextStyles.bodyMed2,
        super(key: key);
  const SemnoxText.bodyReg1({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
  })  : _selectedStyle = _TextStyles.bodyReg1,
        super(key: key);
  const SemnoxText.bodyReg2({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
  })  : _selectedStyle = _TextStyles.bodyReg2,
        super(key: key);
  const SemnoxText.button({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
  })  : _selectedStyle = _TextStyles.button,
        super(key: key);
  const SemnoxText.caption({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
  })  : _selectedStyle = _TextStyles.caption,
        super(key: key);
  const SemnoxText.label({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
  })  : _selectedStyle = _TextStyles.label,
        super(key: key);
  const SemnoxText.subtitle({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
  })  : _selectedStyle = _TextStyles.subtitle,
        super(key: key);

  final _TextStyles _selectedStyle;
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    TextStyle defaultInheritedStyle = DefaultTextStyle.of(context).style;
    // TextStyle effectiveStyle = style  defaultInheritedStyle;
    TextStyle? defaultStyle =
        getDefaultTextStyle(context)?.copyWith(inherit: true, color: null);

    TextStyle effectiveStyle = defaultInheritedStyle;
    if (defaultStyle != null) {
      effectiveStyle = effectiveStyle.merge(defaultStyle);
    }
    if (style != null) effectiveStyle = effectiveStyle.merge(style);
    return Text(
      text,
      style: effectiveStyle,
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
    ); //.tr();
  }

  TextStyle? getDefaultTextStyle(BuildContext context) {
    switch (_selectedStyle) {
      case _TextStyles.h1:
        return SemnoxTextStyle.h1(context);

      case _TextStyles.h2:
        return SemnoxTextStyle.h2(context);

      case _TextStyles.h3:
        return SemnoxTextStyle.h3(context);

      case _TextStyles.h4:
        return SemnoxTextStyle.h4(context);

      case _TextStyles.h5:
        return SemnoxTextStyle.h5(context);

      case _TextStyles.h6:
        return SemnoxTextStyle.h6(context);

      case _TextStyles.subtitle:
        return SemnoxTextStyle.subtitle(context);

      case _TextStyles.button:
        return SemnoxTextStyle.buttonTitle(context);

      case _TextStyles.bodyMed1:
        return SemnoxTextStyle.bodyTextMedium1(context);

      case _TextStyles.bodyMed2:
        return SemnoxTextStyle.bodyTextMedium2(context);

      case _TextStyles.bodyReg1:
        return SemnoxTextStyle.bodyTextRegular1(context);

      case _TextStyles.bodyReg2:
        return SemnoxTextStyle.bodyTextRegular2(context);

      case _TextStyles.caption:
        return SemnoxTextStyle.caption(context);

      case _TextStyles.label:
        return SemnoxTextStyle.label(context);

      case _TextStyles.custom:
        return null;

      default:
        return SemnoxTextStyle.bodyTextRegular1(context);
    }
  }
}
