import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/widgets/cards/list_tiles/expansion_tile.dart';

class ConfigListTile extends ConsumerWidget {
  const ConfigListTile({Key? key, required this.properties}) : super(key: key);
  final ConfigListTileProperties properties;
  @override
  Widget build(BuildContext context, watch) {
    // final viewModel = watch(ConfigViewModel.provider);
    return SemnoxExpansionTile(
      title: SemnoxListTileWithIcon(
        title: SemnoxText(text: properties.label),
        trailing: SemnoxText(
          text: properties.value,
          // style: const TextStyle(fontSize: 18),
        ),
      ),
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: SemnoxPadding.horizontalMediumPadding(context),
                child: SemnoxTextFormField(
                    properties: properties.inputFieldProperties),
              ),
            ),
            Padding(
              padding: SemnoxPadding.horizontalMediumPadding(context),
              child: SemnoxFlatButton(
                child: const SemnoxText(text: "Save"),
                onPressed: () {
                  // viewModel.save();
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}

class ConfigListTileProperties {
  final SemnoxTextFieldProperties inputFieldProperties =
      SemnoxTextFieldProperties();
  final String label;
  final String value;
  ConfigListTileProperties({
    required this.value,
    required this.label,
  }) {
    inputFieldProperties.onChange(value);
  }
}
