import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/screen_utils/screenutils.dart';

class SemnoxResponsiveTable extends StatefulWidget {
  const SemnoxResponsiveTable({
    Key? key,
    required this.title,
    required this.rowBuilder,
    required this.itemCount,
    required this.mobileCardBuilder,
    required this.actionBuilder,
  }) : super(key: key);
  final List<SemnoxTableHeadder> title;

  final List<Widget> Function(BuildContext context, int i) rowBuilder;
  final Widget Function(BuildContext context, int i) mobileCardBuilder;
  final int itemCount;
  final List<Widget> Function(BuildContext context, int i) actionBuilder;

  @override
  _SemnoxResponsiveTableState createState() => _SemnoxResponsiveTableState();
}

class _SemnoxResponsiveTableState extends State<SemnoxResponsiveTable> {
  @override
  void initState() {
    super.initState();
    slidableController = SlidableController(
      onSlideAnimationChanged: (_) {},
      onSlideIsOpenChanged: (_) {},
    );
    for (var item in widget.title) {
      totalNoOfFlex += item.flex;
    }
  }

  int totalNoOfFlex = 0;

  double widthPerFlex = 0;
  late final SlidableController slidableController;
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    // ResponsiveWrapper.of(context).isSmallerThan(TABLET);

    return LayoutBuilder(builder: (context, constraints) {
      widthPerFlex = constraints.maxWidth / totalNoOfFlex;

      return Container(
        width: constraints.maxWidth,
        child: Column(
          children: [
            SemnoxScreenUtils.selectFromScreenSize(
              context: context,
              mobile: Container(),
              tablet: Padding(
                padding: SemnoxPadding.verticalLargePadding(context),
                child: Row(
                  children: List<Widget>.generate(
                    widget.title.length,
                    (i) => buildCell(
                      SemnoxText(
                        text: "${widget.title[i].label}",
                        style: TextStyle(
                            color: SemnoxConstantColor.primaryColor(context)),
                      ),
                      i,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.itemCount,
                  itemBuilder: (context, i) => itemBuilder(context, i)),
            ),
          ],
        ),
      );
    });
  }

  Widget itemBuilder(BuildContext context, int i) {
    return Padding(
      padding: SemnoxPadding.verticalMediumPadding(context),
      child: Slidable(
        key: ValueKey(i),
        actionPane: SlidableDrawerActionPane(),
        secondaryActions: widget.actionBuilder
            .call(context, i)
            .map((e) => Container(
                  color: SemnoxConstantColor.primaryColor(context),
                  child: Center(child: e),
                ))
            .toList(),
        child: SemnoxScreenUtils.selectFromScreenSize<IndexedWidgetBuilder>(
          context: context,
          mobile: buildMobilleCard,
          tablet: buildTableRow,
        ).call(context, i),
      ),
    );
  }

  Widget buildMobilleCard(BuildContext context, int i) {
    return Container(
        width: totalNoOfFlex * widthPerFlex,
        child: widget.mobileCardBuilder(context, i));
  }

  Widget buildCell(Widget child, int i) {
    return Container(
      width: widthPerFlex * widget.title[i].flex,
      child: Center(child: child),
    );
  }

  Widget buildTableRow(BuildContext context, int i) {
    List<Widget> children = widget.rowBuilder(context, i);
    return Container(
      constraints: BoxConstraints(minHeight: 50),
      child: Row(
        children: List<Widget>.generate(
            children.length, (index) => buildCell(children[index], index)),
      ),
    );
  }
}

class SemnoxTableHeadder {
  final String label;
  final int flex;

  SemnoxTableHeadder({required this.label, this.flex = 1});
}
