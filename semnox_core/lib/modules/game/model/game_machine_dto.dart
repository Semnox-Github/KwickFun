// To parse this JSON data, do
//
//     final gameMachineDto = gameMachineDtoFromMap(jsonString);

import 'dart:convert';

class GameMachineDto {
    GameMachineDto({
        this.machineId,
        this.machineName,
        this.machineAddress,
        this.gameId,
        this.masterId,
        this.notes,
        this.lastUpdateDate,
        this.lastUpdatedBy,
        this.ticketAllowed,
        this.isActive,
        this.creationDate,
        this.createdBy,
        this.timerMachine,
        this.timerInterval,
        this.groupTimer,
        this.numberOfCoins,
        this.ticketMode,
        this.customDataSetId,
        this.themeId,
        this.themeNumber,
        this.showAd,
        this.guid,
        this.siteId,
        this.ipAddress,
        this.tcpPort,
        this.macAddress,
        this.description,
        this.serialNumber,
        this.machineTag,
        this.softwareVersion,
        this.synchStatus,
        this.purchasePrice,
        this.readerType,
        this.payoutCost,
        this.inventoryLocationId,
        this.referenceMachineId,
        this.masterEntityId,
        this.externalMachineReference,
        this.communicationSuccessRatio,
        this.activeDisplayThemeId,
        this.previousMachineId,
        this.nextMachineId,
        this.gameMachineAttributes,
        this.machineCommunicationLogDto,
        this.machineNameGameName,
        this.gameName,
        this.hubName,
        this.communicationSuccessRate,
        this.vipPrice,
        this.machineCharacteristics,
        this.attribute1,
        this.attribute2,
        this.attribute3,
        this.qrPlayIdentifier,
        this.eraseQrPlayIdentifier,
        this.machineNameGameNameHubName,
        this.machineNameHubName,
        this.machineInputDevicesDtoList,
        this.machineTransferLogDtoList,
        this.machineArrivalDate,
        this.isChanged,
        this.isChangedRecursive,
    });

    final int? machineId;
    final String? machineName;
    final String? machineAddress;
    final int? gameId;
    final num? masterId;
    final String? notes;
    final DateTime? lastUpdateDate;
    final String? lastUpdatedBy;
    final String? ticketAllowed;
    final String? isActive;
    final DateTime? creationDate;
    final String? createdBy;
    final String? timerMachine;
    final num? timerInterval;
    final String? groupTimer;
    final num? numberOfCoins;
    final String? ticketMode;
    final num? customDataSetId;
    final num? themeId;
    final num? themeNumber;
    final String? showAd;
    final String? guid;
    final num? siteId;
    final String? ipAddress;
    final num? tcpPort;
    final String? macAddress;
    final String? description;
    final String? serialNumber;
    final String? machineTag;
    final String? softwareVersion;
    final bool? synchStatus;
    final num? purchasePrice;
    final num? readerType;
    final num? payoutCost;
    final num? inventoryLocationId;
    final num? referenceMachineId;
    final num? masterEntityId;
    final String? externalMachineReference;
    final num? communicationSuccessRatio;
    final num? activeDisplayThemeId;
    final num? previousMachineId;
    final num? nextMachineId;
    final List<dynamic>? gameMachineAttributes;
    final dynamic machineCommunicationLogDto;
    final String? machineNameGameName;
    final String? gameName;
    final String? hubName;
    final num? communicationSuccessRate;
    final dynamic vipPrice;
    final String? machineCharacteristics;
    final String? attribute1;
    final String? attribute2;
    final String? attribute3;
    final String? qrPlayIdentifier;
    final bool? eraseQrPlayIdentifier;
    final String? machineNameGameNameHubName;
    final String? machineNameHubName;
    final List<dynamic>? machineInputDevicesDtoList;
    final List<dynamic>? machineTransferLogDtoList;
    final DateTime? machineArrivalDate;
    final bool? isChanged;
    final bool? isChangedRecursive;

    factory GameMachineDto.fromJson(String str) => GameMachineDto.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GameMachineDto.fromMap(Map<String, dynamic> json) => GameMachineDto(
        machineId: json["MachineId"] == null ? null : json["MachineId"],
        machineName: json["MachineName"] == null ? null : json["MachineName"],
        machineAddress: json["MachineAddress"] == null ? null : json["MachineAddress"],
        gameId: json["GameId"] == null ? null : json["GameId"],
        masterId: json["MasterId"] == null ? null : json["MasterId"],
        notes: json["Notes"] == null ? null : json["Notes"],
        lastUpdateDate: json["LastUpdateDate"] == null ? null : DateTime.parse(json["LastUpdateDate"]),
        lastUpdatedBy: json["LastUpdatedBy"] == null ? null : json["LastUpdatedBy"],
        ticketAllowed: json["TicketAllowed"] == null ? null : json["TicketAllowed"],
        isActive: json["IsActive"] == null ? null : json["IsActive"],
        creationDate: json["CreationDate"] == null ? null : DateTime.parse(json["CreationDate"]),
        createdBy: json["CreatedBy"] == null ? null : json["CreatedBy"],
        timerMachine: json["TimerMachine"] == null ? null : json["TimerMachine"],
        timerInterval: json["TimerInterval"] == null ? null : json["TimerInterval"],
        groupTimer: json["GroupTimer"] == null ? null : json["GroupTimer"],
        numberOfCoins: json["NumberOfCoins"] == null ? null : json["NumberOfCoins"],
        ticketMode: json["TicketMode"] == null ? null : json["TicketMode"],
        customDataSetId: json["CustomDataSetId"] == null ? null : json["CustomDataSetId"],
        themeId: json["ThemeId"] == null ? null : json["ThemeId"],
        themeNumber: json["ThemeNumber"] == null ? null : json["ThemeNumber"],
        showAd: json["ShowAd"] == null ? null : json["ShowAd"],
        guid: json["Guid"] == null ? null : json["Guid"],
        siteId: json["SiteId"] == null ? null : json["SiteId"],
        ipAddress: json["IPAddress"] == null ? null : json["IPAddress"],
        tcpPort: json["TCPPort"] == null ? null : json["TCPPort"],
        macAddress: json["MacAddress"] == null ? null : json["MacAddress"],
        description: json["Description"] == null ? null : json["Description"],
        serialNumber: json["SerialNumber"] == null ? null : json["SerialNumber"],
        machineTag: json["MachineTag"] == null ? null : json["MachineTag"],
        softwareVersion: json["SoftwareVersion"] == null ? null : json["SoftwareVersion"],
        synchStatus: json["SynchStatus"] == null ? null : json["SynchStatus"],
        purchasePrice: json["PurchasePrice"] == null ? null : json["PurchasePrice"],
        readerType: json["ReaderType"] == null ? null : json["ReaderType"],
        payoutCost: json["PayoutCost"] == null ? null : json["PayoutCost"],
        inventoryLocationId: json["InventoryLocationId"] == null ? null : json["InventoryLocationId"],
        referenceMachineId: json["ReferenceMachineId"] == null ? null : json["ReferenceMachineId"],
        masterEntityId: json["MasterEntityId"] == null ? null : json["MasterEntityId"],
        externalMachineReference: json["ExternalMachineReference"] == null ? null : json["ExternalMachineReference"],
        communicationSuccessRatio: json["CommunicationSuccessRatio"] == null ? null : json["CommunicationSuccessRatio"],
        activeDisplayThemeId: json["ActiveDisplayThemeId"] == null ? null : json["ActiveDisplayThemeId"],
        previousMachineId: json["PreviousMachineId"] == null ? null : json["PreviousMachineId"],
        nextMachineId: json["NextMachineId"] == null ? null : json["NextMachineId"],
        gameMachineAttributes: json["GameMachineAttributes"] == null ? null : List<dynamic>.from(json["GameMachineAttributes"].map((x) => x)),
        machineCommunicationLogDto: json["MachineCommunicationLogDTO"],
        machineNameGameName: json["MachineNameGameName"] == null ? null : json["MachineNameGameName"],
        gameName: json["GameName"] == null ? null : json["GameName"],
        hubName: json["HubName"] == null ? null : json["HubName"],
        communicationSuccessRate: json["CommunicationSuccessRate"] == null ? null : json["CommunicationSuccessRate"],
        vipPrice: json["VipPrice"],
        machineCharacteristics: json["MachineCharacteristics"] == null ? null : json["MachineCharacteristics"],
        attribute1: json["Attribute1"] == null ? null : json["Attribute1"],
        attribute2: json["Attribute2"] == null ? null : json["Attribute2"],
        attribute3: json["Attribute3"] == null ? null : json["Attribute3"],
        qrPlayIdentifier: json["QRPlayIdentifier"] == null ? null : json["QRPlayIdentifier"],
        eraseQrPlayIdentifier: json["EraseQRPlayIdentifier"] == null ? null : json["EraseQRPlayIdentifier"],
        machineNameGameNameHubName: json["MachineNameGameNameHubName"] == null ? null : json["MachineNameGameNameHubName"],
        machineNameHubName: json["MachineNameHubName"] == null ? null : json["MachineNameHubName"],
        machineInputDevicesDtoList: json["MachineInputDevicesDTOList"] == null ? null : List<dynamic>.from(json["MachineInputDevicesDTOList"].map((x) => x)),
        machineTransferLogDtoList: json["MachineTransferLogDTOList"] == null ? null : List<dynamic>.from(json["MachineTransferLogDTOList"].map((x) => x)),
        machineArrivalDate: json["MachineArrivalDate"] == null ? null : DateTime.parse(json["MachineArrivalDate"]),
        isChanged: json["IsChanged"] == null ? null : json["IsChanged"],
        isChangedRecursive: json["IsChangedRecursive"] == null ? null : json["IsChangedRecursive"],
    );

    Map<String, dynamic> toMap() => {
        "MachineId": machineId == null ? null : machineId,
        "MachineName": machineName == null ? null : machineName,
        "MachineAddress": machineAddress == null ? null : machineAddress,
        "GameId": gameId == null ? null : gameId,
        "MasterId": masterId == null ? null : masterId,
        "Notes": notes == null ? null : notes,
        "LastUpdateDate": lastUpdateDate == null ? null : lastUpdateDate!.toIso8601String(),
        "LastUpdatedBy": lastUpdatedBy == null ? null : lastUpdatedBy,
        "TicketAllowed": ticketAllowed == null ? null : ticketAllowed,
        "IsActive": isActive == null ? null : isActive,
        "CreationDate": creationDate == null ? null : creationDate!.toIso8601String(),
        "CreatedBy": createdBy == null ? null : createdBy,
        "TimerMachine": timerMachine == null ? null : timerMachine,
        "TimerInterval": timerInterval == null ? null : timerInterval,
        "GroupTimer": groupTimer == null ? null : groupTimer,
        "NumberOfCoins": numberOfCoins == null ? null : numberOfCoins,
        "TicketMode": ticketMode == null ? null : ticketMode,
        "CustomDataSetId": customDataSetId == null ? null : customDataSetId,
        "ThemeId": themeId == null ? null : themeId,
        "ThemeNumber": themeNumber == null ? null : themeNumber,
        "ShowAd": showAd == null ? null : showAd,
        "Guid": guid == null ? null : guid,
        "SiteId": siteId == null ? null : siteId,
        "IPAddress": ipAddress == null ? null : ipAddress,
        "TCPPort": tcpPort == null ? null : tcpPort,
        "MacAddress": macAddress == null ? null : macAddress,
        "Description": description == null ? null : description,
        "SerialNumber": serialNumber == null ? null : serialNumber,
        "MachineTag": machineTag == null ? null : machineTag,
        "SoftwareVersion": softwareVersion == null ? null : softwareVersion,
        "SynchStatus": synchStatus == null ? null : synchStatus,
        "PurchasePrice": purchasePrice == null ? null : purchasePrice,
        "ReaderType": readerType == null ? null : readerType,
        "PayoutCost": payoutCost == null ? null : payoutCost,
        "InventoryLocationId": inventoryLocationId == null ? null : inventoryLocationId,
        "ReferenceMachineId": referenceMachineId == null ? null : referenceMachineId,
        "MasterEntityId": masterEntityId == null ? null : masterEntityId,
        "ExternalMachineReference": externalMachineReference == null ? null : externalMachineReference,
        "CommunicationSuccessRatio": communicationSuccessRatio == null ? null : communicationSuccessRatio,
        "ActiveDisplayThemeId": activeDisplayThemeId == null ? null : activeDisplayThemeId,
        "PreviousMachineId": previousMachineId == null ? null : previousMachineId,
        "NextMachineId": nextMachineId == null ? null : nextMachineId,
        "GameMachineAttributes": gameMachineAttributes == null ? null : List<dynamic>.from(gameMachineAttributes!.map((x) => x)),
        "MachineCommunicationLogDTO": machineCommunicationLogDto,
        "MachineNameGameName": machineNameGameName == null ? null : machineNameGameName,
        "GameName": gameName == null ? null : gameName,
        "HubName": hubName == null ? null : hubName,
        "CommunicationSuccessRate": communicationSuccessRate == null ? null : communicationSuccessRate,
        "VipPrice": vipPrice,
        "MachineCharacteristics": machineCharacteristics == null ? null : machineCharacteristics,
        "Attribute1": attribute1 == null ? null : attribute1,
        "Attribute2": attribute2 == null ? null : attribute2,
        "Attribute3": attribute3 == null ? null : attribute3,
        "QRPlayIdentifier": qrPlayIdentifier == null ? null : qrPlayIdentifier,
        "EraseQRPlayIdentifier": eraseQrPlayIdentifier == null ? null : eraseQrPlayIdentifier,
        "MachineNameGameNameHubName": machineNameGameNameHubName == null ? null : machineNameGameNameHubName,
        "MachineNameHubName": machineNameHubName == null ? null : machineNameHubName,
        "MachineInputDevicesDTOList": machineInputDevicesDtoList == null ? null : List<dynamic>.from(machineInputDevicesDtoList!.map((x) => x)),
        "MachineTransferLogDTOList": machineTransferLogDtoList == null ? null : List<dynamic>.from(machineTransferLogDtoList!.map((x) => x)),
        "MachineArrivalDate": machineArrivalDate == null ? null : machineArrivalDate!.toIso8601String(),
        "IsChanged": isChanged == null ? null : isChanged,
        "IsChangedRecursive": isChangedRecursive == null ? null : isChangedRecursive,
    };
}
