import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/game/model/games_dto.dart';
import 'package:semnox_core/modules/game/repository/game_repository.dart';

class GameBL {
  int? _gameId;
  GameRepository? _gameRepository;

  GameBL.id(ExecutionContextDTO? executionContextDTO, int? gameId) {
    _gameRepository = GameRepository(executionContextDTO);
    _gameId = gameId;
  }

  GameBL.dto(ExecutionContextDTO executionContextDTO, GamesDTO gamesDTO) {
    _gameRepository = GameRepository(executionContextDTO);
  }

  GameBL(ExecutionContextDTO executionContextDTO) {
    _gameRepository = GameRepository(executionContextDTO);
  }

  Future<GamesDTO?> getGameByid() async {
    final gameDtO = await _gameRepository?.getGamebyId(_gameId!);
    return gameDtO;
  }
}
