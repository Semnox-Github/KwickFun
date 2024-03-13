import  'package:flutter/material.dart';
import  'package:semnox_core/semnox_core.dart';

class SemnoxTab extends StatelessWidget {
  const SemnoxTab({
    Key? key,
    required this.tabs,
  }) : super(key: key);
  final List<Icon> tabs;

  @override
  Widget build(BuildContext context) {
    final ctrl = SemnoxTabController.lookUpController(context);
    return ValueListenableBuilder<int>(
      valueListenable: ctrl,
      builder: (context, value, child) {
        return SemnoxElevatedCard(
          borderRadius: BorderRadius.circular(8.mapToIdealWidth(context)),
          padding: EdgeInsets.zero,
          child: SizedBox(
            width: 125.mapToIdealWidth(context),
            child: Row(
              children: [
                for (int i = 0; i < tabs.length; i++)
                  Expanded(
                    child: InkWell(
                      onTap: () => ctrl.value = i,
                      child: Container(
                        decoration: BoxDecoration(
                          color: value == i
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: value == 0
                                ? Radius.circular(8.mapToIdealWidth(context))
                                : Radius.zero,
                            topLeft: value == 0
                                ? Radius.circular(8.mapToIdealWidth(context))
                                : Radius.zero,
                            topRight: value == tabs.length - 1
                                ? Radius.circular(8.mapToIdealWidth(context))
                                : Radius.zero,
                            bottomRight: value == tabs.length - 1
                                ? Radius.circular(8.mapToIdealWidth(context))
                                : Radius.zero,
                          ),
                        ),
                        padding: EdgeInsets.all(12.mapToIdealWidth(context)),
                        child: Icon(
                          tabs[i].icon,
                          color: value == i ? Colors.white : Colors.black,
                          size: tabs[i].size,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
