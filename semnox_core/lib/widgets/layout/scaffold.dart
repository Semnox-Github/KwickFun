import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';

class SemnoxScaffold extends StatelessWidget {
  const SemnoxScaffold({
    Key? key,
    this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.bodyPadding,
    this.floatingActionButton,
    this.scaffoldKey,
  }) : super(key: key);
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final EdgeInsets? bodyPadding;
  final Widget? floatingActionButton;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: true,
      key: scaffoldKey,
      appBar: appBar,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: Container(
                color: SemnoxConstantColor.appbarBackground(context),
              )),
              Expanded(child: Container())
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: SemnoxPadding.mediumSpace(context)),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(SemnoxPadding.largeSpace(context)),
                topRight: Radius.circular(SemnoxPadding.largeSpace(context)),
              ),
              child: SemnoxElevatedCard(
                borderRadius: BorderRadius.zero,
                padding: bodyPadding ??
                    EdgeInsets.only(
                      top: SemnoxPadding.mediumSpace(context),
                      right: SemnoxPadding.mediumSpace(context),
                      left: SemnoxPadding.mediumSpace(context),
                    ),
                color: SemnoxConstantColor.scaffoldBackground(context),
                child: Container(
                  child: body,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
