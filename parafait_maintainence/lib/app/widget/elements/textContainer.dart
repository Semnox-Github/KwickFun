import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  final Widget? child;
  const TextContainer({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      width: size.width * 0.9,
      child: child,
    );
  }
}
