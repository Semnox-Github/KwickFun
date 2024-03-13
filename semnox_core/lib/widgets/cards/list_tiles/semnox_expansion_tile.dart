import  'package:flutter/material.dart';
import  'package:semnox_core/widgets/cards/list_tiles/expansion_tile.dart';

typedef ExpansionBuilder = Widget Function(BuildContext context, bool isOpen);

class SemnoxReactiveExpansionTile extends StatefulWidget {
  const SemnoxReactiveExpansionTile({
    Key? key,
    required this.title,
    this.trailing,
    this.leadingBuilder,
    required this.body,
  }) : super(key: key);
  final ExpansionBuilder title;
  final ExpansionBuilder? trailing;
  final ExpansionBuilder? leadingBuilder;
  final Widget body;
  @override
  State<SemnoxReactiveExpansionTile> createState() => _SemnoxReactiveExpansionTileState();
}

class _SemnoxReactiveExpansionTileState extends State<SemnoxReactiveExpansionTile> {
  bool isExpanded = true;
  @override
  Widget build(BuildContext context) {
    return SemnoxExpansionTile(
      initiallyExpanded: isExpanded,
      
      tilePadding: EdgeInsets.zero,
      onExpansionChanged: (state) {
        setState(() {
          isExpanded = state;
        });
      },
      title: Row(
        children: [
          widget.leadingBuilder?.call(context, isExpanded) ??Container(),
          Flexible(child: widget.title.call(context, isExpanded)),
        ],
      ),

      trailing: widget.trailing?.call(context, isExpanded),
      children: [
        widget.body,
      ],
    );
  }
}
