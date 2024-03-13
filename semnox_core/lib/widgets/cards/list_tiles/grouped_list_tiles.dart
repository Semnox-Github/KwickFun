import 'package:flutter/material.dart';
import 'package:semnox_core/utils/index.dart';

class ListTileGroup extends StatelessWidget {
  const ListTileGroup({
    Key? key,
    required this.children,
    this.devider,
    this.padding,
    this.backgroundColor,
  }) : super(key: key);
  final List<Widget> children;
  final Widget? devider;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? SemnoxConstantColor.cardForeground(context),
      child: ListView.separated(
        padding: padding,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, i) => children[i],
        separatorBuilder: (context, i) => devider ?? Divider(),
        itemCount: children.length,
      ),
    );
  }
}
