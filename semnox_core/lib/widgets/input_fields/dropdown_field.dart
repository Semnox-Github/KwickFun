import 'package:flutter/material.dart';
import 'package:focus_widget/focus_widget.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/text_style.dart';

class SemnoxDropdownField<T> extends StatelessWidget {
  const SemnoxDropdownField({
    Key? key,
    required this.properties,
    this.prefix,
    this.suffix,
    this.enabled = true,
    this.position = LabelPosition.top,
    this.border = true,
    this.fillColor,
  }) : super(key: key);

  final SemnoxDropdownProperties<T> properties;
  final Widget? prefix;
  final Widget? suffix;
  final bool enabled;
  final Color? fillColor;
  final LabelPosition position;
  final bool? border;

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
            FocusWidget.builder(context, builder: (context, focusNode) {
              return StreamBuilder(
                  stream: properties.valueChangeStream,
                  builder: (context, snapshot) {
                    return DropdownButtonFormField(
                      style: SemnoxTextStyle.subtitle(context),

                      // style: const TextStyle(
                      //     fontSize: 23,
                      //     color: Colors.black,
                      //     fontFamily: FontFamily.rubik,
                      //     fontWeight: FontWeight.bold),
                      focusNode: focusNode,
                      isExpanded: true,
                      items: properties.items,
                      onChanged: (dynamic value) {
                        properties.onChange(value);
                      },
                      value: properties.value,
                      validator: properties.validate,
                      decoration: InputDecoration(
                        labelStyle: SemnoxTextStyle.subtitle(context),
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
                      ),
                    );
                  });
            })
          ],
        ),
      ),
    );
  }
}
