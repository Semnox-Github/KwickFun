import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/game/model/model.dart';
import 'package:semnox_core/modules/game/repository/gamemachine_repository.dart';

class GameMachineBL {
  GameMachine? _gameMachine;
  int? _gameMachineId;
  GameMachineRepository? _gameMachineRepository;

  GameMachineBL.id(
      ExecutionContextDTO? executionContextDTO, int? gameMachineId) {
    _gameMachineRepository = GameMachineRepository(executionContextDTO);
    _gameMachineId = gameMachineId;
  }

  GameMachineBL.dto(
      ExecutionContextDTO executionContextDTO, GameMachine gameMachine) {
    _gameMachine = gameMachine;
    _gameMachineRepository = GameMachineRepository(executionContextDTO);
  }

  GameMachineBL(ExecutionContextDTO executionContextDTO) {
    _gameMachineRepository = GameMachineRepository(executionContextDTO);
  }

  Future<GameMachine?> getGameMachineByid() async {
    final gameMachine =
        await _gameMachineRepository?.getGameMachine(_gameMachineId!);
    return gameMachine;
  }
}
