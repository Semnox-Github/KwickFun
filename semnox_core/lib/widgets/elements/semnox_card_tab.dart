import  'package:flutter/material.dart';
import  'package:semnox_core/widgets/elements/semnox_tab_controller.dart';

class SemnoxCardTab extends StatelessWidget {
  final Widget Function(BuildContext, int, bool) tabBuilder;
  final int tabCount;
  const SemnoxCardTab({
    Key? key,
    required this.tabCount,
    required this.tabBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = SemnoxTabController.lookUpController(context);
    return ValueListenableBuilder<int>(
      valueListenable: ctrl,
      builder: (context, val, child) {
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: tabCount,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () => ctrl.value = index,
              child: tabBuilder(context, index, index == val),
            );
          },
        );
      },
    );
  }
}
