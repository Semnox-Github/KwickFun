class AccountSummaryViewDTO {
  AccountSummaryViewDTO(
      {int? accountId,
      String? accountNumber,
      String? issueDate,
      num? faceValue,
      bool? refundFlag,
      num? refundAmount,
      String? refundDate,
      bool? validFlag,
      int? ticketCount,
      String? notes,
      String? lastUpdatedTime,
      num? credits,
      num? courtesy,
      num? bonus,
      num? time,
      int? customerId,
      num? creditsPlayed,
      bool? ticketAllowed,
      bool? realTicketMode,
      bool? vipCustomer,
      int? siteId,
      String? startTime,
      String? lastPlayedTime,
      String? technicianCard,
      int? techGames,
      bool? timerResetCard,
      num? loyaltyPoints,
      String? lastUpdatedBy,
      int? cardTypeId,
      String? guid,
      int? uploadSiteId,
      String? uploadTime,
      bool? synchStatus,
      String? expiryDate,
      int? downloadBatchId,
      String? refreshFromHqTime,
      int? masterEntityId,
      String? accountIdentifier,
      bool? primaryCard,
      String? createdBy,
      String? creationDate,
      num? balanceTime,
      num? creditPlusCardBalance,
      num? creditPlusCredits,
      num? creditPlusItemPurchase,
      num? creditPlusBonus,
      num? creditPlusTime,
      num? creditPlusTickets,
      num? creditPlusLoyaltyPoints,
      num? creditPlusRefundableBalance,
      num? redeemableCreditPlusCreditsLoyaltyPoints,
      num? creditPlusVirtualPoints,
      int? membershipId,
      String? membershipName,
      String? customerName,
      num? gamesBalance,
      num? totalCreditsBalance,
      num? totalBonusBalance,
      num? totalTimeBalance,
      num? totalCourtesyBalance,
      num? totalLoyaltyBalance,
      num? totalTicketsBalance,
      num? totalGamesBalance,
      num? totalGamePlayCreditsBalance}) {
    _accountId = accountId;
    _accountNumber = accountNumber;
    _issueDate = issueDate;
    _faceValue = faceValue;
    _refundFlag = refundFlag;
    _refundAmount = _refundAmount;
    _refundDate = refundDate;
    _validFlag = validFlag;
    _ticketCount = ticketCount;
    _notes = notes;
    _lastUpdatedTime = lastUpdatedTime;
    _credits = credits;
    _courtesy = courtesy;
    _bonus = bonus;
    _time = time;
    _customerId = customerId;
    _creditsPlayed = creditsPlayed;
    _ticketAllowed = ticketAllowed;
    _realTicketMode = realTicketMode;
    _vipCustomer = vipCustomer;
    _siteId = siteId;
    _startTime = startTime;
    _lastPlayedTime = lastPlayedTime;
    _technicianCard = technicianCard;
    _techGames = techGames;
    _timerResetCard = timerResetCard;
    _loyaltyPoints = loyaltyPoints;
    _lastUpdatedBy = lastUpdatedBy;
    _cardTypeId = cardTypeId;
    _guid = guid;
    _uploadSiteId = uploadSiteId;
    _uploadTime = uploadTime;
    _synchStatus = synchStatus;
    _expiryDate = expiryDate;
    _downloadBatchId = downloadBatchId;
    _refreshFromHqTime = refreshFromHqTime;
    _masterEntityId = masterEntityId;
    _accountIdentifier = accountIdentifier;
    _primaryCard = primaryCard;
    _createdBy = createdBy;
    _creationDate = creationDate;
    _balanceTime = balanceTime;
    _creditPlusCardBalance = creditPlusCardBalance;
    _creditPlusCredits = creditPlusCredits;
    _creditPlusItemPurchase = creditPlusItemPurchase;
    _creditPlusBonus = creditPlusBonus;
    _creditPlusTime = creditPlusTime;
    _creditPlusTickets = creditPlusTickets;
    _creditPlusLoyaltyPoints = creditPlusLoyaltyPoints;
    _creditPlusRefundableBalance = creditPlusRefundableBalance;
    _redeemableCreditPlusCreditsLoyaltyPoints =
        redeemableCreditPlusCreditsLoyaltyPoints;
    _creditPlusVirtualPoints = creditPlusVirtualPoints;
    _membershipId = membershipId;
    _membershipName = membershipName;
    _customerName = customerName;
    _gamesBalance = gamesBalance;
    _totalCreditsBalance = totalCreditsBalance;
    _totalBonusBalance = totalBonusBalance;
    _totalTimeBalance = totalTimeBalance;
    _totalCourtesyBalance = totalCourtesyBalance;
    _totalLoyaltyBalance = totalLoyaltyBalance;
    _totalTicketsBalance = totalTicketsBalance;
    _totalGamesBalance = totalGamesBalance;
    _totalGamePlayCreditsBalance = totalGamePlayCreditsBalance;
  }

  int? _accountId;
  String? _accountNumber;
  String? _issueDate;
  num? _faceValue;
  bool? _refundFlag;
  int? _refundAmount;
  String? _refundDate;
  bool? _validFlag;
  int? _ticketCount;
  String? _notes;
  String? _lastUpdatedTime;
  num? _credits;
  num? _courtesy;
  num? _bonus;
  num? _time;
  int? _customerId;
  num? _creditsPlayed;
  bool? _ticketAllowed;
  bool? _realTicketMode;
  bool? _vipCustomer;
  int? _siteId;
  String? _startTime;
  String? _lastPlayedTime;
  String? _technicianCard;
  int? _techGames;
  bool? _timerResetCard;
  num? _loyaltyPoints;
  String? _lastUpdatedBy;
  int? _cardTypeId;
  String? _guid;
  int? _uploadSiteId;
  String? _uploadTime;
  bool? _synchStatus;
  String? _expiryDate;
  int? _downloadBatchId;
  String? _refreshFromHqTime;
  int? _masterEntityId;
  String? _accountIdentifier;
  bool? _primaryCard;
  String? _createdBy;
  String? _creationDate;
  num? _balanceTime;
  num? _creditPlusCardBalance;
  num? _creditPlusCredits;
  num? _creditPlusItemPurchase;
  num? _creditPlusBonus;
  num? _creditPlusTime;
  num? _creditPlusTickets;
  num? _creditPlusLoyaltyPoints;
  num? _creditPlusRefundableBalance;
  num? _redeemableCreditPlusCreditsLoyaltyPoints;
  num? _creditPlusVirtualPoints;
  int? _membershipId;
  String? _membershipName;
  String? _customerName;
  num? _gamesBalance;
  num? _totalCreditsBalance;
  num? _totalBonusBalance;
  num? _totalTimeBalance;
  num? _totalCourtesyBalance;
  num? _totalLoyaltyBalance;
  num? _totalTicketsBalance;
  num? _totalGamesBalance;
  num? _totalGamePlayCreditsBalance;

  int? get accountId => _accountId;
  String? get accountNumber => _accountNumber;
  String? get issueDate => _issueDate;
  num? get faceValue => _faceValue;
  bool? get refundFlag => _refundFlag;
  int? get refundAmount => _refundAmount;
  String? get refundDate => _refundDate;
  bool? get validFlag => _validFlag;
  int? get ticketCount => _ticketCount;
  String? get notes => _notes;
  String? get lastUpdatedTime => _lastUpdatedTime;
  num? get credits => _credits;
  num? get courtesy => _courtesy;
  num? get bonus => _bonus;
  num? get time => _time;
  int? get customerId => _customerId;
  num? get creditsPlayed => _creditsPlayed;
  bool? get ticketAllowed => _ticketAllowed;
  bool? get realTicketMode => _realTicketMode;
  bool? get vipCustomer => _vipCustomer;
  int? get siteId => _siteId;
  String? get startTime => _startTime;
  String? get lastPlayedTime => _lastPlayedTime;
  String? get technicianCard => _technicianCard;
  int? get techGames => _techGames;
  bool? get timerResetCard => _timerResetCard;
  num? get loyaltyPoints => _loyaltyPoints;
  String? get lastUpdatedBy => _lastUpdatedBy;
  int? get cardTypeId => _cardTypeId;
  String? get guid => _guid;
  int? get uploadSiteId => _uploadSiteId;
  String? get uploadTime => _uploadTime;
  bool? get synchStatus => _synchStatus;
  String? get expiryDate => _expiryDate;
  int? get downloadBatchId => _downloadBatchId;
  String? get refreshFromHqTime => _refreshFromHqTime;
  int? get masterEntityId => _masterEntityId;
  String? get accountIdentifier => _accountIdentifier;
  bool? get primaryCard => _primaryCard;
  String? get createdBy => _createdBy;
  String? get creationDate => _creationDate;
  num? get balanceTime => _balanceTime;
  num? get creditPlusCardBalance => _creditPlusCardBalance;
  num? get creditPlusCredits => _creditPlusCredits;
  num? get creditPlusItemPurchase => _creditPlusItemPurchase;
  num? get creditPlusBonus => _creditPlusBonus;
  num? get creditPlusTime => _creditPlusTime;
  num? get creditPlusTickets => _creditPlusTickets;
  num? get creditPlusLoyaltyPoints => _creditPlusLoyaltyPoints;
  num? get creditPlusRefundableBalance => _creditPlusRefundableBalance;
  num? get redeemableCreditPlusCreditsLoyaltyPoints =>
      _redeemableCreditPlusCreditsLoyaltyPoints;
  num? get creditPlusVirtualPoints => _creditPlusVirtualPoints;
  int? get membershipId => _membershipId;
  String? get membershipName => _membershipName;
  String? get customerName => _customerName;
  num? get gamesBalance => _gamesBalance;
  num? get totalCreditsBalance => _totalCreditsBalance;
  num? get totalBonusBalance => _totalBonusBalance;
  num? get totalTimeBalance => _totalTimeBalance;
  num? get totalCourtesyBalance => _totalCourtesyBalance;
  num? get totalLoyaltyBalance => _totalLoyaltyBalance;
  num? get totalTicketsBalance => _totalTicketsBalance;
  num? get totalGamesBalance => _totalGamesBalance;
  num? get totalGamePlayCreditsBalance => _totalGamePlayCreditsBalance;

  factory AccountSummaryViewDTO.fromJson(Map<String, dynamic> json) =>
      AccountSummaryViewDTO(
        accountId: json["AccountId"] == null ? null : json["AccountId"],
        accountNumber:
            json["AccountNumber"] == null ? null : json["AccountNumber"],
        issueDate: json["IssueDate"] == null ? null : json["IssueDate"],
        faceValue: json["FaceValue"] == null ? null : json["FaceValue"],
        refundFlag: json["RefundFlag"] == null ? null : json["RefundFlag"],
        refundAmount:
            json["RefundAmount"] == null ? null : json["RefundAmount"],
        refundDate: json["RefundDate"] == null ? null : json["RefundDate"],
        validFlag: json["ValidFlag"] == null ? null : json["ValidFlag"],
        ticketCount: json["TicketCount"] == null ? null : json["TicketCount"],
        notes: json["Notes"] == null ? null : json["Notes"],
        lastUpdatedTime:
            json["LastUpdatedTime"] == null ? null : json["LastUpdatedTime"],
        credits: json["Credits"] == null ? null : json["Credits"],
        courtesy: json["Courtesy"] == null ? null : json["Courtesy"],
        bonus: json["Bonus"] == null ? null : json["Bonus"],
        time: json["Time"] == null ? null : json["Time"],
        customerId: json["CustomerId"] == null ? null : json["CustomerId"],
        creditsPlayed:
            json["CreditsPlayed"] == null ? null : json["CreditsPlayed"],
        ticketAllowed:
            json["TicketAllowed"] == null ? null : json["TicketAllowed"],
        realTicketMode:
            json["RealTicketMode"] == null ? null : json["RealTicketMode"],
        vipCustomer: json["VipCustomer"] == null ? null : json["VipCustomer"],
        siteId: json["SiteId"] == null ? null : json["SiteId"],
        startTime: json["StartTime"] == null ? null : json["StartTime"],
        lastPlayedTime:
            json["LastPlayedTime"] == null ? null : json["LastPlayedTime"],
        technicianCard:
            json["TechnicianCard"] == null ? null : json["TechnicianCard"],
        techGames: json["TechGames"] == null ? null : json["TechGames"],
        timerResetCard:
            json["TimerResetCard"] == null ? null : json["TimerResetCard"],
        loyaltyPoints:
            json["LoyaltyPoints"] == null ? null : json["LoyaltyPoints"],
        lastUpdatedBy:
            json["LastUpdatedBy"] == null ? null : json["LastUpdatedBy"],
        cardTypeId: json["CardTypeId"] == null ? null : json["CardTypeId"],
        guid: json["Guid"] == null ? null : json["Guid"],
        uploadSiteId:
            json["UploadSiteId"] == null ? null : json["UploadSiteId"],
        uploadTime: json["UploadTime"] == null ? null : json["UploadTime"],
        synchStatus: json["SynchStatus"] == null ? null : json["SynchStatus"],
        expiryDate: json["ExpiryDate"] == null ? null : json["ExpiryDate"],
        downloadBatchId:
            json["DownloadBatchId"] == null ? null : json["DownloadBatchId"],
        refreshFromHqTime: json["RefreshFromHqTime"] == null
            ? null
            : json["RefreshFromHqTime"],
        masterEntityId:
            json["MasterEntityId"] == null ? null : json["MasterEntityId"],
        accountIdentifier: json["AccountIdentifier"] == null
            ? null
            : json["AccountIdentifier"],
        primaryCard: json["PrimaryCard"] == null ? null : json["PrimaryCard"],
        createdBy: json["CreatedBy"] == null ? null : json["CreatedBy"],
        creationDate:
            json["CreationDate"] == null ? null : json["CreationDate"],
        balanceTime: json["BalanceTime"] == null ? null : json["BalanceTime"],
        creditPlusCardBalance: json["CreditPlusCardBalance"] == null
            ? null
            : json["CreditPlusCardBalance"],
        creditPlusCredits: json["CreditPlusCredits"] == null
            ? null
            : json["CreditPlusCredits"],
        creditPlusItemPurchase: json["CreditPlusItemPurchase"] == null
            ? null
            : json["CreditPlusItemPurchase"],
        creditPlusBonus:
            json["CreditPlusBonus"] == null ? null : json["CreditPlusBonus"],
        creditPlusTime:
            json["CreditPlusTime"] == null ? null : json["CreditPlusTime"],
        creditPlusTickets: json["CreditPlusTickets"] == null
            ? null
            : json["CreditPlusTickets"],
        creditPlusLoyaltyPoints: json["CreditPlusLoyaltyPoints"] == null
            ? null
            : json["CreditPlusLoyaltyPoints"],
        creditPlusRefundableBalance: json["CreditPlusRefundableBalance"] == null
            ? null
            : json["CreditPlusRefundableBalance"],
        redeemableCreditPlusCreditsLoyaltyPoints:
            json["RedeemableCreditPlusCreditsLoyaltyPoints"] == null
                ? null
                : json["RedeemableCreditPlusCreditsLoyaltyPoints"],
        creditPlusVirtualPoints: json["CreditPlusVirtualPoints"] == null
            ? null
            : json["CreditPlusVirtualPoints"],
        membershipId:
            json["MembershipId"] == null ? null : json["MembershipId"],
        membershipName:
            json["MembershipName"] == null ? null : json["MembershipName"],
        customerName:
            json["CustomerName"] == null ? null : json["CustomerName"],
        gamesBalance:
            json["GamesBalance"] == null ? null : json["GamesBalance"],
        totalCreditsBalance: json["TotalCreditsBalance"] == null
            ? null
            : json["TotalCreditsBalance"],
        totalBonusBalance: json["TotalBonusBalance"] == null
            ? null
            : json["TotalBonusBalance"],
        totalTimeBalance:
            json["TotalTimeBalance"] == null ? null : json["TotalTimeBalance"],
        totalCourtesyBalance: json["TotalCourtesyBalance"] == null
            ? null
            : json["TotalCourtesyBalance"],
        totalLoyaltyBalance: json["TotalLoyaltyBalance"] == null
            ? null
            : json["TotalLoyaltyBalance"],
        totalTicketsBalance: json["TotalTicketsBalance"] == null
            ? null
            : json["TotalTicketsBalance"],
        totalGamesBalance: json["TotalGamesBalance"] == null
            ? null
            : json["TotalGamesBalance"],
        totalGamePlayCreditsBalance: json["TotalGamePlayCreditsBalance"] == null
            ? null
            : json["TotalGamePlayCreditsBalance"],
      );

  Map<String, dynamic> toJson() => {
        "AccountId": accountId == null ? null : accountId,
        "AccountNumber": accountNumber == null ? null : accountNumber,
        "IssueDate": issueDate == null ? null : issueDate,
        "FaceValue": faceValue == null ? null : faceValue,
        "RefundFlag": refundFlag == null ? null : refundFlag,
        "RefundAmount": refundAmount == null ? null : refundAmount,
        "RefundDate": refundDate == null ? null : refundDate,
        "ValidFlag": validFlag == null ? null : validFlag,
        "TicketCount": ticketCount == null ? null : ticketCount,
        "Notes": notes == null ? null : notes,
        "LastUpdatedTime": lastUpdatedTime == null ? null : lastUpdatedTime,
        "Credits": credits == null ? null : credits,
        "Courtesy": courtesy == null ? null : courtesy,
        "Bonus": bonus == null ? null : bonus,
        "Time": time == null ? null : time,
        "CustomerId": customerId == null ? null : customerId,
        "CreditsPlayed": creditsPlayed == null ? null : creditsPlayed,
        "TicketAllowed": ticketAllowed == null ? null : ticketAllowed,
        "RealTicketMode": realTicketMode == null ? null : realTicketMode,
        "VipCustomer": vipCustomer == null ? null : vipCustomer,
        "SiteId": siteId == null ? null : siteId,
        "StartTime": startTime == null ? null : startTime,
        "LastPlayedTime": lastPlayedTime == null ? null : lastPlayedTime,
        "TechnicianCard": technicianCard == null ? null : technicianCard,
        "TechGames": techGames == null ? null : techGames,
        "TimerResetCard": timerResetCard == null ? null : timerResetCard,
        "LoyaltyPoints": loyaltyPoints == null ? null : loyaltyPoints,
        "LastUpdatedBy": lastUpdatedBy == null ? null : lastUpdatedBy,
        "CardTypeId": cardTypeId == null ? null : cardTypeId,
        "Guid": guid == null ? null : guid,
        "UploadSiteId": uploadSiteId == null ? null : uploadSiteId,
        "UploadTime": uploadTime == null ? null : uploadTime,
        "SynchStatus": synchStatus == null ? null : synchStatus,
        "ExpiryDate": expiryDate == null ? null : expiryDate,
        "DownloadBatchId": downloadBatchId == null ? null : downloadBatchId,
        "RefreshFromHqTime":
            refreshFromHqTime == null ? null : refreshFromHqTime,
        "MasterEntityId": masterEntityId == null ? null : masterEntityId,
        "AccountIdentifier":
            accountIdentifier == null ? null : accountIdentifier,
        "PrimaryCard": primaryCard == null ? null : primaryCard,
        "CreatedBy": createdBy == null ? null : createdBy,
        "CreationDate": creationDate == null ? null : creationDate,
        "BalanceTime": balanceTime == null ? null : balanceTime,
        "CreditPlusCardBalance":
            creditPlusCardBalance == null ? null : creditPlusCardBalance,
        "CreditPlusCredits":
            creditPlusCredits == null ? null : creditPlusCredits,
        "CreditPlusItemPurchase":
            creditPlusItemPurchase == null ? null : creditPlusItemPurchase,
        "CreditPlusBonus": creditPlusBonus == null ? null : creditPlusBonus,
        "CreditPlusTime": creditPlusTime == null ? null : creditPlusTime,
        "CreditPlusTickets":
            creditPlusTickets == null ? null : creditPlusTickets,
        "CreditPlusLoyaltyPoints":
            creditPlusLoyaltyPoints == null ? null : creditPlusLoyaltyPoints,
        "CreditPlusRefundableBalance": creditPlusRefundableBalance == null
            ? null
            : creditPlusRefundableBalance,
        "RedeemableCreditPlusCreditsLoyaltyPoints":
            redeemableCreditPlusCreditsLoyaltyPoints == null
                ? null
                : redeemableCreditPlusCreditsLoyaltyPoints,
        "CreditPlusVirtualPoints":
            creditPlusVirtualPoints == null ? null : creditPlusVirtualPoints,
        "MembershipId": membershipId == null ? null : membershipId,
        "MembershipName": membershipName == null ? null : membershipName,
        "CustomerName": customerName == null ? null : customerName,
        "GamesBalance": gamesBalance == null ? null : gamesBalance,
        "TotalCreditsBalance":
            totalCreditsBalance == null ? null : totalCreditsBalance,
        "TotalBonusBalance":
            totalBonusBalance == null ? null : totalBonusBalance,
        "TotalTimeBalance": totalTimeBalance == null ? null : totalTimeBalance,
        "TotalCourtesyBalance":
            totalCourtesyBalance == null ? null : totalCourtesyBalance,
        "TotalLoyaltyBalance":
            totalLoyaltyBalance == null ? null : totalLoyaltyBalance,
        "TotalTicketsBalance":
            totalTicketsBalance == null ? null : totalTicketsBalance,
        "TotalGamesBalance":
            totalGamesBalance == null ? null : totalGamesBalance,
        "TotalGamePlayCreditsBalance": totalGamePlayCreditsBalance == null
            ? null
            : totalGamePlayCreditsBalance,
      };
}
