import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/bl/image_bl.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/images_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/repositories/dbhandler/image_dbhandler.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/repositories/request/image_service.dart';
import 'package:uuid/uuid.dart';

class ImageRepositories {
  ImageService? _request;
  ExecutionContextDTO? _executionContext;
  int count = 0;
  // int? updatedCount = 0, insertedCount = 0;

  ImageRepositories(ExecutionContextDTO executionContext) {
    _executionContext = executionContext;
    _request = ImageService(_executionContext!);
  }

  Future<List<ImageDTO>> getimageDTOList(
      Map<ImageSearchParameter, dynamic> searchparams) async {
    return await ImageDbHandler(_executionContext!).getImageList(searchparams);
  }

  Future<int> postImageDto(ImageDTO imageDTO,
      Map<ImageSearchParameter, dynamic> postsearchparams) async {
    final result = await Connectivity().checkConnectivity();
    if (result.name != "none") {
      print('Connected to a network');

      try {
        List<ImageDTO> serverImageDTOList =
            await _request!.postImageDTOList(imageDTO, postsearchparams);

        if (serverImageDTOList.isNotEmpty) {
          for (var dto in serverImageDTOList) {
            imageDTO.RefreshServerValues(dto);
            int value = await ImageDbHandler(_executionContext!)
                .updateimageTable(imageDTO);
            if (value != -1) {
              return value;
            }
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('No Connection');
    }
    return -1;
  }

  Future<int> saveImage(ImageDTO imageDTO) async {
    return await ImageDbHandler(_executionContext!).insertimageTable(imageDTO);
  }

  Future<List<ImageDTO>> getimagefromserver(int? maintChklstdetId) async {
    late List<ImageDTO> localimageDTOList;
    ImageDbHandler imageDbHandler = ImageDbHandler(_executionContext!);
    Map<ImageSearchParameter, dynamic> searchparams = {
      ImageSearchParameter.SITEID: _executionContext!.siteId,
      ImageSearchParameter.ISACTIVE: 1,
    };
    final result = await Connectivity().checkConnectivity();
    if (result.name != "none") {
      print('Connected to a network');

      ImageService imageService = ImageService(_executionContext!);
      List<ImageDTO> serverimageDTOList =
          await imageService.getImageDTOList(maintChklstdetId);

      if (serverimageDTOList.isNotEmpty) {
        localimageDTOList = await imageDbHandler.getImageList(searchparams);
        for (var element in serverimageDTOList) {
          bool insertElement = false;
          if (localimageDTOList.isEmpty) {
            insertElement = true;
          } else {
            var myListFiltered =
                localimageDTOList.where((e) => e.imageId == element.imageId);

            if (myListFiltered.isEmpty) {
              //value not exists
              insertElement = true;
            } else {
              //value exists
              ImageDTO imageDTO = myListFiltered.first;
              if (element.lastUpdatedDate != imageDTO.lastUpdatedDate) {
                imageDTO.RefreshServerValues(element);
                Logger().d('''
              ${"*" * 10}
              Entity: "IMAGE GET" : Start Time: ${DateTime.now()}
              Total Count: ${serverimageDTOList.length},
              Maint_chklstID : $maintChklstdetId,
              ${"*" * 10}
              ''');
                int result = await imageDbHandler.updateimageTable(imageDTO);
                if (result != -1) {
                  ImageBL imageBL = ImageBL.dto(_executionContext!, imageDTO);
                  Logger().d('''
                          ${"*" * 10}
                          Entity: "FILE GET" : Start Time: ${DateTime.now()}
                          Total Count: ${serverimageDTOList.length},
                          ${"*" * 10}
                          ''');

                  await imageBL.getfileupload();

                  Logger().d('''
                          ${"*" * 10}
                          Entity: "FILE GET" : End Time: ${DateTime.now()}
                          Total Count: ${serverimageDTOList.length},
                          Image Writing to directory : ${serverimageDTOList.length},
                          ${"*" * 10}
                  ''');
                  Logger().d('''
              ${"*" * 10}
              Entity: "IMAGE GET" : End Time: ${DateTime.now()}
              Updated Count to DB : ${serverimageDTOList.length}
              Maint_chklstID : $maintChklstdetId,
              ${"*" * 10}
              ''');
                }
              }
            }
          }
          if (insertElement == true) {
            // insert object
            ImageDTO imageDTO = ImageDTO();
            imageDTO.RefreshServerValues(element);

            Logger().d('''
              ${"*" * 10}
              Entity: "IMAGE GET" : Start Time: ${DateTime.now()}
              Total Count: ${serverimageDTOList.length},
              Maint_chklstID : $maintChklstdetId,
              ${"*" * 10}
              ''');

            int result = await imageDbHandler.insertimageTable(imageDTO);
            if (result != -1) {
              ImageBL imageBL = ImageBL.dto(_executionContext!, imageDTO);
              Logger().d('''
                      ${"*" * 10}
                      Entity: "FILE GET" : Start Time: ${DateTime.now()}
                      Total Count: ${serverimageDTOList.length},
                      ${"*" * 10}
                      ''');

              await imageBL.getfileupload();

              Logger().d('''
                      ${"*" * 10}
                      Entity: "FILE GET" : End Time: ${DateTime.now()}
                      Total Count: ${serverimageDTOList.length},
                      Image Writing to directory : ${serverimageDTOList.length},
                      ${"*" * 10}
              ''');
              Logger().d('''
              ${"*" * 10}
              Entity: "IMAGE GET" : End Time: ${DateTime.now()}
              Inserted Count to DB : ${serverimageDTOList.length},
              Maint_chklstID : $maintChklstdetId,
              ${"*" * 10}
              ''');
            }
          }
        }
      }
    }
    print('Fetch data from local');
    localimageDTOList = await imageDbHandler.getImageList(searchparams);
    return localimageDTOList;
  }

  Future<bool> postfileupload(ImageDTO imageDTO) async {
    final result = await Connectivity().checkConnectivity();
    if (result.name != "none") {
      print('Connected to a network');
      try {
        FileUpload fileUpload = FileUpload(
            await _getLocalFile(imageDTO.imageFileName.toString()),
            "MAINTENANCEREQUESTS");
        bool result = await _request!.postfileupload(fileUpload, imageDTO);

        if (result == true) {
          ImageDbHandler imageDbHandler = ImageDbHandler(_executionContext!);
          imageDTO.fileupload = true;
          imageDbHandler.updateimageTable(imageDTO);
        }
        return result;
      } catch (e) {
        print(e);
      }
    } else {
      print('No Connection');
    }
    return false;
  }

  Future<void> getfileupload(ImageDTO imageDTO) async {
    final result = await Connectivity().checkConnectivity();
    if (result.name != "none") {
      print('Connected to a network');

      try {
        String base64String = await _request!.getfileupload(imageDTO);
        if (base64String.isNotEmpty) {
          await createFileFromString(base64String, imageDTO.imageFileName);
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('No Connection');
    }
  }

  _getLocalFile(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    File f = File('${directory.path}/$filename');
    return f;
  }

  Future<String> createFileFromString(
      String base64string, String? imageFileName) async {
    final encodedStr = base64string;
    Uint8List bytes = base64.decode(encodedStr);
    var uuid = const Uuid();
    int currentUnix = DateTime.now().millisecondsSinceEpoch;
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
        "/data/user/0/com.semnox.parafait_maintainence.dev/app_flutter/$imageFileName");
    await file.writeAsBytes(bytes);
    return file.path;
  }
}

class FileUpload {
  File? file;
  String? entityname;

  FileUpload(
    this.file,
    this.entityname,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['File'] = file;
    data['EntityName'] = entityname;
    data['EntityId'] = 1;
    return data;
  }
}
