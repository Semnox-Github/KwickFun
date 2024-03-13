import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'api_response.dart';
import 'server_exception.dart';

class ParafaitServer {
  ExecutionContextDTO? executionContext;
  ParafaitServer(this.executionContext) {
    Map<String, dynamic> header = {"Content-Type": "application/json"};
    if (executionContext?.authToken != null) {
      header["Authorization"] = executionContext?.authToken;
    }
    dio = Dio(BaseOptions(
        baseUrl: executionContext!.apiUrl!,
        headers: header,
        connectTimeout: 60 * 1000,
        // connectTimeout:
        //     DefaultConfigProvider.getConfigFor("API_TIME_OUT_SECONDS") != null
        //         ? int.parse(DefaultConfigProvider.getConfigFor(
        //                 "API_TIME_OUT_SECONDS")!) *
        //             1000
        //         : 60 * 1000,
        receiveTimeout: 60 * 1000));
  }

  late final Map<String, dynamic> _defaultQueryParams = {};
  late Dio dio;

  Future<APIResponse> get<T>(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      log('''
            ${"*" * 10}
            Server Url: ${executionContext?.apiUrl}
            API End Point: $path 
            Type: GET
            queryParameters: $queryParameters
            defaultQueryParameter : $_defaultQueryParams
            Auth Token: ${executionContext?.authToken}
            ${"*" * 10}
      ''');
      final params = queryParameters ?? {};
      if (_defaultQueryParams.isNotEmpty) params.addAll(_defaultQueryParams);
      Response response =
          await dio.get(getFormattedPath(path), queryParameters: params);
      return APIResponse(data: response.data, header: response.headers.map);
    } on DioError catch (e, s) {
      handelException(e, s);
    } catch (e) {
      throw AppException(e.toString(), "");
    }
    return APIResponse(data: null, header: {});
  }

  Future<APIResponse> post<T>(String path, body,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      // log('''
      //         ${"*" * 10}
      //         Server Url: ${executionContext?.apiUrl}
      //         API End Point: $path
      //         Type: POST
      //         queryParameters: $queryParameters
      //         body: $body
      //         Auth Token: ${executionContext?.authToken}
      //         ${"*" * 10}
      // ''');
      Response response = await dio.post(getFormattedPath(path),
          data: body, queryParameters: queryParameters);
      return APIResponse(data: response.data, header: response.headers.map);
    } on DioError catch (e, s) {
      handelException(e, s);
    } catch (e) {
      throw AppException(e.toString(), "");
    }
    return APIResponse(data: null, header: {});
  }

  String getFormattedPath(String path) {
    if (dio.options.baseUrl.endsWith("/")) {
      if (path.startsWith("/")) {
        return path.substring(1);
      }
      return path;
    }
    if (!path.startsWith("/")) {
      return "/$path";
    }
    return path;
  }

  void handelException(DioError e, StackTrace s) {
    switch (e.type) {
      case DioErrorType.connectTimeout:
        throw ConnectionTimeOutException(
            "Connection Timeout while reaching server");

      case DioErrorType.sendTimeout:
        throw ConnectionTimeOutException(
            "Connection Timeout while Sending data to server");

      case DioErrorType.receiveTimeout:
        throw ConnectionTimeOutException(
            "Connection Timeout while recieving data from server");

      case DioErrorType.response:
        switch (e.response?.statusCode) {
          case 400:
            throw BadRequestException(e.response?.data["data"] ??
                e.response?.statusMessage ??
                "BadRequestException:");
          case 401:
            throw UnauthorizedException(
                e.response?.statusMessage.toString() ?? "Unauthorized:");
          case 403:
            throw ForbiddenException(
                e.response?.statusMessage.toString() ?? "Forbidden:");

          case 404:
            throw NotFoundException(
                e.response?.statusMessage.toString() ?? "Not Found");

          case 405:
            throw MethodNotAllowedException(
                e.response?.statusMessage.toString() ?? "Method Not Allowed");

          case 422:
            throw InvalidInputException(
                e.response?.data["message"].toString() ?? "");

          case 500:
            throw ServerNotReachableException(
                message: e.response?.data["data"] != ""
                    ? e.response?.data["data"] ?? e.response?.statusMessage
                    : "Internal Server Error",
                stackTrace: e.stackTrace.toString(),
                statusCode: e.response?.statusCode);

          case 501:
            throw NotImplementedException(e.response?.data ??
                e.response?.statusMessage ??
                "Not Implemented");
          case 503:
            throw ServerNotReachableException(
                message: e.response?.data["data"] != ""
                    ? e.response?.data["data"] ?? e.response?.statusMessage
                    : "Internal Server Error",
                stackTrace: e.stackTrace.toString(),
                statusCode: e.response?.statusCode);

          default:
            throw FetchDataException(
                'Error occurred while Communication with Server: ${e.message}');
        }

      case DioErrorType.cancel:
        throw AppException("Request was canceled", "Cancel:");

      case DioErrorType.other:
        if (e.message.contains("SocketException")) {
          throw SocketException(e.message.toString());
        } else if (e.message.contains("Invalid port")) {
          throw InvalidPortException(e.message);
        } else {
          throw NotFoundException(e.message);
        }
    }
  }
}
