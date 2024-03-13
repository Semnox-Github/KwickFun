import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';

class SemnoxCounterController extends ValueNotifier<int> {
  SemnoxCounterController({int initialCount = 0, this.enabled = true})
      : super(initialCount);
  bool enabled;
  void disable() {
    enabled = true;
  }

  void enable() {
    enabled = false;
  }

  void decrement() => value--;
  void increment() => value++;
}

class SemnoxCounter extends StatelessWidget {
  final SemnoxCounterController? controller;
  final Function()? onIncrement;
  final Function()? onDecrement;
  final Function()? onTap;
  final int? initialCount;
  final bool enabled;
  SemnoxCounter({
    Key? key,
    this.controller,
    this.onIncrement,
    this.onDecrement,
    this.enabled = true,
    this.onTap,
    this.initialCount = 0,
  })  : _controller = controller ??
            SemnoxCounterController(initialCount: initialCount ?? 0),
        super(key: key);
  final SemnoxCounterController _controller;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Container(
      constraints: BoxConstraints(
        maxWidth: 225.mapToIdealWidth(context),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 5.mapToIdealWidth(context),
          color: primaryColor,
        ),
        borderRadius: BorderRadius.circular(
          4.mapToIdealWidth(context),
        ),
      ),
      height: 70.mapToIdealHeight(context),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                controller?.decrement();
                onDecrement?.call();
              },
              child: Container(
                height: 70.mapToIdealHeight(context),
                color: primaryColor,
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 32.mapToIdealWidth(context),
                ),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _controller,
              builder: (BuildContext context, int value, Widget? child) {
                return InkWell(
                  onTap: onTap,
                  child: Container(
                    color: SemnoxConstantColor.cardBackgroundColor(context),
                    alignment: Alignment.center,
                    child: SemnoxText.bodyMed1(
                      text: "$value",
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                controller?.increment();
                onIncrement?.call();
              },
              child: Container(
                height: 75.mapToIdealHeight(context),
                color: primaryColor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 32.mapToIdealWidth(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
