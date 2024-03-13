import 'package:semnox_core/modules/pos_machines/model/pos_machine_dto.dart';
import 'package:semnox_core/modules/pos_machines/repository/pos_machine_view_repository.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

class PosMachineBL {
  PosMachineViewRespository? _posMachineViewRespository;
  PosMachineDTO? _posMachineDTO;

  PosMachineBL.id(ExecutionContextDTO executionContext, int id) {
    _posMachineViewRespository = PosMachineViewRespository();
  }

  PosMachineBL.dto(
      ExecutionContextDTO executionContext, PosMachineDTO posMachineDTO) {
    _posMachineViewRespository = PosMachineViewRespository();
    _posMachineDTO = posMachineDTO;
  }

  PosMachineDTO? getPosmachineDTO() {
    return _posMachineDTO;
  }
}

class PosMachineListBL {
  PosMachineViewRespository? _posMachineRespository;
  ExecutionContextDTO? _executionContext;

  PosMachineListBL(ExecutionContextDTO? executionContext) {
    _posMachineRespository = PosMachineViewRespository();
    _executionContext = executionContext;
  }

  Future<List<PosMachineDTO?>> getPosMachines() async {
    var posMachineListDTO = await _posMachineRespository
        ?.getPosMachineViewDTOList(_executionContext!);
    return posMachineListDTO!;
  }
}
