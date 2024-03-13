import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/game/model/game_profile_dto.dart';
import 'package:semnox_core/modules/game/repository/request/game_profile_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';

class GameProfileRepository {
  GameProfileService? _gameProfileService;
  GameProfileRepository(ExecutionContextDTO? executionContextDTO) {
    _gameProfileService = GameProfileService(executionContextDTO);
  }

  Future<GameProfileDTO> getGamesProfilebyId(int gameprofileId) async {
    final dtos = await _gameProfileService?.getGamesProfilebyId(
      params: <GameProfileFilterParams, dynamic>{
        GameProfileFilterParams.gameProfileId: gameprofileId,
        GameProfileFilterParams.isActive: true,
      },
    );
    if (dtos!.isEmpty) {
      return throw AppException(
          "No Game Profile found with Id $gameprofileId", "Invalid Data");
    }
    return dtos.first;
  }
}
