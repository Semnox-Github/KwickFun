import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';

class SemnoxBoxField extends StatefulWidget {
  const SemnoxBoxField(
      {Key? key,
      required this.controller,
      this.color,
      required this.dialogTitle})
      : super(key: key);

  final Color? color;
  final TextEditingController controller;
  final String dialogTitle;

  @override
  _SemnoxBoxFieldState createState() => _SemnoxBoxFieldState();
}

class _SemnoxBoxFieldState extends State<SemnoxBoxField> {
  late Function() keyBoardListener;

  late ValueNotifier<String?> _notifier;

  @override
  void dispose() {
    log(" notifier disposed ${_notifier.hashCode}");
    _notifier.dispose();

    widget.controller.removeListener(keyBoardListener);
    super.dispose();
  }

  @override
  void initState() {
    _notifier = ValueNotifier<String>(widget.controller.text);
    log("New notifier added ${_notifier.hashCode}");
    keyBoardListener = () {
      _notifier.value = widget.controller.text;
    };
    widget.controller.addListener(keyBoardListener);
    super.initState();
  }

  Future<void> showKeyBoardPopup(BuildContext context) async {
    await SemnoxPopUp(
      //  maxWidth: MediaQuery.of(context).size.width,
      maxHeight: MediaQuery.of(context).size.height,
      title: SemnoxPopupTitle(
        title: widget.dialogTitle,
        enableClose: true,
      ),
      content: Container(
        color: SemnoxConstantColor.grey(context),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 46.mapToIdealWidth(context),
            vertical: 32.mapToIdealHeight(context),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 32.mapToIdealHeight(context)),
                child: Container(
                  alignment: Alignment.center,
                  height: 64.mapToIdealHeight(context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(4.mapToIdealWidth(context)),
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  child: ValueListenableBuilder<String?>(
                    valueListenable: _notifier,
                    builder:
                        (BuildContext context, String? value, Widget? child) {
                      return SemnoxText.h6(text: value ?? "");
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 520.mapToIdealWidth(context),
                height: 548.mapToIdealHeight(context),
                child: SemnoxKeyBoard(
                  textEditingController: widget.controller,
                ),
              ),
            ],
          ),
        ),
      ),
      action: Row(
        children: [
          Expanded(
            child: SemnoxDialogBottomButton(
              label: "UPDATE QUANTITY",
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showKeyBoardPopup(context),
      child: Container(
        alignment: Alignment.center,
        width: 72.mapToIdealHeight(context),
        height: 64.mapToIdealHeight(context),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(
            4.mapToIdealWidth(context),
          ),
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
        child: ValueListenableBuilder<String?>(
          valueListenable: _notifier,
          builder: (BuildContext context, String? value, Widget? child) {
            return SemnoxText.bodyMed1(
              text: int.tryParse(value ?? "0")?.toString() ?? "",
              textAlign: TextAlign.center,
            );
          },
        ),
      ),
    );
  }
}
