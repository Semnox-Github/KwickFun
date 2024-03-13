import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_ride/routes.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/languages/bl/language_view_bl.dart';
import 'package:semnox_core/modules/languages/model/language_container_dto.dart';
import 'package:semnox_core/widgets/elements/text.dart';
import 'package:semnox_core/widgets/input_fields/properties/dropdown_field_properties.dart';

class SettingViewModel extends ChangeNotifier {
  SettingViewModel() {
    _initialize();
  }

  static final provider =
      ChangeNotifierProvider.autoDispose<SettingViewModel>((ref) {
    return SettingViewModel();
  });

  ExecutionContextDTO? _executionContext;

  SemnoxDropdownProperties<LanguageContainerDto> languageField =
      SemnoxDropdownProperties<LanguageContainerDto>(items: []);

  List<LanguageContainerDto>? languageDto;

  Future<void> _initialize() async {
    _executionContext = await ExecutionContextProvider().getExecutionContext();
    languageDto = await LanguageViewListBL(_executionContext).getLanguages();

    var languageList = languageDto;
    languageField = SemnoxDropdownProperties<LanguageContainerDto>(
        label: "Languages",
        items: languageList!
            .map((e) => DropdownMenuItem<LanguageContainerDto>(
                value: e, child: SemnoxText(text: "${e.languageName}")))
            .toList(),
        validators: [
          (data) {
            if (data == null) {
              return "Select Any Language";
            }
            return null;
          }
        ]);
    if (languageList.isNotEmpty) {
      final initial = languageList.firstWhereOrNull(
          (element) => _executionContext?.languageId == element.languageId);
      languageField.setInitialValue(initial ?? languageList.first);
    }
    notifyListeners();
  }

  ExecutionContextDTO? getExecutionContext() {
    return _executionContext;
  }

  Future<void> navigateTonetworkscreen() async {
    Modular.to.pushReplacementNamed(AppRoutes.networkConfiguartion);
  }
}
