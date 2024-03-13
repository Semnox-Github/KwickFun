import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/parafait_defaults_configuration/model/parafait_default_values_dto.dart';
import 'package:semnox_core/modules/parafait_defaults_configuration/repository/parafait_default_view_repository.dart';

class ParafaitDefaultViewBL {
  ParafaitDefaultViewRepository? _parafaitDefaultViewRepository;
  ExecutionContextDTO? _executionContext;

  ParafaitDefaultViewBL.id(ExecutionContextDTO executionContext, int id) {
    _parafaitDefaultViewRepository = ParafaitDefaultViewRepository();
  }

  ParafaitDefaultViewBL.dto(ExecutionContextDTO executionContext) {
    _parafaitDefaultViewRepository = ParafaitDefaultViewRepository();
  }

  ParafaitDefaultViewBL(ExecutionContextDTO? executionContext) {
    _parafaitDefaultViewRepository = ParafaitDefaultViewRepository();
    _executionContext = executionContext;
  }
}

class ParafaitDefaultViewListBL {
  ParafaitDefaultViewRepository? _parafaitDefaultViewRepository;
  ExecutionContextDTO? _executionContext;

  ParafaitDefaultViewListBL(ExecutionContextDTO? executionContext) {
    _parafaitDefaultViewRepository = ParafaitDefaultViewRepository();
    _executionContext = executionContext;
  }

  Future<List<ParafaitDefaultValueDto>?> getParafaitDefault() async {
    var parafaitDefaultDTOList = await _parafaitDefaultViewRepository
        ?.getParfaitDefaultViewDTO(_executionContext!);
    // if (parafaitDefaultDTOList!.isNotEmpty) {
    //   DefaultConfigProvider(parafaitDefaultDTOList);
    // }
    return parafaitDefaultDTOList;
  }
}
