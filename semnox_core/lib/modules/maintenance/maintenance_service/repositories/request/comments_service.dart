import 'dart:async';
import 'dart:io';
import 'package:retry/retry.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/comments_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';

class CommentService extends ModuleService {
  final r = const RetryOptions(maxAttempts: 3);
  CommentService(ExecutionContextDTO executionContext)
      : super(executionContext);
  static final Map<CommentsSearchParameter, dynamic> _queryParams = {
    CommentsSearchParameter.ISACTIVE: "isActive",
    CommentsSearchParameter.COMMENTID: "commentId"
  };

  Future<List<CommentsDTO>> getCommentDTOList(int? maintChklstdetId) async {
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          .get("/api/Maintenance/$maintChklstdetId/Comments", queryParameters: {
        'isActive': 1
      }).timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    Map data = response.data;
    if (response.data is! Map) {
      throw InvalidResponseException("Invalid Response.");
    }
    List<CommentsDTO> dtos = [];
    if (data["data"] != null) {
      List rawList = data["data"];
      for (var item in rawList) {
        dtos.add(CommentsDTO.fromMap(item));
      }
    }
    return dtos;
  }

  Future<List<CommentsDTO>> postCommentDTOList(CommentsDTO dto,
      Map<CommentsSearchParameter, dynamic> searchparams) async {
    List commentlist = [];
    commentlist.add(dto.toMap());
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          .post("/api/Maintenance/${dto.maintCheckListDetailId}/Comments",
              commentlist,
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
    List<CommentsDTO> dtos = [];
    if (data["data"] != null) {
      List rawList = data["data"];
      for (var item in rawList) {
        dtos.add(CommentsDTO.fromMap(item));
      }
    }
    return dtos;
  }

  Future<Map<String, dynamic>> _constructContainerQueryParams(
      Map<CommentsSearchParameter, dynamic> searchParams) async {
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
