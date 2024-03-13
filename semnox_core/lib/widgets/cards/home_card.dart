import  'package:flutter/material.dart';
import  'package:flutter_icons/flutter_icons.dart';
import  'package:semnox_core/semnox_core.dart';

class SemnoxHomeCard extends StatelessWidget {
  const SemnoxHomeCard(
      {Key? key, required this.title, required this.icon, required this.color})
      : super(key: key);
  final String title;
  final Widget icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SemnoxElevatedCard(
        padding: SemnoxPadding.mediumPadding(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: SizedBox(
                width: 70.mapToIdealHeight(context),
                height: 70.mapToIdealHeight(context),
                child: SemnoxFlatCard(
                  child: icon,
                  color: color.withOpacity(0.2),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SemnoxText.h6(
                  text: title,
                ),
                Icon(
                  AntDesign.arrowright,
                  size: 35.mapToIdealWidth(context),
                )
              ],
            )
          ],
        ));
  }
}
