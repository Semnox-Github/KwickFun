import 'dart:async';
import 'dart:io';
import 'package:retry/retry.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/game/model/games_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/semnox_core.dart';

class GameService extends ModuleService {
  final r = const RetryOptions(maxAttempts: 3);
  GameService(ExecutionContextDTO? executionContext) : super(executionContext);

  Future<List<GamesDTO>> getGameById(
      {Map<GameFilterParams, dynamic>? params}) async {
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          .get(SemnoxConstants.gameUrl,
              queryParameters:
                  (params?.map((key, value) => MapEntry(key.name, value)) ?? {})
                    ..removeWhere((key, value) => value == null))
          .timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    final rawData = response.data;
    if (rawData is! Map) throw InvalidResponseException();
    List<GamesDTO> dtos = [];
    List rawItems = rawData["data"] ?? [];
    for (var item in rawItems) {
      var gameMachineDto = GamesDTO.fromJson(item);
      dtos.add(gameMachineDto);
    }
    return dtos;
  }
}
