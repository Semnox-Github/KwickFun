import  'package:animate_do/animate_do.dart';
import  'package:flutter/material.dart';

class SemnoxGridView extends StatelessWidget {
  const SemnoxGridView({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.scrollPhysics = const ClampingScrollPhysics(),
    this.shrinkWrap = true,
    this.scrollController,
    this.gridDelegate,
  }) : super(key: key);
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final bool shrinkWrap;
  final ScrollPhysics scrollPhysics;
  final ScrollController? scrollController;
  final SliverGridDelegate? gridDelegate;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: gridDelegate ??
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      controller: scrollController ?? ScrollController(),
      itemCount: itemCount,
      itemBuilder: (context, i) {
        return SlideInWidget(
          child: itemBuilder(context, i),
        );
      },
    );
  }
}

class SlideInWidget extends StatelessWidget {
  const SlideInWidget({Key? key, required this.child, this.offset = 0})
      : super(key: key);
  final Widget child;
  final int offset;
  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      delay: Duration(milliseconds: 100 * offset),
      from: 20,
      child: SlideInUp(
        delay: Duration(milliseconds: 100 * offset),
        child: child,
        from: 20,
      ),
    );
    
  }
}
