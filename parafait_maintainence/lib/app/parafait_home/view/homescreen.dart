import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/widget/builderwidget/builderwidget.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:semnox_core/widgets/elements/version_tag.dart';

class HomeScreen extends ConsumerWidget {
  final String? message;
  const HomeScreen({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
        onWillPop: () {
          Utils().showExitDialog(context);
          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: SemnoxAppBar(
            automaticallyImplyLeading: false,
            title: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SemnoxText.h5(
                    text: Messages.maintainenceApp,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 20.mapToIdealHeight(context),
                  ),
                  const AppVersionTag(color: Colors.white)
                ],
              ),
            ),
            actions: [
              builderactionbar(context),
            ],
          ),
          body: SafeArea(
            child: builderhomepage(context, message),
          ),
        ));
  }
}
