import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/game/model/model.dart';
import 'package:semnox_core/modules/game/repository/gamemachine_repository.dart';
import 'package:semnox_core/utils/storage_service/storage_service.dart';

class SelectedMachinesBL {
  ///
  /// Storing BL Instead of Object.
  ///
  final List<GameMachine> _gameMachines;

  static const String _activeMachinesKey = "active_game_machines";

  SelectedMachinesBL(this._gameMachines);

  static SelectedMachinesBL empty() {
    return SelectedMachinesBL([]);
  }

  static Future<SelectedMachinesBL> fromStorage(
      ExecutionContextDTO context) async {
    final String? activeMachines = LocalStorage().get(_activeMachinesKey);

    if (activeMachines?.isEmpty ?? true) return SelectedMachinesBL.empty();

    // List<String> ids = activeMachines!.split(",");

    List<int> validIds = _getStoredIds(); //[];
    // for (var item in ids) {
    //   var id = int.tryParse(item);
    //   if (id == null || id == -1) continue;
    //   validIds.add(id);
    //   // _machineRepos.add(await GameMachineBL.id(context, id));
    // }
    List<GameMachine>? machineRepos = await _getGameMachines(context, validIds);

    return SelectedMachinesBL(machineRepos!);
  }

  static List<int> _getStoredIds() {
    final String? activeMachines = LocalStorage().get(_activeMachinesKey);
    if (activeMachines?.isEmpty ?? true) return [];
    List<String> ids = activeMachines!.split(","); //"5"
    List<int> stored = [];
    for (var item in ids) {
      var id = int.tryParse(item);
      if (id == null || id == -1) continue;
      stored.add(id);
    }
    return stored;
  }

  Future<void> _store(int id) async {
    List<int> ids = _getStoredIds();
    ids.add(id);
    LocalStorage().save(_activeMachinesKey, ids.join(","));
  }

  Future<void> _remove(int id) async {
    List<int> ids = _getStoredIds();
    ids.remove(id);
    LocalStorage().save(_activeMachinesKey, ids.join(","));
  }

  Future<void> addMachineId(
      ExecutionContextDTO executionContext, int id) async {
    _store(id);
    var value = await _getGameMachine(executionContext, id);
    if (value != null) _gameMachines.add(value);
  }

  Future<void> addMachine(ExecutionContextDTO context, GameMachine machine
      //GameMachine gameMachine
      ) async {
    List<int> ids = _getStoredIds();
    if (!ids.contains(machine.machineId)) {
      _gameMachines.add(machine);
    }
  }

  Future<void> saveMachine() async {
    for (var element in _gameMachines) {
      List<int> ids = _getStoredIds();
      if (!ids.contains(element.machineId)) {
        // _gameMachines.add(element);
        await _store(element.machineId);
      }
    }
  }

  Future<void> removeMachine(
      ExecutionContextDTO context, GameMachine gameMachine) async {
    final repo = byId(gameMachine.machineId);
    if (repo != null) {
      _remove(gameMachine.machineId);
      _gameMachines.remove(repo);
    }
  }

  GameMachine? byId(int id) {
    return _gameMachines
        .map<GameMachine?>((e) => e)
        .firstWhere((element) => element?.machineId == id, orElse: () => null);
  }

  static Future<GameMachine?> _getGameMachine(
      ExecutionContextDTO executionContext, int id) async {
    return await GameMachineRepository(executionContext).getGameMachine(id);
  }

  static Future<List<GameMachine>?> _getGameMachines(
      ExecutionContextDTO executionContext, List<int> ids) async {
    return await GameMachineRepository(executionContext).getAllMachines(ids);
  }

  List<GameMachine>? get machines => _gameMachines;
}
