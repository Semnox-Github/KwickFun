class GamesDTO {
  GamesDTO(
      {int? gameId,
      String? gameName,
      String? gameDescription,
      String? gameCompanyName,
      num? playCredits,
      num? vipPlayCredits,
      String? notes,
      String? lastUpdateDate,
      String? lastUpdatedBy,
      int? gameProfileId,
      int? internetKey,
      String? guid,
      int? siteId,
      num? repeatPlayDiscount,
      bool? synchStatus,
      int? userIdentifier,
      int? customDataSetId,
      int? masterEntityId,
      List<dynamic>? gameAttributes,
      int? productId,
      bool? isActive,
      String? createdBy,
      String? creationDate,
      String? gameTag,
      bool? isExternalGame,
      String? gameUrl,
      bool? isVirtualGame,
      List<dynamic>? gamePriceTierDtoList,
      bool? isChangedRecursive,
      bool? isChanged}) {
    _gameId = gameId;
    _gameName = gameName;
    _gameDescription = gameDescription;
    _gameCompanyName = gameCompanyName;
    _playCredits = playCredits;
    _vipPlayCredits = vipPlayCredits;
    _notes = notes;
    _lastUpdateDate = lastUpdateDate;
    _lastUpdatedBy = lastUpdatedBy;
    _gameProfileId = gameProfileId;
    _internetKey = internetKey;
    _guid = guid;
    _siteId = siteId;
    _repeatPlayDiscount = repeatPlayDiscount;
    _synchStatus = synchStatus;
    _userIdentifier = userIdentifier;
    _customDataSetId = customDataSetId;
    _masterEntityId = masterEntityId;
    _gameAttributes = gameAttributes;
    _productId = productId;
    _isActive = isActive;
    _createdBy = createdBy;
    _creationDate = creationDate;
    _gameTag = gameTag;
    _isExternalGame = isExternalGame;
    _gameUrl = gameUrl;
    _isVirtualGame = isVirtualGame;
    _gamePriceTierDtoList = gamePriceTierDtoList;
    _isChangedRecursive = isChangedRecursive;
    _isChanged = isChanged;
  }

  int? _gameId;
  String? _gameName;
  String? _gameDescription;
  String? _gameCompanyName;
  num? _playCredits;
  num? _vipPlayCredits;
  String? _notes;
  String? _lastUpdateDate;
  String? _lastUpdatedBy;
  int? _gameProfileId;
  int? _internetKey;
  String? _guid;
  int? _siteId;
  num? _repeatPlayDiscount;
  bool? _synchStatus;
  int? _userIdentifier;
  int? _customDataSetId;
  int? _masterEntityId;
  List<dynamic>? _gameAttributes;
  int? _productId;
  bool? _isActive;
  String? _createdBy;
  String? _creationDate;
  String? _gameTag;
  bool? _isExternalGame;
  String? _gameUrl;
  bool? _isVirtualGame;
  List<dynamic>? _gamePriceTierDtoList;
  bool? _isChangedRecursive;
  bool? _isChanged;

  int? get gameId => _gameId;
  String? get gameName => _gameName;
  String? get gameDescription => _gameDescription;
  String? get gameCompanyName => _gameCompanyName;
  num? get playCredits => _playCredits;
  num? get vipPlayCredits => _vipPlayCredits;
  String? get notes => _notes;
  String? get lastUpdateDate => _lastUpdateDate;
  String? get lastUpdatedBy => _lastUpdatedBy;
  int? get gameProfileId => _gameProfileId;
  int? get internetKey => _internetKey;
  String? get guid => _guid;
  int? get siteId => _siteId;
  num? get repeatPlayDiscount => _repeatPlayDiscount;
  bool? get synchStatus => _synchStatus;
  int? get userIdentifier => _userIdentifier;
  int? get customDataSetId => _customDataSetId;
  int? get masterEntityId => _masterEntityId;
  List<dynamic>? get gameAttributes => _gameAttributes;
  int? get productId => _productId;
  bool? get isActive => _isActive;
  String? get createdBy => _createdBy;
  String? get creationDate => _creationDate;
  String? get gameTag => _gameTag;
  bool? get isExternalGame => _isExternalGame;
  String? get gameUrl => _gameUrl;
  bool? get isVirtualGame => _isVirtualGame;
  List<dynamic>? get gamePriceTierDtoList => _gamePriceTierDtoList;
  bool? get isChangedRecursive => _isChangedRecursive;
  bool? get isChanged => _isChanged;

  factory GamesDTO.fromJson(Map<String, dynamic> json) => GamesDTO(
        gameId: json["GameId"] == null ? null : json["GameId"],
        gameName: json["GameName"] == null ? null : json["GameName"],
        gameDescription:
            json["GameDescription"] == null ? null : json["GameDescription"],
        gameCompanyName:
            json["GameCompanyName"] == null ? null : json["GameCompanyName"],
        playCredits: json["PlayCredits"] == null ? null : json["PlayCredits"],
        vipPlayCredits:
            json["VipPlayCredits"] == null ? null : json["VipPlayCredits"],
        notes: json["Notes"] == null ? null : json["Notes"],
        lastUpdateDate:
            json["LastUpdateDate"] == null ? null : json["LastUpdateDate"],
        lastUpdatedBy:
            json["LastUpdatedBy"] == null ? null : json["LastUpdatedBy"],
        gameProfileId:
            json["GameProfileId"] == null ? null : json["GameProfileId"],
        internetKey: json["InternetKey"] == null ? null : json["InternetKey"],
        guid: json["Guid"] == null ? null : json["Guid"],
        siteId: json["SiteId"] == null ? null : json["SiteId"],
        repeatPlayDiscount: json["RepeatPlayDiscount"] == null
            ? null
            : json["RepeatPlayDiscount"],
        synchStatus: json["SynchStatus"] == null ? null : json["SynchStatus"],
        userIdentifier:
            json["UserIdentifier"] == null ? null : json["UserIdentifier"],
        customDataSetId:
            json["CustomDataSetId"] == null ? null : json["CustomDataSetId"],
        masterEntityId:
            json["MasterEntityId"] == null ? null : json["MasterEntityId"],
        gameAttributes: json["GameAttributes"] == null
            ? []
            : List<dynamic>.from(json["GameAttributes"]!.map((x) => x)),
        productId: json["ProductId"] == null ? null : json["ProductId"],
        isActive: json["IsActive"] == null ? null : json["IsActive"],
        createdBy: json["CreatedBy"] == null ? null : json["CreatedBy"],
        creationDate:
            json["CreationDate"] == null ? null : json["CreationDate"],
        gameTag: json["GameTag"] == null ? null : json["GameTag"],
        isExternalGame:
            json["IsExternalGame"] == null ? null : json["IsExternalGame"],
        gameUrl: json["GameURL"] == null ? null : json["GameURL"],
        isVirtualGame:
            json["IsVirtualGame"] == null ? null : json["IsVirtualGame"],
        gamePriceTierDtoList: json["GamePriceTierDTOList"] == null
            ? []
            : List<dynamic>.from(json["GamePriceTierDTOList"]!.map((x) => x)),
        isChangedRecursive: json["IsChangedRecursive"] == null
            ? null
            : json["IsChangedRecursive"],
        isChanged: json["IsChanged"] == null ? null : json["IsChanged"],
      );

  Map<String, dynamic> toJson() => {
        "GameId": gameId == null ? null : gameId,
        "GameName": gameName == null ? null : gameName,
        "GameDescription": gameDescription == null ? null : gameDescription,
        "GameCompanyName": gameCompanyName == null ? null : gameCompanyName,
        "PlayCredits": playCredits == null ? null : playCredits,
        "VipPlayCredits": vipPlayCredits == null ? null : vipPlayCredits,
        "Notes": notes == null ? null : notes,
        "LastUpdateDate": lastUpdateDate == null ? null : lastUpdateDate,
        "LastUpdatedBy": lastUpdatedBy == null ? null : lastUpdatedBy,
        "GameProfileId": gameProfileId == null ? null : gameProfileId,
        "InternetKey": internetKey == null ? null : internetKey,
        "Guid": guid == null ? null : guid,
        "SiteId": siteId == null ? null : siteId,
        "RepeatPlayDiscount":
            repeatPlayDiscount == null ? null : repeatPlayDiscount,
        "SynchStatus": synchStatus == null ? null : synchStatus,
        "UserIdentifier": userIdentifier == null ? null : userIdentifier,
        "CustomDataSetId": customDataSetId == null ? null : customDataSetId,
        "MasterEntityId": masterEntityId == null ? null : masterEntityId,
        "GameAttributes": gameAttributes == null
            ? []
            : List<dynamic>.from(gameAttributes!.map((x) => x)),
        "ProductId": productId == null ? null : productId,
        "IsActive": isActive == null ? null : isActive,
        "CreatedBy": createdBy == null ? null : createdBy,
        "CreationDate": creationDate == null ? null : creationDate,
        "GameTag": gameTag == null ? null : gameTag,
        "IsExternalGame": isExternalGame == null ? null : isExternalGame,
        "GameURL": gameUrl == null ? null : gameUrl,
        "IsVirtualGame": isVirtualGame == null ? null : isVirtualGame,
        "GamePriceTierDTOList": gamePriceTierDtoList == null
            ? []
            : List<dynamic>.from(gamePriceTierDtoList!.map((x) => x)),
        "IsChangedRecursive":
            isChangedRecursive == null ? null : isChangedRecursive,
        "IsChanged": isChanged == null ? null : isChanged,
      };
}

enum GameFilterParams { isActive, gameId, gameProfileId, loadAttributes }
