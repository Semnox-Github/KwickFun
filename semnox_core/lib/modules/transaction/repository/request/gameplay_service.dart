import 'dart:async';
import 'dart:io';
import 'package:retry/retry.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/transaction/model/game_play_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/utils/index.dart';

class GamePlayService extends ModuleService {
  final r = const RetryOptions(maxAttempts: 3);
  GamePlayService(ExecutionContextDTO? executionContext)
      : super(executionContext);

  Future<List<GamePlayDto>> postGamePlay(
      {required int machineId, required String cardNumber}) async {
    APIResponse response = await r.retry(
      () async => await server.call()!.post(SemnoxConstants.gamePlaysUrl, [
        {
          // "GamePlayId":-1,
          "MachineId": machineId,
          "CardNumber": cardNumber
        }
      ]).timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    final rawData = response.data;
    if (rawData is! Map) throw InvalidResponseException();
    List<GamePlayDto> dtos = [];
    List rawItems = rawData["data"] ?? [];
    for (var item in rawItems) {
      dtos.add(GamePlayDto.fromMap(item));
    }
    return dtos;
  }

  Future<List<GamePlayDto>> getGamePlay({required int accountid}) async {
    APIResponse response = await r.retry(
      () async => await server
          .call()!
          .get(SemnoxConstants.gamePlaysUrl, queryParameters: {
        // "GamePlayId":-1,
        "accountId": accountid
      }).timeout(const Duration(seconds: 10)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    final rawData = response.data;
    if (rawData is! Map) throw InvalidResponseException();
    List<GamePlayDto> dtos = [];
    List rawItems = rawData["data"] ?? [];
    for (var item in rawItems) {
      dtos.add(GamePlayDto.fromMap(item));
    }
    return dtos;
  }
}
