// To parse this JSON data, do
//
//     final gamePlayDto = gamePlayDtoFromMap(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class GamePlayDto {
  GamePlayDto({
    this.gameplayId,
    this.machineId,
    this.cardId,
    this.cardNumber,
    this.credits,
    this.courtesy,
    this.bonus,
    this.time,
    this.playDate,
    this.notes,
    this.ticketCount,
    this.ticketMode,
    this.guid,
    this.siteId,
    this.synchStatus,
    this.cardGame,
    this.cpCardBalance,
    this.cpCredits,
    this.cpBonus,
    this.cardGameId,
    this.payoutCost,
    this.masterEntityId,
    this.gamePlayInfoDtoList,
    this.lastUpdatedDate,
    this.lastUpdatedBy,
    this.promotionId,
    this.playRequestTime,
    this.createdBy,
    this.creationDate,
    this.game,
    this.machine,
    this.eTickets,
    this.manualTickets,
    this.ticketEaterTickets,
    this.mode,
    this.site,
    this.taskId,
    this.externalSystemReference,
    this.isChangedRecursive,
    this.isChanged,
  });

  final num? gameplayId;
  final num? machineId;
  final num? cardId;
  final String? cardNumber;
  final num? credits;
  final num? courtesy;
  final num? bonus;
  final num? time;
  final String? playDate;
  final String? notes;
  final num? ticketCount;
  final String? ticketMode;
  final String? guid;
  final num? siteId;
  final bool? synchStatus;
  final num? cardGame;
  final num? cpCardBalance;
  final num? cpCredits;
  final num? cpBonus;
  final num? cardGameId;
  final double? payoutCost;
  final num? masterEntityId;
  final List<dynamic>? gamePlayInfoDtoList;
  final String? lastUpdatedDate;
  final String? lastUpdatedBy;
  final num? promotionId;
  final String? playRequestTime;
  final String? createdBy;
  final String? creationDate;
  final dynamic game;
  final dynamic machine;
  final num? eTickets;
  final num? manualTickets;
  final num? ticketEaterTickets;
  final dynamic mode;
  final dynamic site;
  final num? taskId;
  final String? externalSystemReference;
  final bool? isChangedRecursive;
  final bool? isChanged;

  factory GamePlayDto.fromJson(String str) =>
      GamePlayDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GamePlayDto.fromMap(Map<String, dynamic> json) => GamePlayDto(
        gameplayId: json["GameplayId"] == null ? null : json["GameplayId"],
        machineId: json["MachineId"] == null ? null : json["MachineId"],
        cardId: json["CardId"] == null ? null : json["CardId"],
        cardNumber: json["CardNumber"] == null ? null : json["CardNumber"],
        credits: json["Credits"] == null ? null : json["Credits"],
        courtesy: json["Courtesy"] == null ? null : json["Courtesy"],
        bonus: json["Bonus"] == null ? null : json["Bonus"],
        time: json["Time"] == null ? null : json["Time"],
        playDate: json["PlayDate"] == null ? null : json["PlayDate"],
        notes: json["Notes"] == null ? null : json["Notes"],
        ticketCount: json["TicketCount"] == null ? null : json["TicketCount"],
        ticketMode: json["TicketMode"] == null ? null : json["TicketMode"],
        guid: json["Guid"] == null ? null : json["Guid"],
        siteId: json["SiteId"] == null ? null : json["SiteId"],
        synchStatus: json["SynchStatus"] == null ? null : json["SynchStatus"],
        cardGame: json["CardGame"] == null ? null : json["CardGame"],
        cpCardBalance:
            json["CPCardBalance"] == null ? null : json["CPCardBalance"],
        cpCredits: json["CPCredits"] == null ? null : json["CPCredits"],
        cpBonus: json["CPBonus"] == null ? null : json["CPBonus"],
        cardGameId: json["CardGameId"] == null ? null : json["CardGameId"],
        payoutCost:
            json["PayoutCost"] == null ? null : json["PayoutCost"].toDouble(),
        masterEntityId:
            json["MasterEntityId"] == null ? null : json["MasterEntityId"],
        gamePlayInfoDtoList: json["GamePlayInfoDTOList"] == null
            ? null
            : List<dynamic>.from(json["GamePlayInfoDTOList"].map((x) => x)),
        lastUpdatedDate:
            json["LastUpdatedDate"] == null ? null : json["LastUpdatedDate"],
        lastUpdatedBy:
            json["LastUpdatedBy"] == null ? null : json["LastUpdatedBy"],
        promotionId: json["PromotionId"] == null ? null : json["PromotionId"],
        playRequestTime:
            json["PlayRequestTime"] == null ? null : json["PlayRequestTime"],
        createdBy: json["CreatedBy"] == null ? null : json["CreatedBy"],
        creationDate:
            json["CreationDate"] == null ? null : json["CreationDate"],
        game: json["Game"],
        machine: json["Machine"],
        eTickets: json["ETickets"] == null ? null : json["ETickets"],
        manualTickets:
            json["ManualTickets"] == null ? null : json["ManualTickets"],
        ticketEaterTickets: json["TicketEaterTickets"] == null
            ? null
            : json["TicketEaterTickets"],
        mode: json["Mode"],
        site: json["Site"],
        taskId: json["TaskId"] == null ? null : json["TaskId"],
        externalSystemReference: json["ExternalSystemReference"] == null
            ? null
            : json["ExternalSystemReference"],
        isChangedRecursive: json["IsChangedRecursive"] == null
            ? null
            : json["IsChangedRecursive"],
        isChanged: json["IsChanged"] == null ? null : json["IsChanged"],
      );

  Map<String, dynamic> toMap() => {
        "GameplayId": gameplayId == null ? null : gameplayId,
        "MachineId": machineId == null ? null : machineId,
        "CardId": cardId == null ? null : cardId,
        "CardNumber": cardNumber == null ? null : cardNumber,
        "Credits": credits == null ? null : credits,
        "Courtesy": courtesy == null ? null : courtesy,
        "Bonus": bonus == null ? null : bonus,
        "Time": time == null ? null : time,
        "PlayDate": playDate == null ? null : playDate,
        "Notes": notes == null ? null : notes,
        "TicketCount": ticketCount == null ? null : ticketCount,
        "TicketMode": ticketMode == null ? null : ticketMode,
        "Guid": guid == null ? null : guid,
        "SiteId": siteId == null ? null : siteId,
        "SynchStatus": synchStatus == null ? null : synchStatus,
        "CardGame": cardGame == null ? null : cardGame,
        "CPCardBalance": cpCardBalance == null ? null : cpCardBalance,
        "CPCredits": cpCredits == null ? null : cpCredits,
        "CPBonus": cpBonus == null ? null : cpBonus,
        "CardGameId": cardGameId == null ? null : cardGameId,
        "PayoutCost": payoutCost == null ? null : payoutCost,
        "MasterEntityId": masterEntityId == null ? null : masterEntityId,
        "GamePlayInfoDTOList": gamePlayInfoDtoList == null
            ? null
            : List<dynamic>.from(gamePlayInfoDtoList!.map((x) => x)),
        "LastUpdatedDate": lastUpdatedDate == null ? null : lastUpdatedDate,
        "LastUpdatedBy": lastUpdatedBy == null ? null : lastUpdatedBy,
        "PromotionId": promotionId == null ? null : promotionId,
        "PlayRequestTime": playRequestTime == null ? null : playRequestTime,
        "CreatedBy": createdBy == null ? null : createdBy,
        "CreationDate": creationDate == null ? null : creationDate,
        "Game": game,
        "Machine": machine,
        "ETickets": eTickets == null ? null : eTickets,
        "ManualTickets": manualTickets == null ? null : manualTickets,
        "TicketEaterTickets":
            ticketEaterTickets == null ? null : ticketEaterTickets,
        "Mode": mode,
        "Site": site,
        "TaskId": taskId == null ? null : taskId,
        "ExternalSystemReference":
            externalSystemReference == null ? null : externalSystemReference,
        "IsChangedRecursive":
            isChangedRecursive == null ? null : isChangedRecursive,
        "IsChanged": isChanged == null ? null : isChanged,
      };

  // String getdatebyformat(String? playDate) {
  //   initializeDateFormatting();
  //   String outputDate =
  //       DateFormat("dd/MM/yyyy").format(DateTime.parse(playDate!));
  //   print(outputDate);

  //   return outputDate;
  // }
}

enum GamePlaysSearchParams { machineId, gamePlayId, accountId, cardNumber }
