import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/game/model/model.dart';
import 'package:semnox_core/modules/game/repository/gamemachine_repository.dart';

class GameMachinesListBL {
  GameMachineRepository? _gameMachineRepository;

  GameMachinesListBL(ExecutionContextDTO? executionContextDTO) {
    _gameMachineRepository = GameMachineRepository(executionContextDTO);  }

  Future<List<GameMachine>?> fromIds([List<int>? ids]) async {
    final machines = await _gameMachineRepository?.getAllMachines(ids);
    return machines;
  }
}
