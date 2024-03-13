import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';

class CardWidgetProperties {
  final String cardNo;
  final String name;

  CardWidgetProperties({
    required this.cardNo,
    required this.name,
  });
}

class CardWidget extends StatelessWidget {
  final CardWidgetProperties properties;
  const CardWidget({Key? key, required this.properties}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: getPair("Card No", properties.cardNo, context)),
        Expanded(child: getPair("Name", properties.name, context)),
      ],
    );
  }

  Widget getPair(String title, String data, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SemnoxElevatedCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SemnoxText.subtitle(
              text: data,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
            SizedBox(width: 20.mapToIdealWidth(context)),
            SemnoxText.bodyMed1(
              text: title,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
