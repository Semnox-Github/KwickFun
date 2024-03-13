import 'dart:async';
import 'dart:io';
import 'package:retry/retry.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/hr/model/users_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/utils/index.dart';

class UserService extends ModuleService {
  final r = const RetryOptions(maxAttempts: 3);
  UserService(ExecutionContextDTO? executionContext) : super(executionContext);

  static final Map<UserDTOSearchParameter, dynamic> _queryParams = {
    UserDTOSearchParameter.HASH: "hash",
    UserDTOSearchParameter.REBUILDCACHE: "rebuildCache",
    UserDTOSearchParameter.SITEID: 'siteId'
    // UserDTOSearchParameter.userId: "userId",
    // UserDTOSearchParameter.userRoleId: "userRoleId",
    // UserDTOSearchParameter.userName: "userName",
    // UserDTOSearchParameter.userStatus: "userStatus",
    // UserDTOSearchParameter.empNumber: "empNumber",
    // UserDTOSearchParameter.departmentId: "departmentId",
    // UserDTOSearchParameter.cardNumber: "cardNumber",
    // UserDTOSearchParameter.loadUserTags: "loadUserTags",
  };

  Future<List<UsersDto>> getUserDTOList(
      Map<UserDTOSearchParameter, dynamic> params) async {
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          //chcecks done for user at settings authorization
          //userUrl
          .get(SemnoxConstants.userContainerUrl,
              queryParameters: await _constructContainerQueryParams(params))
          .timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    Map rawData = response.data;
    List<UsersDto> dtos = [];
    if (rawData["data"]['UserContainerDTOList'] != null) {
      if (rawData["data"]['UserContainerDTOList'] is List) {
        print('trueList');
        List rawItems = rawData["data"]['UserContainerDTOList'];
        for (var item in rawItems) {
          dtos.add(UsersDto.fromJson(item));
        }
      }
      // List rawItems = rawData["data"];
      // for (var item in rawItems) {
      //   dtos.add(UsersDto.fromJson(item));
      // }
    }
    return dtos;
  }

  Future<Map<String, dynamic>> _constructContainerQueryParams(
      Map<UserDTOSearchParameter, dynamic> searchParams) async {
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

//---------------------------
// import 'dart:async';
// import 'dart:io';
// import 'package:retry/retry.dart';
// import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
// import 'package:semnox_core/modules/hr/model/user_container_dto.dart';
// import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
// import 'package:semnox_core/modules/utilities/api_service_library/data_with_hash.dart';
// import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
// import 'package:semnox_core/utils/constants.dart';

// class UserService extends ModuleService {
//   final r = const RetryOptions(maxAttempts: 3);
//   UserService(ExecutionContextDTO? executionContext) : super(executionContext);

//   static final Map<UserContainerDTOSearchParameter, dynamic> _queryParams = {
//     UserContainerDTOSearchParameter.HASH: "hash",
//     UserContainerDTOSearchParameter.REBUILDCACHE: "rebuildCache",
//     UserContainerDTOSearchParameter.SITEID: 'siteId'
//   };

//   Future<DataWithHash<List?>?> getUserContainer(
//       {required Map<UserContainerDTOSearchParameter, dynamic>
//           searchParams}) async {
//     APIResponse response = await r.retry(
//       () async => await server
//           .call()!
//           //chcecks done for user at settings authorization
//           //userUrl
//           .get(SemnoxConstants.userContainerUrl,
//               queryParameters:
//                   await _constructContainerQueryParams(searchParams))
//           .timeout(const Duration(seconds: 10)),
//       // Retry on SocketException or TimeoutException
//       retryIf: (e) => e is SocketException || e is TimeoutException,
//     );
//     Map data = response.data;
//     print('userRolenewnew:$data');
//     return data["data"] == null
//         ? null
//         : DataWithHash(
//             data: data["data"]["UserContainerDTOList"],
//             hash: data["data"]["Hash"]);
//   }

//   Future<Map<String, dynamic>> _constructContainerQueryParams(
//       Map<UserContainerDTOSearchParameter, dynamic> searchParams) async {
//     Map<String, dynamic> queryparameter = {};

//     _queryParams.forEach((key, value) {
//       var valu = searchParams[key];
//       if (valu != null) {
//         queryparameter.addAll({value: valu});
//       }
//     });
//     return queryparameter;
//   }
// }
