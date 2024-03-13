import  'package:flutter/material.dart';
import  'package:semnox_core/semnox_core.dart';

class SemnoxLabeledCheckBox extends StatefulWidget {
  const SemnoxLabeledCheckBox({
    Key? key,
    this.isSelected = false,
    required this.label,
    this.onSelected,
  }) : super(key: key);

  final bool isSelected;
  final String label;
  final Function(bool value)? onSelected;

  @override
  State<SemnoxLabeledCheckBox> createState() => _SemnoxLabeledCheckBoxState();
}

class _SemnoxLabeledCheckBoxState extends State<SemnoxLabeledCheckBox> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(
          () {
            _isSelected ? _isSelected = false : _isSelected = true;
          },
        );

        widget.onSelected?.call(_isSelected);
      },
      child: Row(
        children: [
          SizedBox(
            width: 38.mapToIdealWidth(context),
            height: 38.mapToIdealWidth(context),
            child: Transform.scale(
              scale: 0.8,
              child: Checkbox(
                fillColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
                splashRadius: 6,
                value: _isSelected,
                onChanged: (bool? val) {
                  _isSelected = val ?? false;
                  widget.onSelected?.call(_isSelected);
                  setState(() {});
                },
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 16.mapToIdealWidth(context)),
            child: SemnoxText.bodyReg1(
              text: widget.label,
            ),
          ),
        ],
      ),
    );
  }
}
