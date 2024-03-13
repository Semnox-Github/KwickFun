import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/game/model/game_profile_dto.dart';
import 'package:semnox_core/modules/game/model/games_dto.dart';
import 'package:semnox_core/modules/game/repository/game_profile_repository.dart';

class GameProfileBL {
  int? _gameprofileId;
  GameProfileRepository? _gameProfileRepository;

  GameProfileBL.id(
      ExecutionContextDTO? executionContextDTO, int? gameprofileId) {
    _gameProfileRepository = GameProfileRepository(executionContextDTO);
    _gameprofileId = gameprofileId;
  }

  GameProfileBL.dto(
      ExecutionContextDTO executionContextDTO, GamesDTO gamesDTO) {
    _gameProfileRepository = GameProfileRepository(executionContextDTO);
  }

  GameProfileBL(ExecutionContextDTO executionContextDTO) {
    _gameProfileRepository = GameProfileRepository(executionContextDTO);
  }

  Future<GameProfileDTO?> getGamesProfilebyId() async {
    final gameprofileDTO =
        await _gameProfileRepository?.getGamesProfilebyId(_gameprofileId!);
    return gameprofileDTO;
  }
}
