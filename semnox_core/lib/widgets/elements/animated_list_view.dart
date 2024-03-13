import  'package:flutter/material.dart';
import  'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimatedListView extends StatelessWidget {
  const AnimatedListView({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
  }) : super(key: key);
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context,i){
          return AnimationConfiguration.staggeredList(
              position: i,
              duration: const Duration(milliseconds: 375),
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
