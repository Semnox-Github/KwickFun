import 'package:flutter/material.dart';
import 'package:focus_widget/focus_widget.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/text_style.dart';
import 'package:semnox_core/widgets/input_fields/date_field/properties.dart';

class SemnoxDateFormField extends StatelessWidget {
  const SemnoxDateFormField({
    Key? key,
    required this.properties,
    this.prefix,
    this.suffix,
    this.enabled = true,
    this.position = LabelPosition.top,
    this.textAlign = TextAlign.start,
    this.border = true,
    this.fillColor,
  }) : super(key: key);
  final DateFieldProperties properties;
  final Widget? prefix;
  final Widget? suffix;
  final bool enabled;
  final Color? fillColor;
  final TextAlign textAlign;
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
            FocusWidget(
              focusNode: properties.focusNode,
              child: TextFormField(
                textAlign: textAlign,
                style: SemnoxTextStyle.subtitle(context),
                focusNode: properties.focusNode,
                controller: properties.textEditingController,
                obscureText: properties.isObscured,
                // enabled: false,
                readOnly: true,
                validator: (val) {
                  return properties.validate(properties.value);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: fillColor ??
                      SemnoxConstantColor.cardBackgroundColor(context),
                  isDense: true,
                  prefixIcon: prefix,
                  suffixIcon: IconButton(
                      onPressed: () async {
                        final dateTime = await showDatePicker(
                            context: context,
                            initialDate: properties.value ?? DateTime.now(),
                            firstDate: properties.from,
                            lastDate: properties.till,
                            builder: (context, child) {
                              double currentWidth =
                                  MediaQuery.of(context).size.width;
                              // MediaQueryData mediaQueryData = MediaQuery.of(context);
                              return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(
                                    textScaleFactor:
                                        ((SemnoxSizing.IdealWidth * 0.45) /
                                            currentWidth),
                                  ),
                                  child: Container(child: child));
                            });
                        TimeOfDay? time;
                        if (properties.pickTime) {
                          var value = properties.value;
                          // ignore: use_build_context_synchronously
                          time = await showTimePicker(
                              context: context,
                              initialTime: value != null
                                  ? TimeOfDay.fromDateTime(value)
                                  : TimeOfDay.now(),
                              builder: (context, child) {
                                double currentWidth =
                                    MediaQuery.of(context).size.shortestSide;
                                return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                      textScaleFactor:
                                          ((SemnoxSizing.IdealWidth * 0.55) /
                                              currentWidth),
                                    ),
                                    child: Container(child: child));
                              });
                        }
                        if (dateTime != null) {
                          properties.onChange(dateTime.applied(time));
                        }
                      },
                      icon: const Icon(Icons.calendar_month_outlined)),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
