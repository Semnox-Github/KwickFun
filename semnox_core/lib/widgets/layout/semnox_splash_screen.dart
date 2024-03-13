import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';

// ignore: must_be_immutable
class SemnoxSplashScreen extends StatelessWidget {
  SemnoxSplashScreen({Key? key, this.message, this.logopath}) : super(key: key);
  String? message;
  String? logopath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: "SEMNOX_LOGO",
              child: Image.asset(
                "assets/images/kwickFun_strip_logo.png",
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          if (message != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SemnoxText.h3(
                  text: message!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
