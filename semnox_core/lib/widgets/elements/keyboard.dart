import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';

class SemnoxKeyBoard extends StatelessWidget {
  const SemnoxKeyBoard({Key? key, required this.textEditingController})
      : super(key: key);
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Material(
        color: Colors.transparent,
        child: SemnoxFlatCard(
          color: SemnoxConstantColor.primaryOpacityColor(context),
          padding: SemnoxPadding.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: buildRow(
                    [1, 2, 3]
                        .map(
                          (e) => buildNumber(e),
                        )
                        .toList(),
                    context),
              ),
              Container(
                height: 1,
                color: SemnoxConstantColor.grey(context),
              ),
              Flexible(
                child: buildRow(
                    [4, 5, 6]
                        .map(
                          (e) => buildNumber(e),
                        )
                        .toList(),
                    context),
              ),
              Container(
                height: 1,
                color: SemnoxConstantColor.grey(context),
              ),
              Flexible(
                child: buildRow(
                    [7, 8, 9]
                        .map(
                          (e) => buildNumber(e),
                        )
                        .toList(),
                    context),
              ),
              Container(
                height: 1,
                color: SemnoxConstantColor.grey(context),
              ),
              Flexible(
                  child: buildRow(
                      [Container(), buildNumber(0), buildBackSpace()], context))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNumber(int e) {
    return buildButton(
      SemnoxText.button(text: "$e"),
      () {
        textEditingController.text = textEditingController.text + "$e";
      },
    );
  }

  Widget buildBackSpace() {
    return buildButton(Icon(Icons.backspace), () {
      textEditingController.text =
          removeLastCharacter(textEditingController.text);
    });
  }

  String removeLastCharacter(String? str) {
    String result = "";
    if ((str != null) && (str.length > 0)) {
      result = str.substring(0, str.length - 1);
    }

    return result;
  }

  Widget buildRow(List<Widget> children, BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < children.length; i++) ...{
          Expanded(child: children[i]),
          if (i < children.length - 1)
            Container(
              width: 1,
              color: SemnoxConstantColor.grey(context),
            )
        }
      ],
    );
  }

  Widget buildButton(Widget child, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
