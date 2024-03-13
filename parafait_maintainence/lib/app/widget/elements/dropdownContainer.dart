import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';

class DropDownContainer extends StatelessWidget {
  final Widget dropDownChildWidget;
  final String textForDropDown;
  const DropDownContainer({
    Key? key,
    required this.textForDropDown,
    required this.dropDownChildWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SemnoxText(
              text: textForDropDown,
              style: const TextStyle(
                  fontSize: 20.0, color: Color.fromRGBO(102, 102, 102, 1)),
            ),
          ),
          dropDownChildWidget
        ],
      ),
    );
  }
}
