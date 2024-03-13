import 'dart:async';
import 'dart:io';
import 'package:retry/retry.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/game/model/game_profile_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/semnox_core.dart';

class GameProfileService extends ModuleService {
  final r = const RetryOptions(maxAttempts: 3);
  GameProfileService(ExecutionContextDTO? executionContext)
      : super(executionContext);

  Future<List<GameProfileDTO>> getGamesProfilebyId(
      {Map<GameProfileFilterParams, dynamic>? params}) async {
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          .get(SemnoxConstants.gameprofileUrl,
              queryParameters:
                  (params?.map((key, value) => MapEntry(key.name, value)) ?? {})
                    ..removeWhere((key, value) => value == null))
          .timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    final rawData = response.data;
    if (rawData is! Map) throw InvalidResponseException();
    List<GameProfileDTO> dtos = [];
    List rawItems = rawData["data"] ?? [];
    for (var item in rawItems) {
      var gameMachineDto = GameProfileDTO.fromJson(item);
      dtos.add(gameMachineDto);
    }
    return dtos;
  }
}
