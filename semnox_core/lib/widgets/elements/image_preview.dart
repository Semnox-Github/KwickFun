import 'package:flutter/material.dart';
import 'package:semnox_core/utils/index.dart';

class SemnoxImagePreviewProperties {
  final String? imageUrl;
  final double? aspectRatio;
  final BoxFit fit;

  SemnoxImagePreviewProperties({
    this.imageUrl,
    this.aspectRatio,
    this.fit = BoxFit.cover,
  });
}

class SemnoxImagePreview extends StatelessWidget {
  const SemnoxImagePreview({Key? key, required this.properties})
      : super(key: key);
  final SemnoxImagePreviewProperties properties;

  String? get imageUrl => properties.imageUrl;
  double? get aspectRatio => properties.aspectRatio;
  BoxFit get fit => properties.fit;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SemnoxConstantColor.black(context).withAlpha(50),
        borderRadius: BorderRadius.circular(
          18.mapToIdealWidth(context),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          18.mapToIdealWidth(context),
        ),
        child: imageUrl != null
            ? Image.network(
                imageUrl!,
                fit: fit,
              )
            : Center(
                child: Icon(
                Icons.broken_image_outlined,
                color: Colors.black.withAlpha(100),
              )),
      ),
    );
  }
}
