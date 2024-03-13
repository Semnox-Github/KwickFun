import  'package:flutter/material.dart';

class SemnoxOfferCheckTick extends StatefulWidget {
  final Function(bool) onChange;
  final bool isSelected;
  const SemnoxOfferCheckTick({
    Key? key,
    required this.onChange,
    required this.isSelected,
  }) : super(key: key);

  @override
  _SemnoxOfferCheckTickState createState() => _SemnoxOfferCheckTickState();
}

class _SemnoxOfferCheckTickState extends State<SemnoxOfferCheckTick> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      fillColor: MaterialStateProperty.all<Color>(
        Theme.of(context).primaryColor,
      ),
      value: _isSelected,
      onChanged: (bool? value) {
        if (value ?? false) {
          _isSelected = true;
          widget.onChange.call(true);
        } else {
          _isSelected = false;
          widget.onChange.call(false);
        }
        setState(() {});
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          24,
        ),
      ),
    );
  }
}
