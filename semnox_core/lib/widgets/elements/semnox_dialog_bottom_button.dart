import  'package:flutter/material.dart';
import  'package:semnox_core/semnox_core.dart';

class SemnoxDialogBottomButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const SemnoxDialogBottomButton({Key? key, required this.label, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: SizedBox(
              height: 64.mapToIdealHeight(context),
              child: Center(
                child: SemnoxText.bodyMed1(
                  text: label,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
