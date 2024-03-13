import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/transaction/model/game_play_dto.dart';
import 'package:semnox_core/modules/transaction/repository/request/gameplay_service.dart';

class GamePlayRepository {
  GamePlayService? _gamePlayService;

  GamePlayRepository(ExecutionContextDTO? executionContextDTO) {
    _gamePlayService = GamePlayService(executionContextDTO);
  }

  Future<void> postGamePlay(
      {required int machineId, required String cardNumber}) async {
    await _gamePlayService?.postGamePlay(
      machineId: machineId,
      cardNumber: cardNumber,
    );
  }

  Future<List<GamePlayDto>?> getGamePlay({required int accountid}) async {
    return await _gamePlayService?.getGamePlay(
      accountid: accountid,
    );
  }
}
