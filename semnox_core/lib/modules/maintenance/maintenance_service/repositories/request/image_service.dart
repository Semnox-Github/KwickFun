import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/images_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/repositories/image_repositories.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';

class ImageService extends ModuleService {
  final r = const RetryOptions(maxAttempts: 3);
  ImageService(ExecutionContextDTO executionContext) : super(executionContext);
  static final Map<ImageSearchParameter, dynamic> _queryParams = {
    ImageSearchParameter.ISACTIVE: "isActive",
    ImageSearchParameter.IMAGEID: "imageId"
  };

  Future<List<ImageDTO>> getImageDTOList(int? maintChklstdetId) async {
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          .get("/api/Maintenance/$maintChklstdetId/Images", queryParameters: {
        'isActive': 1,
      }).timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    Map data = response.data;
    if (response.data is! Map) {
      throw InvalidResponseException("Invalid Response.");
    }
    List<ImageDTO> dtos = [];
    if (data["data"] != null) {
      List rawList = data["data"];
      for (var item in rawList) {
        dtos.add(ImageDTO.fromMap(item));
      }
    }
    return dtos;
  }

  Future<List<ImageDTO>> postImageDTOList(
      ImageDTO dto, Map<ImageSearchParameter, dynamic> searchparams) async {
    List imagelist = [];
    imagelist.add(dto.toMap());
    log('request-data: $imagelist');
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          .post("/api/Maintenance/${dto.maintCheckListDetailId}/Images",
              imagelist,
              queryParameters:
                  await _constructContainerQueryParams(searchparams))
          .timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    Map data = response.data;
    if (response.data is! Map) {
      throw InvalidResponseException("Invalid Response.");
    }
    List<ImageDTO> dtos = [];
    if (data["data"] != null) {
      List rawList = data["data"];
      for (var item in rawList) {
        dtos.add(ImageDTO.fromMap(item));
      }
    }
    return dtos;
  }

  Future<bool> postfileupload(FileUpload file, ImageDTO imageDTO) async {
    bool result = false;
    String fileName = file.file!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.file!.path, filename: fileName),
      "EntityName": file.entityname,
      "EntityId": 1,
    });
    log('request-data: $formData');
    await server
        .call()!
        .post("/api/CommonServices/FileUpload", formData)
        .then((response) {
      var data = response.data;
      if (response.data is! Map) {
        throw InvalidResponseException("Invalid Response.");
      }
      if (data["data"] == "") {
        return result = true;
      } else {
        return result = false;
      }
    }).catchError((error) {
      return result = false;
    });
    return result;
  }

  Future<String> getfileupload(ImageDTO imageDTO) async {
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          .get("/api/CommonServices/FileUpload", queryParameters: {
        "fileType": "MAINTENANCEREQUESTS",
        "filename": imageDTO.imageFileName,
      }).timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    Map data = response.data;
    if (response.data is! Map) {
      throw InvalidResponseException("Invalid Response.");
    }
    List dtos = [];
    if (data["data"] != null) {
      dtos = data["data"];
    }
    return dtos.first.toString();
  }

  Future<Map<String, dynamic>> _constructContainerQueryParams(
      Map<ImageSearchParameter, dynamic> searchParams) async {
    Map<String, dynamic> queryparameter = {};
    _queryParams.forEach((key, value) {
      var valu = searchParams[key];
      if (valu != null) {
        queryparameter.addAll({value: valu});
      }
    });
    return queryparameter;
  }
}
