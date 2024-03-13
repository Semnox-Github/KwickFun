import 'package:dio/src/dio_error.dart';

class AppException implements Exception {
  final _message;
  final _stacktrace;
  final _statusCode;

  String get message => _message;
  String get stacktrace => _stacktrace;
  int get statusCode => _statusCode;

  AppException([this._message, this._stacktrace, this._statusCode]);

  @override
  String toString() {
    return "${_message ?? ""}";
  }
}

// class DioException implements Exception {
//   final _error;
//   final _stacktrace;

//   DioError get error => _error;
//   StackTrace get stacktrace => _stacktrace;

//   DioException([this._error, this._stacktrace]);
// }

class FetchDataException extends AppException {
  FetchDataException([String message = ""])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class ConnectionTimeOutException extends AppException {
  ConnectionTimeOutException([message]) : super(message, "Invalid Request: ");
}

class InvalidPortException extends AppException {
  InvalidPortException([message]) : super(message, "Invalid Port: ");
}

class UnauthorizedException extends AppException {
  UnauthorizedException([message]) : super(message, "Unauthorized: ");
}

class ForbiddenException extends AppException {
  ForbiddenException([message]) : super(message);
}

class MethodNotAllowedException extends AppException {
  MethodNotAllowedException([message]) : super(message);
}

class InvalidInputException extends AppException {
  InvalidInputException([String message = ""])
      : super(message, "Invalid Input: ");
}

class InvalidResponseException extends AppException {
  InvalidResponseException(
      [String message = "Server returned invalid response"])
      : super(message, "Invalid Response: ");
}

class NotFoundException extends AppException {
  NotFoundException([String message = ""]) : super(message, "Not Found");
}

class NetworkConfigurationNotFoundException extends AppException {
  NetworkConfigurationNotFoundException(
      [String message = "Network Configuration Not Found Exception"])
      : super(message);
}

// class ServerNotReachableException extends DioException {
//   ServerNotReachableException([DioError? e, StackTrace? s]) : super(e, s);
// }

class ServerNotReachableException extends AppException {
  ServerNotReachableException({message, stackTrace, statusCode})
      : super(message, stackTrace, statusCode);
}

class NotImplementedException extends AppException {
  NotImplementedException([message]) : super(message);
}
