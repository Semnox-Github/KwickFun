import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';

class SemnoxSnackbar {
  static final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  static void error(BuildContext context, String message, {String? title}) {
    if (rootScaffoldMessengerKey.currentContext == null) return;

    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
          behavior: SnackBarBehavior.floating,
          // margin: EdgeInsets.zero,
          // padding: EdgeInsets.zero,
          backgroundColor: Colors.red, //SemnoxConstantColor.white(context),
          // elevation: 0,
          content: SemnoxText.button(
            text: message,
            style: const TextStyle(color: Colors.white),
          )

          // action: SnackBarAction(
          //     label: "OK",
          //     onPressed: () {
          //       rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
          //     })

          // ),
          //  _ToastWidget(
          //   title: title ?? "Error",
          //   message: "$message",
          //   color: Colors.red,
          //   icon: Icon(
          //     Icons.cancel_outlined,
          //     size: 40.mapToIdealHeight(rootScaffoldMessengerKey.currentContext!),
          //     color: SemnoxConstantColor.white(context),
          //   ),
          //   onClosePressed: () {
          //     rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
          //   },
          // ),
          ),
    );
// showToastWidget(
//       _ToastWidget(
//         title: title ?? "Error",
//         message: "$message",
//         color: Colors.red,
//         icon: Icon(
//           Icons.cancel_outlined,
//           size: 40.mapToIdealHeight(context),
//           color: Colors.white,
//         ),
//       ),
//       context: context,
//       animation: StyledToastAnimation.slideFromBottom,
//       curve: Curves.bounceOut,
//       reverseCurve: Curves.bounceIn,
//       reverseAnimation: StyledToastAnimation.slideFromBottom,
//     );
  }

  static void info(String message, BuildContext context, {String? title}) {
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        // margin: EdgeInsets.zero,
        // padding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        // elevation: 0,
        content: _ToastWidget(
          title: title ?? "Info",
          message: "$message",
          color: Colors.blue,
          icon: Icon(
            Icons.info_outline,
            size: 40.mapToIdealHeight(context),
            color: Colors.white,
          ),
          onClosePressed: () {
            rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
          },
        ),
      ),
    );
    // showToastWidget(
    // _ToastWidget(
    //   title: title ?? "Info",
    //   message: "$message",
    //   color: Colors.blue,
    //   icon: Icon(
    //     Icons.info_outline,
    //     size: 40.mapToIdealHeight(context),
    //     color: Colors.white,
    //   ),
    // ),
    //   context: context,
    //   animation: StyledToastAnimation.slideFromBottom,
    //   curve: Curves.bounceOut,
    //   reverseCurve: Curves.bounceIn,
    //   reverseAnimation: StyledToastAnimation.slideFromBottom,
    // );
  }

  static void success(String message, BuildContext context, {String? title}) {
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
          behavior: SnackBarBehavior.floating,
          // margin: EdgeInsets.zero,
          // padding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          // elevation: 0,
          content: _ToastWidget(
            title: title ?? "Success",
            message: message,
            color: Colors.green,
            icon: Icon(
              Icons.check_circle_outline,
              size: 40.mapToIdealHeight(context),
              color: Colors.white,
            ),
            onClosePressed: () {
              rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
            },
          )),
    );
    // showToastWidget(
    //   _ToastWidget(
    //     title: title ?? "Success",
    //     message: "$message",
    //     color: Colors.green,
    //     icon: Icon(
    //       Icons.check_circle_outline,
    //       size: 40.mapToIdealHeight(context),
    //       color: Colors.white,
    //     ),
    //   ),
    //   context: context,
    //   animation: StyledToastAnimation.slideFromBottom,
    //   curve: Curves.bounceOut,
    //   reverseCurve: Curves.bounceIn,
    //   reverseAnimation: StyledToastAnimation.slideFromBottom,
    // );
  }
}

class _ToastWidget extends StatelessWidget {
  const _ToastWidget({
    Key? key,
    required this.title,
    required this.message,
    required this.color,
    required this.icon,
    this.onClosePressed,
  }) : super(key: key);
  final String? title;
  final String? message;
  final Color color;
  final Widget icon;

  final VoidCallback? onClosePressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75.mapToIdealHeight(context),
      // color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: color,
            width: 10.mapToIdealWidth(context),
          ),
          Container(
            width: 10.mapToIdealWidth(context),
          ),
          Container(
            width: 50.mapToIdealHeight(context),
            height: 50.mapToIdealHeight(context),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: icon,
          ),
          Container(
            width: 10.mapToIdealWidth(context),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  SemnoxText.subtitle(
                    text: title ?? "",
                    style: const TextStyle(color: Colors.black),
                  ),
                if (message != null)
                  SemnoxText.bodyReg1(
                    text: "$message",
                    style: const TextStyle(color: Colors.black),
                  ),
              ],
            ),
          ),
          Container(
            width: 10.mapToIdealWidth(context),
          ),
          if (onClosePressed != null)
            IconButton(
                onPressed: onClosePressed,
                icon: Icon(
                  Icons.close,
                  color: color,
                ))
        ],
      ),
    );
  }
}
