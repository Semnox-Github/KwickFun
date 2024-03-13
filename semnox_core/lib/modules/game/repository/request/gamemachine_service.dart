import 'dart:async';
import 'dart:io';

import 'package:retry/retry.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/game/model/game_machine_dto.dart';
import 'package:semnox_core/modules/game/model/model.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/semnox_core.dart';

class GameMachineService extends ModuleService {
  final r = const RetryOptions(maxAttempts: 3);
  GameMachineService(ExecutionContextDTO? executionContext)
      : super(executionContext);

  Future<List<GameMachineDto>> getMachines(
      {Map<GameMachineFilterParams, dynamic>? params}) async {
    // try {
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          .get(SemnoxConstants.gameMachineUrl,
              queryParameters:
                  (params?.map((key, value) => MapEntry(key.name, value)) ?? {})
                    ..removeWhere((key, value) => value == null))
          .timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    final rawData = response.data; //await compute(jsonDecode,menuData); //
    if (rawData is! Map) throw InvalidResponseException();
    List<GameMachineDto> dtos = [];
    List rawItems = rawData["data"] ?? [];
    for (var item in rawItems) {
      var gameMachineDto = GameMachineDto.fromMap(item);

      ///
      /// TODO: Since API is not filtering machines by id, It is being done manually.
      ///
      // if (params?.ids?.contains(gameMachineDto.machineId) ?? true) {
      dtos.add(gameMachineDto);
      // }
    }

    return dtos;
    // } catch (e) {
    //   if (e is DioError) {
    //     handelException(e);
    //   }
    //   throw e;
    // }
  }
}

// class GameMachineFilterParams {
//   int? siteId;
//   List<int>? ids;
//   GameMachineFilterParams({
//     this.siteId,
//     this.ids,
//   });

//   Map<String, dynamic> get queryParams {
//     Map<String, dynamic> map = {};
//     if (siteId != null) {
//       map["siteId"] = siteId;
//     }
//     if (ids?.isNotEmpty ?? false) {
//       map["machineId"] = ids!.join(",");
//     }
//     return map;
//   }
// }
