import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/transaction/bl/gameplays_bl.dart';
import 'package:semnox_core/modules/transaction/model/game_play_dto.dart';

///
///
/// BL Which Handles only Game Play Posting for Given Machine.
///
///
class GamePlayDataProvider {
  List<GamePlayDto>? _gameplayListDTO;
  ExecutionContextDTO? _executionContext;
  GamePlayDataProvider(
      {List<GamePlayDto>? gameplayListDTO,
      ExecutionContextDTO? executionContext}) {
    _gameplayListDTO = gameplayListDTO;
    _executionContext = executionContext;
  }

  Future<void> postGamePlay(int machineId, String cardNo,
      {int noOfTickets = 1}) async {
    await GamePlaysBL(_executionContext)
        .postGamePlay(machineId: machineId, cardNumber: cardNo);
  }

  Future<GamePlayDataProvider> getGamePlay(int accountid) async {
    _gameplayListDTO =
        await GamePlaysBL(_executionContext).getGamePlay(accountid: accountid);
    return GamePlayDataProvider(
        gameplayListDTO: _gameplayListDTO, executionContext: _executionContext);
  }

  List<GamePlayDto>? getgamePlayListDTO() {
    return _gameplayListDTO;
  }
}
