import 'dart:async';

import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_ride/app/game_ride/provider/selected_game_machines.dart';
import 'package:game_ride/themes.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/game/bl/active_machines_bl.dart';
import 'package:semnox_core/modules/game/model/model.dart';
import 'package:semnox_core/modules/game/provider/game_data_provider.dart';
import 'package:semnox_core/utils/dataprovider/data_provider.dart';
import 'package:semnox_core/modules/game/provider/game_data_List_provider.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/widgets/input_fields/properties/text_field_properties.dart';
import 'package:semnox_core/widgets/popup/toast.dart';

class GameMachineSelectionViewModel extends ChangeNotifier {
  static final provider =
      ChangeNotifierProvider.autoDispose<GameMachineSelectionViewModel>((ref) {
    return GameMachineSelectionViewModel(
      reference: ref,
    );
  });

  ChangeNotifierProviderRef<GameMachineSelectionViewModel> reference;

  late BuildContext context;

  GameMachineSelectionViewModel({
    required this.reference,
  }) {
    _init();
  }

  ExecutionContextDTO? executionContext;

  DataProvider<List<GameMachine>?> gameMachineProvider =
      DataProvider<List<GameMachine>?>();

  late SemnoxTextFieldProperties gameField =
      SemnoxTextFieldProperties(hintText: Messages.searchgamemachine);

  GameDataProvider? gameDataProvider;
  late StreamSubscription<String> _subscription;

  final List<GameMachine>? _gameMachines = [];

  void _init() async {
    executionContext = await ExecutionContextProvider().getExecutionContext();
    var machinesListBL = await GameDataListProvider.getAll();
    if (machinesListBL!.isNotEmpty) {
      gameMachineProvider.handleFuture(GameDataListProvider.getAll());
    } else {
      gameMachineProvider.addError(Messages.failedtofetchgamemachine);
    }

    _subscription = gameField.valueChangeStream.listen((event) async {
      await _filtergameMachine(event);
    });
  }

  Future<void> _filtergameMachine(String event) async {
    gameMachineProvider.handleFuture(GameDataListProvider.search(event));
  }

  // Future<void> setActive(BuildContext context, GameMachine gameMachine) async {
  //   reference
  //       .read(SelectedGameMachinesNotifier.provider.notifier)
  //       .addToList(gameMachine);
  //   notifyListeners();
  // }

  Future<void> toggleSelection(GameMachine machine) async {
    if (isActive(machine)) {
      await reference
          .read(SelectedGameMachinesNotifier.provider.notifier)
          .removeFromList(machine);
      // _gameMachines.remove(machine);
    } else {
      await reference
          .read(SelectedGameMachinesNotifier.provider.notifier)
          .addToList(machine);

      // _gameMachines.add(machine);
    }
    notifyListeners();
  }

  Future<void> savegamemachine() async {
    var state = reference.read(SelectedGameMachinesNotifier.provider.notifier);
    if (state.machines!.isEmpty) {
      SemnoxSnackbar.error(context, "Select any one game machine");
    } else {
      SemnoxSnackbar.success("Game machine saved successfully ", context);
      await reference
          .read(SelectedGameMachinesNotifier.provider.notifier)
          .saveMachine();
    }
  }

  bool isActive(GameMachine machine) {
    return reference
        .read(SelectedGameMachinesNotifier.provider.notifier)
        .contains(machine);
    // _gameMachines.contains(machine);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
