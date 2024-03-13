import  'package:flutter/material.dart';
import  'package:semnox_core/utils/index.dart';
import  'package:semnox_core/widgets/buttons/future_flat_button.dart';

import  '../index.dart';
class SemnoxTextFormFieldWithButton extends StatelessWidget {
  const SemnoxTextFormFieldWithButton({
    Key? key,
    required this.properties,
    this.enabled,
    this.prefix,
    this.position = LabelPosition.top,
    this.textAlign = TextAlign.left,
    required this.buttonLabel,
    this.fillColor,
  }) : super(key: key);
  final bool? enabled;
  final Widget? prefix;
  final SemnoxTextFieldProperties properties;
  final Widget buttonLabel;
  final LabelPosition position;
  final TextAlign textAlign;
  final Color? fillColor;
  @override
  Widget build(BuildContext context) {
    return SemnoxTextFormField(
      position: position,
      fillColor: fillColor,
      textAlign: textAlign,
      prefix: prefix,
      suffix: Container(
        constraints: BoxConstraints(maxWidth: 120),
        padding: EdgeInsets.only(right: SemnoxPadding.mediumSpace(context)),
        child: SemnoxFutureFlatButton(
          child: buttonLabel,
          loadingChild: Center(
            child: CircularProgressIndicator(),
          ),
          futureCallBack: () async {
            await Future.delayed(Duration(seconds: 0));
          },
        ),
      ),
      properties: properties,
    );
  }
}
