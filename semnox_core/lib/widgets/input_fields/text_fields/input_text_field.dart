import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_widget/focus_widget.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/text_style.dart';

class SemnoxTextFormField extends StatelessWidget {
  const SemnoxTextFormField({
    Key? key,
    required this.properties,
    this.prefix,
    this.suffix,
    this.enabled = true,
    this.position = LabelPosition.top,
    this.textAlign = TextAlign.start,
    this.border = true,
    this.fillColor,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
  }) : super(key: key);
  final SemnoxTextFieldProperties properties;
  final Widget? prefix;
  final Widget? suffix;
  final bool enabled;
  final Color? fillColor;
  final TextAlign textAlign;
  final LabelPosition position;
  final int maxLines;
  final bool? border;
  final int? maxLength;
  final LengthLimitingTextInputFormatter? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !enabled,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (properties.label != null && position == LabelPosition.top) ...{
              SemnoxText.subtitle(text: properties.label ?? ""),
              SizedBox(
                height: SemnoxPadding.mediumSpace(context),
              )
            },
            FocusWidget(
              focusNode: properties.focusNode,
              child: TextFormField(
                maxLength: maxLength,
                textAlign: textAlign,
                style: SemnoxTextStyle.subtitle(context),
                focusNode: properties.focusNode,
                controller: properties.textEditingController,
                obscureText: properties.isObscured,
                validator: properties.validate,
                keyboardType: properties.keyboardType,
                maxLines: maxLines,
                decoration: InputDecoration(
                  hintText: properties.hintText,
                  alignLabelWithHint: true,
                  filled: true,
                  fillColor: fillColor, //?? Colors.white,
                  isDense: true,
                  prefixIcon: prefix,
                  suffixIcon: suffix,
                  labelText: position == LabelPosition.inside
                      ? properties.label ?? ""
                      : null,
                  border: border == true
                      ? const OutlineInputBorder()
                      : const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              topLeft: Radius.circular(8)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                  // border: OutlineInputBorder(
                  //   borderSide: BorderSide(width: 5),
                  // ),
                  // enabledBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(
                  //     width: 1,
                  //     color: SemnoxConstantColor.shadowColor(context),
                  //   ),
                  // )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
