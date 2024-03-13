import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/game/model/games_dto.dart';
import 'package:semnox_core/modules/game/repository/request/game_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';

class GameRepository {
  GameService? _gameService;
  GameRepository(ExecutionContextDTO? executionContextDTO) {
    _gameService = GameService(executionContextDTO);
  }

  Future<GamesDTO> getGamebyId(int gameid) async {
    final dtos = await _gameService?.getGameById(
      params: <GameFilterParams, dynamic>{
        GameFilterParams.gameId: gameid,
        GameFilterParams.isActive: true,
      },
    );
    if (dtos!.isEmpty) {
      return throw AppException(
          "No Game found with Id $gameid", "Invalid Data");
    }
    return dtos.first;
  }
}
