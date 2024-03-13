import  'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimatedGridView extends StatelessWidget {
  const AnimatedGridView({
    Key? key,
    required this.itemCount,
    required this.gridDelegate,
    required this.itemBuilder,
  }) : super(key: key);
  final int itemCount;
  final SliverGridDelegate gridDelegate;
  final Widget Function(BuildContext, int) itemBuilder;
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        itemCount: itemCount,
        gridDelegate: gridDelegate,
        itemBuilder: (context,i){
          return AnimationConfiguration.staggeredGrid(
              position: i,
              duration: const Duration(milliseconds: 375),
              columnCount: 2,
          child: SlideAnimation(
             horizontalOffset: 50.0,
             verticalOffset: 50.0,
            child: FadeInAnimation(
              child: Builder(builder: (context){
                return itemBuilder(context,i);
              }),
            ),
          ),
        );
        } ,
      ),
    );
  }
}
