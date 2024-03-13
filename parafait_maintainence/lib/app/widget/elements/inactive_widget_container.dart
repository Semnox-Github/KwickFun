import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';

class InactiveWidgetContainer extends StatelessWidget {
  final Widget dropDownChildWidget;
  final String textForDropDown;
  final bool inactive;
  const InactiveWidgetContainer({
    Key? key,
    required this.textForDropDown,
    required this.dropDownChildWidget,
    required this.inactive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SemnoxText.bodyMed1(
              text: inactive == true
                  ? "$textForDropDown (Inactive)"
                  : textForDropDown,
              style: TextStyle(
                  color: inactive == true ? Colors.grey[700] : Colors.black),
            ),
          ),
          dropDownChildWidget
        ],
      ),
    );
  }
}
