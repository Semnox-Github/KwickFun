import 'dart:async';
import 'dart:io';
import 'package:retry/retry.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/maintainence_service_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service_layer.dart';

class CheckListDetailService extends ModuleServiceLayer {
  final r = const RetryOptions(maxAttempts: 3);
  CheckListDetailService(ExecutionContextDTO executionContext)
      : super(executionContext);
  static final Map<CheckListDetailSearchParameter, dynamic> _queryParams = {
    CheckListDetailSearchParameter.ACTIVITYTYPE: "activityType",
    CheckListDetailSearchParameter.ISACTIVE: "isActive",
    CheckListDetailSearchParameter.STATUS: "status",
    CheckListDetailSearchParameter.REQUESTTYPE: "requestType",
    CheckListDetailSearchParameter.PRIORITY: "priority",
    CheckListDetailSearchParameter.SCHEDULEFROMDATE: "scheduleFromDate",
    CheckListDetailSearchParameter.SCHEDULETODATE: "scheduleToDate",
    CheckListDetailSearchParameter.REQFROMDATE: "reqFromDate",
    CheckListDetailSearchParameter.REQTODATE: "reqToDate",
    CheckListDetailSearchParameter.JOBID: "jobId",
    CheckListDetailSearchParameter.TASKID: "taskId",
    CheckListDetailSearchParameter.ASSIGNEDTO: "assignedTo",
    CheckListDetailSearchParameter.JOBSPASTDUEDATE: "jobsPastDueDate",
    CheckListDetailSearchParameter.LOADACTIVECHILD: "loadActiveChild",
    CheckListDetailSearchParameter.BUILDCHILDRECORDS: "buildChildRecords",
    CheckListDetailSearchParameter.REQUESTBY: "requestedBy",
    CheckListDetailSearchParameter.SITEID: "siteId",
  };

  @override
  Future<List?> getData({required Map? searchparams}) async {
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          .get("/api/Maintenance/MaintenanceServices",
              queryParameters:
                  await _constructContainerQueryParams(searchparams))
          .timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    Map data = await response.data;
    // List<CheckListDetailDTO> dtos = [];
    // if (data["data"] != null) {
    //   List rawList = data["data"];
    //   for (var item in rawList) {
    //     dtos.add(CheckListDetailDTO.fromMap(item));
    //   }
    // }
    return data["data"] ?? [];
  }

  @override
  Future<List?> postData(Object? dto, Map? searchparams) async {
    List checklist = [];
    checklist.add(CheckListDetailDTO().toseverMap());
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          .post("/api/Maintenance/MaintenanceServices", checklist,
              queryParameters:
                  await _constructContainerQueryParams(searchparams))
          .timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    Map data = await response.data;
    List<CheckListDetailDTO> dtos = [];
    if (data["data"] != null) {
      List rawList = data["data"];
      for (var item in rawList) {
        dtos.add(CheckListDetailDTO.fromMap(item));
      }
    }
    return dtos;
  }

  Future<List<CheckListDetailDTO>> getCheckListDetailsDTOList(
      Map<CheckListDetailSearchParameter, dynamic> searchParams) async {
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          .get("/api/Maintenance/MaintenanceServices",
              queryParameters:
                  await _constructContainerQueryParams(searchParams))
          .timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    Map data = await response.data;
    List<CheckListDetailDTO> dtos = [];
    if (data["data"] != null) {
      List rawList = data["data"];
      for (var item in rawList) {
        dtos.add(CheckListDetailDTO.fromMap(item));
      }
    }
    return dtos;
  }

  Future<List<CheckListDetailDTO>> postchecklistdto(
      CheckListDetailDTO localcheckListDetailsDTO,
      Map<CheckListDetailSearchParameter, dynamic> postsearchparams) async {
    List checklist = [];
    checklist.add(localcheckListDetailsDTO.toseverMap());
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          .post("/api/Maintenance/MaintenanceServices", checklist,
              queryParameters:
                  await _constructContainerQueryParams(postsearchparams))
          .timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    Map data = await response.data;
    List<CheckListDetailDTO> dtos = [];
    if (data["data"] != null) {
      List rawList = data["data"];
      for (var item in rawList) {
        dtos.add(CheckListDetailDTO.fromMap(item));
      }
    }
    return dtos;
  }

  Future<Map<String, dynamic>> _constructContainerQueryParams(
      searchParams) async {
    Map<String, dynamic> queryparameter = {};
    _queryParams.forEach((key, value) {
      var valu = searchParams[key];
      if (valu != null) {
        queryparameter.addAll({value: valu});
      }
    });
    return queryparameter;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
