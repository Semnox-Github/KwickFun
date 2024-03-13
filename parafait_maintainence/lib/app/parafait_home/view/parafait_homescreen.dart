import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/parafait_home/view/homescreen.dart';
import 'package:parafait_maintainence/app/parafait_home/view_model/homescreen_view_model.dart';

class ParafaitHomeScreen extends ConsumerWidget {
  const ParafaitHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(HomeScreenViewModel.provider);
    return StreamBuilder<String>(
        stream: viewModel.message.dataStream,
        builder: (context, snapshot) {
          return HomeScreen(
            message: snapshot.data,
          );
        });
  }
}
