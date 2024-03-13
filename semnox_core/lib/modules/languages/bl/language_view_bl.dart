import 'package:semnox_core/modules/languages/model/language_container_dto.dart';
import 'package:semnox_core/modules/languages/repository/language_view_repository.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
class LanguageViewBL {
  LanguageViewRepository? _languageRepository;
  LanguageContainerDto? _languageContainerDto;

  LanguageViewBL.id(ExecutionContextDTO executionContext, int id) {
    _languageRepository = LanguageViewRepository();
  }

  LanguageViewBL.dto(ExecutionContextDTO executionContext,
      LanguageContainerDto languageContainerDto) {
    _languageRepository = LanguageViewRepository();
    _languageContainerDto = languageContainerDto;
  }

  LanguageContainerDto? getLanguagViewDTO() {
    return _languageContainerDto;
  }
}

class LanguageViewListBL {
  LanguageViewRepository? _languageRepository;
  ExecutionContextDTO? _executionContext;

  LanguageViewListBL(ExecutionContextDTO? executionContext) {
    _languageRepository = LanguageViewRepository();
    _executionContext = executionContext;
  }

  Future<List<LanguageContainerDto>?> getLanguages() async {
    var languageDTO =
        await _languageRepository?.getLanguageViewDTOList(_executionContext!);
    return languageDTO;
  }
}
