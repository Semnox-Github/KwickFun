import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/game/model/factory.dart';
import 'package:semnox_core/modules/game/model/model.dart';
import 'package:semnox_core/modules/game/repository/request/gamemachine_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';

class GameMachineRepository {
  GameMachineService? _gameMachineService;
  ExecutionContextDTO? _executionContextDTO;
  GameMachineRepository(ExecutionContextDTO? executionContextDTO) {
    _gameMachineService = GameMachineService(executionContextDTO);
    _executionContextDTO = executionContextDTO;
  }

  Future<GameMachine> getGameMachine(int id) async {
    final dtos = await _gameMachineService?.getMachines(
      params: <GameMachineFilterParams, String?>{
        GameMachineFilterParams.siteId: _executionContextDTO!.isCorporate
            ? _executionContextDTO!.siteId?.toString()
            : null,
        GameMachineFilterParams.machineId: [id].join(','),
      },
    );
    if (dtos!.isEmpty) {
      return throw AppException(
          "No Game Machine found with Id $id", "Invalid Data");
    }
    final dto = dtos.first;
    return GameMachine.fromDto(dto);
  }

  Future<List<GameMachine>?> getAllMachines([List<int>? ids]) async {
    Map<GameMachineFilterParams, dynamic> params = {
      GameMachineFilterParams.siteId: _executionContextDTO!.siteId?.toString(),
      GameMachineFilterParams.machineId: ids?.join(','),
    };

    final dtos = await _gameMachineService?.getMachines(params: params);
    final machines = await GameMachineListFactory.getMachinesAsync(dtos!
        .where(
          (element) => ids?.contains(element.machineId) ?? true,
        )
        .toList());
    return machines;
  }
}
