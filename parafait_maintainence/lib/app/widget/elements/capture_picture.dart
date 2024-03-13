import 'dart:io';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:parafait_maintainence/app/images/view_model/images_view_model.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';

class CapturePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  ImageViewModel imageViewModel;

  CapturePictureScreen({
    Key? key,
    required this.camera,
    required this.imageViewModel,
  }) : super(key: key);

  @override
  _CapturePictureScreenState createState() => _CapturePictureScreenState();
}

class _CapturePictureScreenState extends State<CapturePictureScreen> {
  late CameraController _cameraController;
  late Future initializeCameraControllerFuture;
  late AlertDialog alert;
  @override
  void initState() {
    super.initState();

    _cameraController = CameraController(widget.camera, ResolutionPreset.high);
    initializeCameraControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _cameraController.dispose();
    super.dispose();
  }

  void takePicture(BuildContext context) async {
    try {
      File localFile;
      await initializeCameraControllerFuture;
      final rawImage = await _cameraController.takePicture();
      File imageFile = File(rawImage.path);
      var uuid = const Uuid();
      int currentUnix = DateTime.now().millisecondsSinceEpoch;
      final directory = await getApplicationDocumentsDirectory();
      String fileFormat = imageFile.path.split('.').last;
      localFile = await imageFile.copy(
        '${directory.path}/${uuid.v4()}.$currentUnix.$fileFormat',
      );
      String fileName = localFile.path.split('/').last;

      // if (await appDirFolder.exists()) {
      //   print(appDirFolder.path);
      // } else {
      //   appDirFolder.create(recursive: true);
      // }

      int saved = await widget.imageViewModel.saveImage(context, fileName);

      if (saved > 0) Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      FutureBuilder(
        future: initializeCameraControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_cameraController);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CameraPreview(_cameraController);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      Align(
        alignment: FractionalOffset.bottomRight,
        child: FloatingActionButton(
          backgroundColor: Colors.grey[400],
          onPressed: () {
            takePicture(context);
          },
          child: const Icon(
            Icons.camera,
            color: Color.fromRGBO(238, 134, 100, 1),
          ),
        ),
      )
    ]);
  }
}

class PictureNameAndPath {
  File imagePath;
  String imageName;
  PictureNameAndPath({required this.imagePath, required this.imageName});

  File get getImagePath {
    return imagePath;
  }

  String get getImageName {
    return imageName;
  }
}
