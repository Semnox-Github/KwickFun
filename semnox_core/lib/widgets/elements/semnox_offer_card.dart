import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:semnox_core/utils/index.dart';
import 'package:semnox_core/widgets/elements/text.dart';

import 'semnox_offer_check_tick.dart';

class SemnoxOfferCard extends StatelessWidget {
  final String title;
  final String description;
  const SemnoxOfferCard({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: SemnoxConstantColor.black(context),
      borderType: BorderType.RRect,
      radius: Radius.circular(12.mapToIdealWidth(context)),
      padding: EdgeInsets.all(1),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: Container(
          padding: EdgeInsets.all(16.mapToIdealWidth(context)),
          color: SemnoxConstantColor.cardForeground(context),
          height: 200.mapToIdealWidth(context),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SemnoxText.h6(
                          text: title,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.mapToIdealHeight(context)),
                      child: SemnoxText.bodyReg1(
                        text: description,
                        style: TextStyle(
                          height: 2.75.mapToIdealHeight(context),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: SemnoxOfferCheckTick(
                    isSelected: false,
                    onChange: (bool value) {
                      log("Ticked Status $value");
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
