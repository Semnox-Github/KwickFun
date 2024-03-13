import 'package:flutter/material.dart';
import 'package:focus_widget/focus_widget.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/text_style.dart';

class SetupTextFormField<T> extends StatelessWidget {
  const SetupTextFormField(
      {Key? key,
      required this.textFieldPropeties,
      required this.label,
      this.border = true,
      this.trailing,
      this.dropdownproperties})
      : super(key: key);
  final SemnoxTextFieldProperties textFieldPropeties;
  final String label;
  final Widget? trailing;
  final bool? border;
  final SemnoxDropdownProperties<T>? dropdownproperties;
  @override
  Widget build(BuildContext context) {
    return SemnoxFlatCard(
      padding: SemnoxPadding.ltbMediumPadding(context),
      color: SemnoxConstantColor.cardForeground(context),
      child: Center(
        child: Theme(
          data: Theme.of(context).copyWith(
              inputDecorationTheme: const InputDecorationTheme(
                  border: InputBorder.none, isCollapsed: true)),
          child: SemnoxListTile(
              padding: EdgeInsets.zero,
              leading: SemnoxIcons.server.toIcon(),
              title: SemnoxText.subtitle(
                text: label,
              ),
              trailing: trailing,
              subtitle: SemnoxTextFormField(
                fillColor: Colors.transparent,
                properties: textFieldPropeties,
                border: border,
                prefix: FocusWidget.builder(
                  context,
                  builder: (context, focusNode) {
                    return StreamBuilder(
                      stream: dropdownproperties?.valueChangeStream,
                      builder: (context, snapshot) {
                        return dropdownproperties!.items.isNotEmpty
                            ? SizedBox(
                                width: 90,
                                child: DropdownButtonFormField(
                                    style: SemnoxTextStyle.subtitle(context),
                                    focusNode: focusNode,
                                    isExpanded: true,
                                    items: dropdownproperties?.items,
                                    onChanged: (dynamic value) {
                                      dropdownproperties?.onChange(value);
                                    },
                                    value: dropdownproperties?.value,
                                    validator: dropdownproperties?.validate),
                              )
                            : Container();
                      },
                    );
                  },

                  // decoration: InputDecoration.collapsed(hintText: ""),
                  // controller: textFieldPropeties.textEditingController ,
                ),
              )),
        ),
      ),
    );
  }
}
