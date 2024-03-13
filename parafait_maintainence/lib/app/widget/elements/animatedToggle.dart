import 'package:flutter/material.dart';
import 'package:semnox_core/utils/sizing.dart';
import 'package:semnox_core/widgets/elements/text.dart';

class AnimatedToggle extends StatefulWidget {
  final List<String> values;
  final ValueChanged onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;

  AnimatedToggle({
    required this.values,
    required this.onToggleCallback,
    this.backgroundColor = const Color(0xFFe7e7e8),
    this.buttonColor = const Color(0xFFFFFFFF),
  });
  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  bool initialPosition = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.mapToIdealWidth(context)),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                initialPosition = !initialPosition;
                var index = 0;
                if (!initialPosition) {
                  index = 1;
                }
                widget.onToggleCallback(index);
                setState(() {});
              },
              child: Container(
                decoration: ShapeDecoration(
                  color: widget.backgroundColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2.0, color: widget.buttonColor),
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    widget.values.length,
                    (index) => SemnoxText(
                      text: widget.values[index],
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.decelerate,
              alignment: initialPosition
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(top: 2),
                width: constraints.maxWidth * 0.55,
                decoration: ShapeDecoration(
                  color: widget.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.1),
                  ),
                ),
                child: SemnoxText(
                  text: initialPosition ? widget.values[0] : widget.values[1],
                  style: TextStyle(
                      // The fontSize below commented by Gaurav Duth
                      //   fontSize: MediaQuery.of(context).size.width * 0.045,
                      ),
                ),
                alignment: Alignment.center,
              ),
            ),
          ],
        );
      }),
    );
  }
}
