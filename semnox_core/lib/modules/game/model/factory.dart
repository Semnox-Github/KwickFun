import 'package:flutter/foundation.dart';
import 'package:semnox_core/modules/game/model/game_machine_dto.dart';
import 'model.dart';

class GameMachineListFactory {
  static Future<List<GameMachine>?> getMachinesAsync(List<GameMachineDto> dtos) {
    return compute(_generate, dtos);
  }

  final List<GameMachineDto> dtos;

  GameMachineListFactory(this.dtos);

  List<GameMachine>? convert() {
    List<GameMachine>? machines = [];
    for (var item in dtos) {
      machines.add(GameMachine.fromDto(item));
    }
    return machines;
  }
}

List<GameMachine>? _generate(List<GameMachineDto> dtos) {
  return GameMachineListFactory(dtos).convert();
}
