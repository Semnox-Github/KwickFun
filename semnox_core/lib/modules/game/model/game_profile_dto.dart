class GameProfileDTO {
  GameProfileDTO({
    required this.gameProfileId,
    required this.profileName,
    required this.creditAllowed,
    required this.bonusAllowed,
    required this.courtesyAllowed,
    required this.timeAllowed,
    required this.ticketAllowedOnCredit,
    required this.ticketAllowedOnCourtesy,
    required this.ticketAllowedOnBonus,
    required this.ticketAllowedOnTime,
    required this.playCredits,
    required this.vipPlayCredits,
    required this.lastUpdateDate,
    required this.lastUpdatedBy,
    required this.internetKey,
    required this.redemptionToken,
    required this.physicalToken,
    required this.tokenPrice,
    required this.redeemTokenTo,
    required this.themeNumber,
    required this.themeId,
    required this.showAd,
    required this.isTicketEater,
    required this.guid,
    required this.siteId,
    required this.synchStatus,
    required this.userIdentifier,
    required this.customDataSetId,
    required this.masterEntityId,
    required this.profileAttributes,
    required this.isActive,
    required this.forceRedeemToCard,
    required this.creationDate,
    required this.createdBy,
    required this.tokenRedemption,
    required this.profileIdentifier,
    required this.gameDtoList,
    required this.isChanged,
    required this.isChangedRecursive,
  });

  int gameProfileId;
  String profileName;
  String creditAllowed;
  String bonusAllowed;
  String courtesyAllowed;
  String timeAllowed;
  String ticketAllowedOnCredit;
  String ticketAllowedOnCourtesy;
  String ticketAllowedOnBonus;
  String ticketAllowedOnTime;
  num? playCredits;
  num? vipPlayCredits;
  DateTime lastUpdateDate;
  String lastUpdatedBy;
  int internetKey;
  String redemptionToken;
  String physicalToken;
  double tokenPrice;
  String redeemTokenTo;
  int themeNumber;
  int themeId;
  String showAd;
  String isTicketEater;
  String guid;
  int siteId;
  bool synchStatus;
  int userIdentifier;
  int customDataSetId;
  int masterEntityId;
  List<dynamic> profileAttributes;
  bool isActive;
  bool forceRedeemToCard;
  DateTime creationDate;
  String createdBy;
  int tokenRedemption;
  String profileIdentifier;
  List<dynamic> gameDtoList;
  bool isChanged;
  bool isChangedRecursive;

  factory GameProfileDTO.fromJson(Map<String, dynamic> json) => GameProfileDTO(
        gameProfileId: json["GameProfileId"],
        profileName: json["ProfileName"],
        creditAllowed: json["CreditAllowed"],
        bonusAllowed: json["BonusAllowed"],
        courtesyAllowed: json["CourtesyAllowed"],
        timeAllowed: json["TimeAllowed"],
        ticketAllowedOnCredit: json["TicketAllowedOnCredit"],
        ticketAllowedOnCourtesy: json["TicketAllowedOnCourtesy"],
        ticketAllowedOnBonus: json["TicketAllowedOnBonus"],
        ticketAllowedOnTime: json["TicketAllowedOnTime"],
        playCredits: json["PlayCredits"],
        vipPlayCredits: json["VipPlayCredits"],
        lastUpdateDate: DateTime.parse(json["LastUpdateDate"]),
        lastUpdatedBy: json["LastUpdatedBy"],
        internetKey: json["InternetKey"],
        redemptionToken: json["RedemptionToken"],
        physicalToken: json["PhysicalToken"],
        tokenPrice: json["TokenPrice"],
        redeemTokenTo: json["RedeemTokenTo"],
        themeNumber: json["ThemeNumber"],
        themeId: json["ThemeId"],
        showAd: json["ShowAd"],
        isTicketEater: json["IsTicketEater"],
        guid: json["Guid"],
        siteId: json["SiteId"],
        synchStatus: json["SynchStatus"],
        userIdentifier: json["UserIdentifier"],
        customDataSetId: json["CustomDataSetId"],
        masterEntityId: json["MasterEntityId"],
        profileAttributes:
            List<dynamic>.from(json["ProfileAttributes"].map((x) => x)),
        isActive: json["IsActive"],
        forceRedeemToCard: json["ForceRedeemToCard"],
        creationDate: DateTime.parse(json["CreationDate"]),
        createdBy: json["CreatedBy"],
        tokenRedemption: json["TokenRedemption"],
        profileIdentifier: json["ProfileIdentifier"],
        gameDtoList: List<dynamic>.from(json["GameDTOList"].map((x) => x)),
        isChanged: json["IsChanged"],
        isChangedRecursive: json["IsChangedRecursive"],
      );

  Map<String, dynamic> toJson() => {
        "GameProfileId": gameProfileId,
        "ProfileName": profileName,
        "CreditAllowed": creditAllowed,
        "BonusAllowed": bonusAllowed,
        "CourtesyAllowed": courtesyAllowed,
        "TimeAllowed": timeAllowed,
        "TicketAllowedOnCredit": ticketAllowedOnCredit,
        "TicketAllowedOnCourtesy": ticketAllowedOnCourtesy,
        "TicketAllowedOnBonus": ticketAllowedOnBonus,
        "TicketAllowedOnTime": ticketAllowedOnTime,
        "PlayCredits": playCredits,
        "VipPlayCredits": vipPlayCredits,
        "LastUpdateDate": lastUpdateDate.toIso8601String(),
        "LastUpdatedBy": lastUpdatedBy,
        "InternetKey": internetKey,
        "RedemptionToken": redemptionToken,
        "PhysicalToken": physicalToken,
        "TokenPrice": tokenPrice,
        "RedeemTokenTo": redeemTokenTo,
        "ThemeNumber": themeNumber,
        "ThemeId": themeId,
        "ShowAd": showAd,
        "IsTicketEater": isTicketEater,
        "Guid": guid,
        "SiteId": siteId,
        "SynchStatus": synchStatus,
        "UserIdentifier": userIdentifier,
        "CustomDataSetId": customDataSetId,
        "MasterEntityId": masterEntityId,
        "ProfileAttributes":
            List<dynamic>.from(profileAttributes.map((x) => x)),
        "IsActive": isActive,
        "ForceRedeemToCard": forceRedeemToCard,
        "CreationDate": creationDate.toIso8601String(),
        "CreatedBy": createdBy,
        "TokenRedemption": tokenRedemption,
        "ProfileIdentifier": profileIdentifier,
        "GameDTOList": List<dynamic>.from(gameDtoList.map((x) => x)),
        "IsChanged": isChanged,
        "IsChangedRecursive": isChangedRecursive,
      };
}

enum GameProfileFilterParams {
  isActive,
  gameProfileId,
  gameProfileName,
  loadAttributes
}
