// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:semnox_core/generator/assets.generator.dart';

@immutable
class SemnoxIcons {
  const SemnoxIcons._();
  static SvgGenImage get arrowLeft => Assets.icons.arrowLeft;
  static SvgGenImage get arrowRight => Assets.icons.arrowRight;
  static SvgGenImage get calendarBlank => Assets.icons.calendarBlank;
  static SvgGenImage get caretDown => Assets.icons.caretDown;
  static SvgGenImage get chair => Assets.icons.chair;
  static SvgGenImage get chairFilled => Assets.icons.chairFilled;
  static SvgGenImage get checkCircle => Assets.icons.checkCircle;
  static SvgGenImage get checked => Assets.icons.checked;
  static SvgGenImage get checkedCheckbox => Assets.icons.checkedCheckbox;
  static SvgGenImage get circleCheck => Assets.icons.circleCheck;
  static SvgGenImage get close => Assets.icons.close;
  static SvgGenImage get creditCard => Assets.icons.creditCard;
  static SvgGenImage get currencyDollar => Assets.icons.currencyDollar;
  static SvgGenImage get delete => Assets.icons.delete;
  static SvgGenImage get doubleCheck => Assets.icons.doubleCheck;
  static SvgGenImage get edit => Assets.icons.edit;
  static SvgGenImage get eye => Assets.icons.eye;
  static SvgGenImage get eyeSlash => Assets.icons.eyeSlash;
  static SvgGenImage get filledClose => Assets.icons.filledClose;
  static SvgGenImage get fluentAddCircleFilled =>
      Assets.icons.fluentAddCircleFilled;
  static SvgGenImage get food => Assets.icons.food;
  static SvgGenImage get fourSeatGrey => Assets.icons.fourSeatGrey;
  static SvgGenImage get gameController => Assets.icons.gameController;
  static SvgGenImage get icDiscount => Assets.icons.icDiscount;
  static SvgGenImage get ipAddress => Assets.icons.ipAddress;
  static SvgGenImage get key => Assets.icons.key;
  static SvgGenImage get macAddress => Assets.icons.macAddress;
  static SvgGenImage get macB => Assets.icons.macB;
  static SvgGenImage get minus => Assets.icons.minus;
  static SvgGenImage get plus => Assets.icons.plus;
  static SvgGenImage get printer => Assets.icons.printer;
  static SvgGenImage get radioButton => Assets.icons.radioButton;
  static SvgGenImage get search => Assets.icons.search;
  static SvgGenImage get server => Assets.icons.server;
  static SvgGenImage get serverB => Assets.icons.serverB;
  static SvgGenImage get signOut => Assets.icons.signOut;
  static SvgGenImage get squaresFour => Assets.icons.squaresFour;
  static SvgGenImage get table => Assets.icons.table;
  static SvgGenImage get tapcard => Assets.icons.tapcard;
  static SvgGenImage get ticket => Assets.icons.ticket;
  static SvgGenImage get trash => Assets.icons.trash;
  static SvgGenImage get twoSeatHorizontal => Assets.icons.twoSeatHorizontal;
  static SvgGenImage get twoSeatVertical => Assets.icons.twoSeatVertical;
  static SvgGenImage get uncheckCheckbox => Assets.icons.uncheckCheckbox;
  static SvgGenImage get uncheckedRadioButton =>
      Assets.icons.uncheckedRadioButton;
  static SvgGenImage get user => Assets.icons.user;
  static SvgGenImage get vector => Assets.icons.vector;
  static SvgGenImage get walk => Assets.icons.walk;
  static SvgGenImage get walkDark => Assets.icons.walkDark;
  static SvgGenImage get warningCircle => Assets.icons.warningCircle;
  static SvgGenImage get wifi => Assets.icons.wifi;

  static List<Widget> get allWidgets => [
        arrowLeft.toIcon(),
        arrowRight.toIcon(),
        calendarBlank.toIcon(),
        caretDown.toIcon(),
        chair.toIcon(),
        chairFilled.toIcon(),
        checkCircle.toIcon(),
        checked.toIcon(),
        checkedCheckbox.toIcon(),
        circleCheck.toIcon(),
        close.toIcon(),
        creditCard.toIcon(),
        currencyDollar.toIcon(),
        delete.toIcon(),
        doubleCheck.toIcon(),
        edit.toIcon(),
        eye.toIcon(),
        eyeSlash.toIcon(),
        filledClose.toIcon(),
        fluentAddCircleFilled.toIcon(),
        food.toIcon(),
        fourSeatGrey.toIcon(),
        gameController.toIcon(),
        icDiscount.toIcon(),
        ipAddress.toIcon(),
        key.toIcon(),
        macAddress.toIcon(),
        macB.toIcon(),
        minus.toIcon(),
        plus.toIcon(),
        printer.toIcon(),
        radioButton.toIcon(),
        search.toIcon(),
        server.toIcon(),
        serverB.toIcon(),
        signOut.toIcon(),
        squaresFour.toIcon(),
        table.toIcon(),
        tapcard.toIcon(),
        ticket.toIcon(),
        trash.toIcon(),
        twoSeatHorizontal.toIcon(),
        twoSeatVertical.toIcon(),
        uncheckCheckbox.toIcon(),
        uncheckedRadioButton.toIcon(),
        user.toIcon(),
        vector.toIcon(),
        walk.toIcon(),
        walkDark.toIcon(),
        warningCircle.toIcon(),
        wifi.toIcon(),
      ];
}

extension SvgToIcon on SvgGenImage {
  Widget toIcon({Color? color, double? size}) {
    return SvgIcon(
      svg: this,
      color: color,
      size: size,
    );
  }
}

class SvgIcon extends StatelessWidget {
  const SvgIcon({Key? key, required this.svg, this.color, this.size})
      : super(key: key);
  final SvgGenImage svg;
  final Color? color;
  final double? size;
  @override
  Widget build(BuildContext context) {
    IconThemeData theme = IconTheme.of(context);
    //   double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return SizedBox(
      width: (size ?? theme.size),
      height: (size ?? theme.size),
      child: Center(
        child: svg.svg(
            color: color ?? theme.color,
            width: (size ?? theme.size),
            height: (size ?? theme.size),
            package: "semnox_core"),
      ),
    );
  }
}

extension AssetGenImageToImageProvider on AssetGenImage {
  ImageProvider toImageProvider() {
    return AssetImage(
      path,
      package: "semnox_core",
    );
  }
}
