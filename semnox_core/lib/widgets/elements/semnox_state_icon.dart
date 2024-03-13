import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';

enum SemnoxConnectionState {
  IS_CONNECTED,
  IS_NOT_CONNECTED,
}

class SemnoxStateIcon extends StatelessWidget {
  final Widget icon;
  final Function()? onPressed;
  final SemnoxConnectionState? connectionState;
  const SemnoxStateIcon(
      {Key? key, this.connectionState, required this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(4.mapToIdealWidth(context)),
              child: icon,
            ),
            connectionState == SemnoxConnectionState.IS_CONNECTED
                ? Positioned(
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      width: 16.mapToIdealWidth(context),
                      height: 16.mapToIdealWidth(context),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(
                          16.mapToIdealWidth(context),
                        ),
                      ),
                      child: Icon(
                        Icons.check,
                        size: 12.mapToIdealWidth(context),
                      ),
                    ),
                  )
                : connectionState == SemnoxConnectionState.IS_NOT_CONNECTED
                    ? Positioned(
                        right: 0,
                        child: Container(
                          alignment: Alignment.center,
                          width: 16.mapToIdealWidth(context),
                          height: 16.mapToIdealWidth(context),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(
                              16.mapToIdealWidth(context),
                            ),
                          ),
                          child: const SemnoxText(
                            text: "!",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      )
                    : const SizedBox()
          ],
        ),
      ),
    );
  }
}
