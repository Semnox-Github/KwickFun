import  'package:flutter/material.dart';
import  'package:semnox_core/semnox_core.dart';

// ignore: must_be_immutable
class SemnoxFutureFlatButton extends StatelessWidget {
  final Widget child;
  final Widget loadingChild;
  final Future<void> Function()? futureCallBack;
  SemnoxFutureFlatButton(
      {Key? key,
      required this.child,
      required this.loadingChild,
      this.futureCallBack})
      : super(key: key) {
    _button = SemnoxFlatButton(
      child: ValueListenableBuilder<bool>(
        valueListenable: _loadingNotifier,
        builder: (BuildContext context, dynamic value, Widget? _) {
          return (value) ? loadingChild : child;
        },
      ),
      onPressed: () async {
        _loadingNotifier.value = true;
        try {
          await futureCallBack?.call();
        } catch (e) {}
        _loadingNotifier.value = false;
      },
    );
  }

  late SemnoxFlatButton _button;

  final ValueNotifier<bool> _loadingNotifier = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return _button;
  }
}
