import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_ride/routes.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/game/model/model.dart';
import 'package:semnox_core/modules/game/bl/active_machines_bl.dart';
import 'package:semnox_core/modules/hr/provider/userrole_data_provider.dart';

///
///
/// A Applevel Provider Which Provides only Selected Game Machines.
///
///

class SelectedGameMachinesNotifier extends ChangeNotifier {
  SelectedGameMachinesNotifier();
  static final provider =
      ChangeNotifierProvider<SelectedGameMachinesNotifier>((ref) {
    return SelectedGameMachinesNotifier();
  });

  SelectedMachinesBL _state = SelectedMachinesBL.empty();

  Future<void> initialize() async {
    _state = SelectedMachinesBL.empty();
    final executionContext =
        await ExecutionContextProvider().getExecutionContext();
    _state = await SelectedMachinesBL.fromStorage(executionContext!);
    notifyListeners();
  }

  Future<void> addToList(
      //GameMachine machine
      GameMachine machine) async {
    final executionContext =
        await ExecutionContextProvider().getExecutionContext();
    await _state.addMachine(executionContext!, machine);
    notifyListeners();
    // LocalStorage().save("active_game_machine", machine.machineId.toString());
  }

  Future<void> saveMachine() async {
    await _state.saveMachine();
  }

  Future<void> removeFromList(GameMachine machine) async {
    final executionContext =
        await ExecutionContextProvider().getExecutionContext();
    await _state.removeMachine(executionContext!, machine);
    notifyListeners();
    // LocalStorage().save("active_game_machine", machine.machineId.toString());
  }

  bool contains(GameMachine gameMachine) {
    return _state.byId(gameMachine.machineId) != null;
  }

  Future<void> checkusermanagerAccess(String route) async {
    var userroleDTO = UserRoleDataProvider.getuserroleDTO();
    if (userroleDTO.isNotEmpty) {
      if (userroleDTO.first.manager == true) {
        Modular.to.pushNamed(route);
      } else {
        Modular.to.pushNamed(AppRoutes.home);
      }
    } else {
      Modular.to.pushNamed(AppRoutes.home);
    }
  }

  List<GameMachine>? get machines => _state.machines;
}
