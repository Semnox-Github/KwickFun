import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox_core/generator/assets.generator.dart';
import 'package:semnox_core/semnox_core.dart';
import '../view_model/splashscreen_view_model.dart';
import 'package:semnox_core/widgets/elements/version_tag.dart';

class ParafaitSplashScreen extends ConsumerWidget {
  const ParafaitSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(SplashScreenViewModel.provider(context));
    return StreamBuilder<String>(
        stream: viewModel.message.dataStream,
        builder: (context, snapshot) {
          return Stack(
            children: [
              SemnoxSplashScreen(
                logopath: Assets.images.kwickFunLogo.path,
                message: snapshot.data,
              ),
              const Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: AppVersionTag(
                      textScaleFactor: 0.8,
                      color: Colors.white,
                    ),
                  ))
            ],
          );
        });
  }
}
