import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:semnox_core/generator/assets.generator.dart';
import 'package:semnox_core/semnox_core.dart';

class SemnoxRideTapCard extends StatelessWidget {
  final String title;
  final bool disableShadow;
  final bool enableQrScan;
  final bool enableclosebutton;
  final bool refreshbutton;

  final Function(bool) callback;

  const SemnoxRideTapCard(
      {Key? key,
      required this.title,
      this.disableShadow = false,
      required this.enableQrScan,
      this.enableclosebutton = true,
      this.refreshbutton = false,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SemnoxFlatCard(
      color: SemnoxConstantColor.cardForeground(context),
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(16.mapToIdealWidth(context)),
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              disableShadow == true
                  ? Align(
                      alignment: Alignment.topRight,
                      child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.clear,
                            color: Colors.red,
                          )))
                  : Container(),
              refreshbutton == true
                  ? Align(
                      alignment: Alignment.topRight,
                      child: OutlinedButton(
                          onPressed: () => callback(true),
                          child: const Icon(
                            Icons.refresh,
                            color: Colors.red,
                          )))
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SemnoxText.h4(text: title),
                ),
              )
            ],
          ),
          // Container(
          //   alignment: FractionalOffset.topRight,
          //   child: Row(
          //     children: [
          //       const SizedBox(
          //         width: 10,
          //       ),
          //       SemnoxText.h5(text: title),
          //       Align(
          //         alignment: Alignment.topRight,
          //         child: IconButton(
          //           onPressed: () {
          //             Navigator.pop(context);
          //           },
          //           icon: const Icon(Icons.clear),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.all(32.mapToIdealWidth(context)),
            child: Container(
              padding: SemnoxPadding.largePadding(context),
              height: 200.mapToIdealWidth(context),
              width: 200.mapToIdealWidth(context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // borderRadius: BorderRadius.circular(
                //   324.mapToIdealWidth(context),
                // ),
                color: SemnoxConstantColor.lightPrimaryColor(context),
              ),
              alignment: Alignment.bottomRight,
              child: Image.asset(
                enableQrScan
                    ? Assets.gif.debitCardQrcodeAnimation.path
                    : Assets.gif.defaultDebitCardTapAnimation.path,
                fit: BoxFit.cover,
                package: "semnox_core",
              ),
            ),
          )
        ],
      ),
    );
  }
}
