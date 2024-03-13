import 'package:collection/collection.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/game/bl/game_machines_list_bl.dart';
import 'package:semnox_core/modules/game/model/model.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';

///
///
/// BL to handle Multiple Game Machines Filterting.
///
class GameDataListProvider {
  ///
  /// pass Optional  [ids] param if only some gamemachines are required.
  ///
  static Future<GameDataListProvider> fromIds(
      ExecutionContextDTO executionContextDTO,
      [List<int>? ids]) async {
    final gameMachineListDTO =
        await GameMachinesListBL(executionContextDTO).fromIds(ids);
    if (gameMachineListDTO!.isEmpty) {
      throw AppException("No GameMachine Found");
    }
    return createFromList(executionContextDTO, gameMachineListDTO);
  }

  ///
  ///
  /// Create BL Using List of Game Machines.
  ///
  static Future<GameDataListProvider> createFromList(
      ExecutionContextDTO context, List<GameMachine>? machines) async {
    return GameDataListProvider(
        executionContextDTO: context, machineList: machines);
  }

  ///
  ///
  /// Default Constructor
  ///
  GameDataListProvider(
      {ExecutionContextDTO? executionContextDTO,
      List<GameMachine>? machineList}) {
    context = executionContextDTO;
    _allMachines = machineList;
  }

  static ExecutionContextDTO? context;
  static List<GameMachine>? _allMachines;
  static final List<GameMachine>? _searchResult = [];

  static Future<List<GameMachine>?> getAll() async {
    return _allMachines;
  }

  static Future<List<GameMachine>?> search(String gameName) async {
    _searchResult?.clear();
    if (gameName.isEmpty) {
      return _allMachines;
    }
    _allMachines?.forEach((userDetail) {
      if (userDetail.gameName.toLowerCase().contains(gameName)) {
        _searchResult?.add(userDetail);
      }
    });
    return _searchResult;
  }

  Future<GameMachine?> getMachineById(int id) async {
    return _allMachines?.firstWhereOrNull(
      (element) => element.machineId == id,
    );
  }
}
