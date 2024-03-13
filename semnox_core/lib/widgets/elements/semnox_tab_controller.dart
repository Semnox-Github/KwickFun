import  'package:flutter/material.dart';
class SemnoxTabController extends StatefulWidget {
  SemnoxTabController({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<SemnoxTabController> createState() => _SemnoxTabControllerState();

  static ValueNotifier<int> lookUpController(BuildContext context) {
    if (context.findAncestorStateOfType<_SemnoxTabControllerState>() == null) {
      throw "Couldnt find findAncestorState ";
    }
    return context
        .findAncestorStateOfType<_SemnoxTabControllerState>()!
        .controller;
  }
}

class _SemnoxTabControllerState extends State<SemnoxTabController> {
  late final ValueNotifier<int> controller;
  static int _selectedTab = 0;
  @override
  void initState() {
    super.initState();
    controller = ValueNotifier<int>(_selectedTab);
    controller.addListener(() {
      _selectedTab = controller.value;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
