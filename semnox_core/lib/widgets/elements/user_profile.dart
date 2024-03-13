import 'package:flutter/material.dart';
import 'package:semnox_core/generator/assets.generator.dart';

import '../../semnox_core.dart';

class UserProfile extends StatelessWidget {
  final String label;
  final String? imageUrl;
  const UserProfile({
    Key? key,
    required this.label,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40.mapToIdealWidth(context),
          height: 40.mapToIdealWidth(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: (imageUrl?.isNotEmpty ?? false)
                  ? NetworkImage(imageUrl!)
                  : Assets.images.userPlaceholder.toImageProvider(),
            ),
          ),
        ),
        SizedBox(
          width: SemnoxPadding.mediumSpace(context),
        ),
        SemnoxText.h6(
          text: label,
          style: const TextStyle(color: Colors.white),
        ),
        SizedBox(
          width: 20.mapToIdealWidth(context),
        ),
        SemnoxIcons.caretDown.toIcon(
          size: 24.mapToIdealWidth(context),
          color: Colors.white,
        )
      ],
    );
  }
}
