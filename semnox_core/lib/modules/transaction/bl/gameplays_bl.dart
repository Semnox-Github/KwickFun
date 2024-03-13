import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/transaction/model/game_play_dto.dart';
import 'package:semnox_core/modules/transaction/repository/gameplay_repository.dart';

class GamePlaysBL {
  GamePlayRepository? _gamePlayRepository;

  GamePlaysBL.id(ExecutionContextDTO? executionContextDTO, int? gameMachineId) {
    _gamePlayRepository = GamePlayRepository(executionContextDTO);
  }

  GamePlaysBL.dto(
      ExecutionContextDTO? executionContextDTO, GamePlayDto gamePlayDto) {
    _gamePlayRepository = GamePlayRepository(executionContextDTO);
  }

  GamePlaysBL(ExecutionContextDTO? executionContextDTO) {
    _gamePlayRepository = GamePlayRepository(executionContextDTO);
  }

  Future<void> postGamePlay(
      {required int machineId, required String cardNumber}) async {
    await _gamePlayRepository?.postGamePlay(
      machineId: machineId,
      cardNumber: cardNumber,
    );
  }

  Future<List<GamePlayDto>?> getGamePlay({required int accountid}) async {
    return await _gamePlayRepository?.getGamePlay(
      accountid: accountid,
    );
  }
}
