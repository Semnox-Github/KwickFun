import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/text_style.dart';

class SemnoxTabView extends StatefulWidget {
  const SemnoxTabView(
      {Key? key,
      required this.title,
      required this.tabs,
      this.statusRow,
      this.onTabChange,
      this.index})
      : super(key: key);
  final List<Widget> title;
  final List<Widget> tabs;
  final Widget? statusRow;
  final int? index;

  // final ValueChanged<int>? onTabChange;
  final Function(int)? onTabChange;
  @override
  _SemnoxTabViewState createState() => _SemnoxTabViewState();
}

class _SemnoxTabViewState extends State<SemnoxTabView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.tabs.length,
      initialIndex: widget.index ?? 0,
      child: Container(
        color: SemnoxConstantColor.scaffoldBodyBackground(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 90.mapToIdealHeight(context),
              child: SemnoxElevatedCard(
                borderRadius: BorderRadius.zero,
                padding: SemnoxPadding.zero,
                child: TabBar(
                  onTap: (value) {
                    widget.onTabChange!(value);
                  },
                  tabs: widget.title,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: SemnoxConstantColor.primaryColor(context),
                  //      labelPadding: SemnoxPadding.verticalLargePadding(context),
                  // indicatorWeight: 3,
                  labelStyle: SemnoxTextStyle.bodyTextRegular1(context)
                      .copyWith(
                          color: SemnoxConstantColor.primaryColor(context)),
                  labelColor: SemnoxConstantColor.primaryColor(context),
                  unselectedLabelStyle:
                      SemnoxTextStyle.bodyTextRegular1(context),
                  unselectedLabelColor: SemnoxConstantColor.black(context),
                ),
              ),
            ),
            if (widget.statusRow != null) widget.statusRow!,
            Expanded(child: TabBarView(children: widget.tabs))
          ],
        ),
      ),
    );
  }
}
