import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/game/model/game_machine_dto.dart';
import 'package:semnox_core/modules/transaction/bl/gameplays_bl.dart';

class TransactionUseCases {
  ExecutionContextDTO? _executionContextDTO;

  TransactionUseCases(ExecutionContextDTO? executionContextDTO) {
    _executionContextDTO = executionContextDTO;
  }

  Future<void> postGamePlay(
      String cardNo, GameMachineDto gameMachineDto) async {
    await GamePlaysBL(_executionContextDTO)
        .postGamePlay(machineId: gameMachineDto.machineId!, cardNumber: cardNo);
  }
}
