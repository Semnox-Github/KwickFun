import  'package:flutter/material.dart';
import  'package:flutter_riverpod/flutter_riverpod.dart';
import  'package:semnox_core/widgets/elements/index.dart';

class SemnoxTabEye extends ConsumerWidget {
  final List<Widget> children;
  const SemnoxTabEye({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ValueListenableBuilder<int>(
      valueListenable: SemnoxTabController.lookUpController(context),
      builder: (context, value, child) {
        if (value >= children.length)
          return Center(
            child: Text("No Tab specified for the index $value"),
          );
        return children[value];
      },
    );
  }
}
