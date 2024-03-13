import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';

class SemnoxSetupScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? footerWidget;
  final String? applogo;
  final String? appname;
  final Alignment? logoallignment;
  const SemnoxSetupScaffold(
      {Key? key,
      this.body,
      this.footerWidget,
      this.applogo,
      this.appname,
      this.scaffoldKey,
      this.logoallignment})
      : super(key: key);
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      key: scaffoldKey,
      backgroundColor: SemnoxConstantColor.appbarBackground(context),
      body: Column(children: [
        Expanded(
          flex: 3,
          child: Hero(
            tag: "SEMNOX_LOGO",
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: logoallignment ?? Alignment.centerLeft,
                  child: Image.asset(
                    applogo.toString(),
                    height: 134.mapToIdealWidth(context),
                    width: 432.mapToIdealWidth(context),
                  ),
                ),
                SizedBox(
                  height: 10.mapToIdealHeight(context),
                ),
                SemnoxText.h4(
                    text: appname ?? "",
                    style: const TextStyle(color: Colors.white)),
                SizedBox(
                  height: 30.mapToIdealHeight(context),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: ClipPath(
            clipper: MyClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: SemnoxConstantColor.scaffoldBackground(
                    context), //Colors.white,
              ),
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 550.0.mapToIdealWidth(context),
                      ),
                      child: body),
                ),
              ),
            ),
          ),
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: footerWidget,
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MyClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.1320051);
    path.cubicTo(0, size.height * 0.1110993, 0, size.height * 0.1006457,
        size.width * 0.005388806, size.height * 0.09238359);
    path.cubicTo(
        size.width * 0.01013458,
        size.height * 0.08510729,
        size.width * 0.01774611,
        size.height * 0.07902817,
        size.width * 0.02725097,
        size.height * 0.07492280);
    path.cubicTo(
        size.width * 0.03804361,
        size.height * 0.07026120,
        size.width * 0.05231444,
        size.height * 0.06931662,
        size.width * 0.08085611,
        size.height * 0.06742725);
    path.lineTo(size.width * 0.9030778, size.height * 0.01300122);
    path.cubicTo(
        size.width * 0.9366958,
        size.height * 0.01077599,
        size.width * 0.9535042,
        size.height * 0.009663364,
        size.width * 0.9664819,
        size.height * 0.01375441);
    path.cubicTo(
        size.width * 0.9778833,
        size.height * 0.01734853,
        size.width * 0.9873056,
        size.height * 0.02362594,
        size.width * 0.9932417,
        size.height * 0.03158419);
    path.cubicTo(size.width, size.height * 0.04064306, size.width,
        size.height * 0.05295502, size.width, size.height * 0.07757893);
    path.lineTo(size.width, size.height * 0.9994934);
    path.lineTo(0, size.height * 0.9994934);
    path.lineTo(0, size.height * 0.1320051);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return oldClipper != this ? true : false;
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.03409091, size.height * 0.2133333);
    path_0.cubicTo(
        size.width * 0.03409091,
        size.height * 0.1249680,
        size.width * 0.06461705,
        size.height * 0.05333333,
        size.width * 0.1022727,
        size.height * 0.05333333);
    path_0.lineTo(size.width * 0.8977273, size.height * 0.05333333);
    path_0.cubicTo(
        size.width * 0.9353835,
        size.height * 0.05333333,
        size.width * 0.9659091,
        size.height * 0.1249680,
        size.width * 0.9659091,
        size.height * 0.2133333);
    path_0.lineTo(size.width * 0.9659091, size.height * 0.5730767);
    path_0.cubicTo(
        size.width * 0.9659091,
        size.height * 0.6561667,
        size.width * 0.9388068,
        size.height * 0.7254267,
        size.width * 0.9035256,
        size.height * 0.7325000);
    path_0.lineTo(size.width * 0.1080719, size.height * 0.8918467);
    path_0.cubicTo(
        size.width * 0.06827301,
        size.height * 0.8998200,
        size.width * 0.03409091,
        size.height * 0.8261600,
        size.width * 0.03409091,
        size.height * 0.7324267);
    path_0.lineTo(size.width * 0.03409091, size.height * 0.2133333);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
