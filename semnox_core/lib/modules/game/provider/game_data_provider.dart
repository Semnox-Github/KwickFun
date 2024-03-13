import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/game/bl/game_bl.dart';
import 'package:semnox_core/modules/game/bl/game_machine_bl.dart';
import 'package:semnox_core/modules/game/bl/game_profile_bl.dart';
import 'package:semnox_core/modules/game/model/game_profile_dto.dart';
import 'package:semnox_core/modules/game/model/games_dto.dart';
import 'package:semnox_core/modules/game/model/model.dart';
import 'package:semnox_core/modules/transaction/bl/gameplays_bl.dart';

///
///
/// BL Which Handles only Game Play Posting for Given Machine.
///
///

class GameDataProvider {
  static GameDataProvider machine(
      ExecutionContextDTO? executionContext, GameMachine? gameMachine) {
    return GameDataProvider(gameMachine!, executionContext!);
  }

  static Future<GameDataProvider> id(
      ExecutionContextDTO executionContext, int gameMachineId) async {
    final gameMachine = await GameMachineBL.id(executionContext, gameMachineId)
        .getGameMachineByid();
    return machine(executionContext, gameMachine!);
  }

  final GameMachine gameMachine;
  final ExecutionContextDTO executionContext;
  GameDataProvider(
    this.gameMachine,
    this.executionContext,
  );

  Future<GamesDTO?> getGamesbyId() async {
    return await GameBL.id(executionContext, gameMachine.gameId).getGameByid();
  }

  Future<void> postGamePlay(String cardNo, {int noOfTickets = 1}) async {
    await GamePlaysBL(executionContext)
        .postGamePlay(machineId: gameMachine.machineId, cardNumber: cardNo);
  }

  Future<GameProfileDTO?> getGamesProfilebyId(int? gameProfileId) async {
    return await GameProfileBL.id(executionContext, gameProfileId)
        .getGamesProfilebyId();
  }
}
