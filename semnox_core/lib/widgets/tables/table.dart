import 'package:flutter/material.dart';

import '../../semnox_core.dart';

class SemnoxTable extends StatefulWidget {
  SemnoxTable(
      {Key? key,
      required this.title,
      required this.rowBuilder,
      required this.itemCount,
      this.rowSeperatorBuilder,
      this.bodyBackgroundColor,
      this.physics})
      : super(key: key);
  final List<SemnoxTableHeadder> title;
  final List<Widget> Function(BuildContext context, int i) rowBuilder;
  final Widget Function(
    BuildContext context,
  )? rowSeperatorBuilder;
  final int itemCount;
  final Color? bodyBackgroundColor;
  final ScrollPhysics? physics;
  @override
  _SemnoxTableState createState() => _SemnoxTableState();
}

class _SemnoxTableState extends State<SemnoxTable> {
  @override
  void initState() {
    super.initState();
    for (var item in widget.title) {
      totalNoOfFlex += item.flex;
    }
  }

  int totalNoOfFlex = 0;

  double widthPerFlex = 0;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      widthPerFlex = constraints.maxWidth / totalNoOfFlex;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: SemnoxPadding.verticalLargePadding(context),
            child: Row(
              children: List<Widget>.generate(
                widget.title.length,
                (i) => buildCell(
                  SemnoxText.bodyMed1(
                    text: widget.title[i].label,
                    style: TextStyle(
                        color: SemnoxConstantColor.primaryColor(context)),
                  ),
                  i,
                ),
              ),
            ),
          ),
          Container(
              child: widget.itemCount == 0
                  ? SizedBox(
                      height: 550.mapToIdealHeight(context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.all(42.mapToIdealWidth(context)),
                            child: Image.asset(
                              "packages/semnox_core/assets/images/empty_cart.png",
                              width: 400.mapToIdealWidth(context),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.all(42.mapToIdealWidth(context)),
                            child: SemnoxText.h5(text: "No items added"),
                          )
                        ],
                      ),
                    )
                  : Container(
                      color: widget.bodyBackgroundColor ??
                          SemnoxConstantColor.white(context),
                      child: ListView.separated(
                          physics: widget.physics,
                          // physics: ClampingScrollPhysics(),
                          separatorBuilder: (context, i) =>
                              widget.rowSeperatorBuilder?.call(context) ??
                              Divider(),
                          shrinkWrap: true,
                          itemCount: widget.itemCount,
                          itemBuilder: (context, i) => itemBuilder(context, i)),
                    ))
        ],
      );
    });
  }

  Widget itemBuilder(BuildContext context, int i) {
    return Padding(
      padding: SemnoxPadding.verticalMediumPadding(context),
      child: buildTableRow.call(context, i),
    );
  }

  Widget buildCell(Widget child, int i) {
    return Container(
      width: widthPerFlex * widget.title[i].flex,
      child: Center(child: child),
    );
  }

  Widget buildTableRow(BuildContext context, int i) {
    List<Widget>? children = widget.rowBuilder(context, i);
    return Container(
      constraints: BoxConstraints(minHeight: 50),
      child: Row(
        children: List<Widget>.generate(
            children.length, (index) => buildCell(children[index], index)),
      ),
    );
  }
}
