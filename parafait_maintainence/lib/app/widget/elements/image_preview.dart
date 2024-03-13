import 'dart:io';

import 'package:flutter/material.dart';
import 'package:semnox_core/widgets/elements/text.dart';

class ImagePreview extends StatelessWidget {
  // File imagePath;
  final File imagePath;
  const ImagePreview({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 134, 100, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(238, 134, 100, 1),
        title: const SemnoxText.subtitle(
          text: 'Image Preview',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.white),
        child: SizedBox(
          height: 200.0,
          width: 300.0,
          child: imagePath == null
              ? const Center(child: Text('Sorry nothing selected!!'))
              : Center(child: Image.file(imagePath)),
        ),
      ),
    );
  }
}
