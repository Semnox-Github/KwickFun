import 'package:flutter/material.dart';
import 'package:focus_widget/focus_widget.dart';
import 'package:semnox_core/utils/index.dart';
import 'package:tap_canvas/tap_canvas.dart';

import 'overlay.dart';

class SemnoxMenuButton extends StatefulWidget {
  const SemnoxMenuButton({Key? key, required this.child, required this.menu})
      : super(key: key);

  final Widget child;
  final Widget menu;
  static void closeMenu() {
    _SemnoxMenuButtonState.activeOverlay?.hide();
  }

  @override
  _SemnoxMenuButtonState createState() => _SemnoxMenuButtonState();
}

class _SemnoxMenuButtonState extends State<SemnoxMenuButton>
    with SingleTickerProviderStateMixin {
  bool showOverlay = false;

  static _SemnoxMenuButtonState? activeOverlay;
  FocusNode focusNode = FocusNode();
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.easeInOut,
    );

    // focusNode.addListener(() {
    //   if (!focusNode.hasPrimaryFocus) {
    //     hide();
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.unfocus();
    focusNode.dispose();
    expandController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnchoredOverlay(
      showOverlay: showOverlay,
      overlayBuilder: (context, offset) {
        return TapCanvas(
          child: Stack(
            children: [
              CenterAbout(
                position: Offset(offset.dx, offset.dy),
                child: Material(
                  color: Colors.black54,
                  child: FadeTransition(
                    opacity: animation,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height,
                        ),
                        color: Colors.black45,
                        child: Center()),
                  ),
                ),
              ),
              CenterAbout(
                position: Offset(offset.dx, offset.dy),
                child: Material(
                  color: SemnoxConstantColor.scaffoldBackground(context),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.75,
                    ),
                    child: FocusWidget(
                      focusNode: focusNode,
                      onLostFocus: (_, focusNode) {
                        hide();

                        // showToast('Lost focus', textPadding: EdgeInsets.all(5));
                      },
                      showFocusArea: false,
                      child: Focus(
                        // autofocus: true,
                        focusNode: focusNode,
                        child: SizeTransition(
                            axisAlignment: 1.0,
                            sizeFactor: animation,
                            child: TapOutsideDetectorWidget(
                                onTappedOutside: () {
                                  hide();
                                },
                                child: widget.menu)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: InkWell(
          onTap: () async {
            // if (!showOverlay) {
            //   activeOverlay?.hide();
            // }
            if (!mounted) return;
            // setState(
            //   () {
            // showOverlay = !showOverlay;
            if (!showOverlay) {
              await show();
            } else {
              await hide();
            }
            //   },
            // );
          },
          child: widget.child),
    );
  }

  Future<void> hide() async {
    if (!mounted || !showOverlay) return;
    expandController.reverse(from: 1);
    await Future.delayed(Duration(milliseconds: 500));

    showOverlay = false;
    focusNode.unfocus();

    if (!mounted) return;
    setState(() {});
  }

  Future<void> show() async {
    ///
    /// Hide Active Overlay
    ///
    await activeOverlay?.hide();

    ///
    ///Make Current one as Active
    ///
    activeOverlay = this;
    showOverlay = true;

    ///
    ///Rebuild
    ///
    setState(() {});

    ///
    /// Start the animation
    ///
    expandController.forward(from: 0).whenComplete(() {
      focusNode.requestFocus();
    });
  }
}
