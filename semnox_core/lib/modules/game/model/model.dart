import 'dart:convert';

import 'package:semnox_core/modules/game/model/game_machine_dto.dart';

class GameMachine {
  final int machineId;
  final String machineName;
  final String machineAddress;
  final int? gameId;
  final String ticketMode;
  final String ticketAllowed;
  final String gameName;
  final num purchasePrice;
  final num vipPrice;
  GameMachine({
    required this.machineId,
    required this.machineName,
    required this.machineAddress,
    required this.gameId,
    required this.ticketMode,
    required this.ticketAllowed,
    required this.gameName,
    required this.purchasePrice,
    required this.vipPrice,
  });

  GameMachine copyWith({
    int? machineId,
    String? machineName,
    String? machineAddress,
    int? gameId,
    String? ticketMode,
    String? ticketAllowed,
    String? gameName,
    num? purchasePrice,
    num? vipPrice,
  }) {
    return GameMachine(
      machineId: machineId ?? this.machineId,
      machineName: machineName ?? this.machineName,
      machineAddress: machineAddress ?? this.machineAddress,
      gameId: gameId ?? this.gameId,
      ticketMode: ticketMode ?? this.ticketMode,
      ticketAllowed: ticketAllowed ?? this.ticketAllowed,
      gameName: gameName ?? this.gameName,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      vipPrice: vipPrice ?? this.vipPrice,
    );
  }

  factory GameMachine.fromDto(GameMachineDto dto) {
    return GameMachine(
      machineId: dto.machineId?.toInt() ?? -1,
      machineName: dto.machineName ?? '',
      machineAddress: dto.machineAddress ?? '',
      gameId: dto.gameId,
      ticketMode: dto.ticketMode ?? '',
      ticketAllowed: dto.ticketAllowed ?? '',
      gameName: dto.gameName ?? "",
      purchasePrice: dto.purchasePrice ?? -1,
      vipPrice: dto.vipPrice ?? -1,
    );
  }

  @override
  String toString() {
    return 'GameMachine(machineId: $machineId, machineName: $machineName, machineAddress: $machineAddress,gameId: $gameId, ticketMode: $ticketMode, ticketAllowed: $ticketAllowed, gameName: $gameName, purchasePrice: $purchasePrice, vipPrice: $vipPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GameMachine &&
        other.machineId == machineId &&
        other.machineName == machineName &&
        other.machineAddress == machineAddress &&
        other.gameId == gameId &&
        other.ticketMode == ticketMode &&
        other.ticketAllowed == ticketAllowed &&
        other.gameName == gameName &&
        other.purchasePrice == purchasePrice &&
        other.vipPrice == vipPrice;
  }

  @override
  int get hashCode {
    return machineId.hashCode ^
        machineName.hashCode ^
        machineAddress.hashCode ^
        gameId.hashCode ^
        ticketMode.hashCode ^
        ticketAllowed.hashCode ^
        gameName.hashCode ^
        purchasePrice.hashCode ^
        vipPrice.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'machineId': machineId,
      'machineName': machineName,
      'machineAddress': machineAddress,
      'gameId': gameId,
      'ticketMode': ticketMode,
      'ticketAllowed': ticketAllowed,
      'gameName': gameName,
      'purchasePrice': purchasePrice,
      'vipPrice': vipPrice,
    };
  }

  factory GameMachine.fromMap(Map<String, dynamic> map) {
    return GameMachine(
      machineId: map['machineId']?.toInt() ?? 0,
      machineName: map['machineName'] ?? '',
      machineAddress: map['machineAddress'] ?? '',
      gameId: map['gameId']?.toInt() ?? 0,
      ticketMode: map['ticketMode'] ?? '',
      ticketAllowed: map['ticketAllowed'] ?? '',
      gameName: map['gameName'] ?? '',
      purchasePrice: map['purchasePrice'] ?? 0,
      vipPrice: map['vipPrice'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GameMachine.fromJson(String source) =>
      GameMachine.fromMap(json.decode(source));
}

enum GameMachineFilterParams {
  siteId,
  machineId,
}
