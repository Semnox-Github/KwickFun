import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:semnox_core/semnox_core.dart';

class SemnoxPopupTitle extends StatelessWidget {
  const SemnoxPopupTitle(
      {Key? key,
      this.enableClose = false,
      required this.title,
      this.alignment,
      this.textAlign = TextAlign.start})
      : super(key: key);
  final bool enableClose;
  final TextAlign textAlign;
  final String title;
  final MainAxisAlignment? alignment;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SemnoxPadding.mediumPadding(context),
      child: Row(
        mainAxisAlignment: alignment ??
            (enableClose
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center),
        children: [
          Flexible(
              child: SemnoxText.h5(
            text: title,
            textAlign: textAlign,
          )),
          if (enableClose)
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                AntDesign.close,
                size: 32.mapToIdealWidth(context),
              ),
            ),
        ],
      ),
    );
  }
}
