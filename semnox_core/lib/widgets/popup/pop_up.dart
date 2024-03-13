import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';

class SemnoxPopUp extends StatelessWidget {
  const SemnoxPopUp({
    Key? key,
    this.content,
    this.action,
    this.maxWidth,
    this.maxHeight,
    this.title,
    this.color,
  }) : super(key: key);
  final Widget? title;
  final Widget? content;
  final Widget? action;
  final double? maxWidth;
  final double? maxHeight;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double minimumWidth = size.width * 0.25;
    double minimumHeight = size.height * 0.25;
    double appliedmaxWidth = maxWidth ?? size.width * 0.75;
    double appliedmaxHeight = maxHeight ?? size.height * 0.75;
    return Container(
      constraints: BoxConstraints(
        maxWidth: appliedmaxWidth,
        maxHeight: appliedmaxHeight,
        minWidth: minimumWidth,
        minHeight: minimumHeight,
      ),
      child: Material(
        color: Colors.transparent,
        child: SemnoxElevatedCard(
            color: color ?? SemnoxConstantColor.cardBackgroundColor(context),
            padding: SemnoxPadding.zero,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (title != null)
                  Container(
                    child: title,
                  ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SemnoxText.h5(text: "Order Placed Successfully"),
                //   ],
                // ),
                if (content != null) ...{
                  Center(child: content),
                },
                if (action != null) action ?? Container()
              ],
            )),
      ),
    );
  }

  Future<T?> show<T>(BuildContext context) {
    return showDialog<T>(context: context, builder: (_) => Center(child: this));
  }
}
