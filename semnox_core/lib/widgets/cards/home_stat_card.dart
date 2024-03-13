import  'package:flutter/material.dart';
import  'package:semnox_core/semnox_core.dart';

class HomeStatCard extends StatelessWidget {
  const HomeStatCard(
      {Key? key,
      required this.label,
      required this.icon,
      this.count,
      this.gradientBadgeRadius,
      this.onPressed})
      : super(key: key);
  final String label;
  final Widget icon;
  final double? gradientBadgeRadius;
  final int? count;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final double? radius = gradientBadgeRadius;
    late String stringCount;
    if (count != null) stringCount = count! < 10 ? "0$count" : count.toString();
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 208.mapToIdealWidth(context),
        height: 144.mapToIdealHeight(context),
        child: SemnoxFlatCard(
            borderRadius: BorderRadius.circular(8.mapToIdealWidth(context)),
            padding: EdgeInsets.all(16.mapToIdealWidth(context)),
            color: SemnoxConstantColor.primaryOpacityColor(context),
            child: Column(
              mainAxisAlignment: count != null
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              crossAxisAlignment: count == null
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GradientBadge(
                        diameter: (radius != null ? 2 * radius : 45)
                            .mapToIdealWidth(context),
                        child: icon),
                    if (count != null) ...{
                      SizedBox(
                        width: SemnoxPadding.mediumSpace(context),
                      ),
                      SemnoxText.h5(
                        text: "$stringCount",
                      ),
                      // Spacer()
                    }
                  ],
                ),
                SizedBox(height: 14.mapToIdealHeight(context)),
                SemnoxText.subtitle(
                  text: label,
                  // style: TextStyle(fontWeight: FontWeight.w900),
                  textAlign: count == null ? TextAlign.center : null,
                )
              ],
            )),
      ),
    );
  }
}
