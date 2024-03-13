import 'dart:convert';
import 'package:semnox_core/modules/customer/accounts/model/account_activity_dto.dart';
import 'package:semnox_core/modules/transaction/model/game_play_dto.dart';

class AccountDto {
  AccountDto(
      {num? accountId,
      String? tagNumber,
      String? customerName,
      DateTime? issueDate,
      num? faceValue,
      num? credits,
      num? courtesy,
      num? bonus,
      num? time,
      num? ticketCount,
      num? loyaltyPoints,
      num? creditsPlayed,
      bool? realTicketMode,
      bool? vipCustomer,
      bool? ticketAllowed,
      String? technicianCard,
      bool? timerResetCard,
      dynamic techGames,
      bool? validFlag,
      bool? refundFlag,
      dynamic refundAmount,
      dynamic refundDate,
      dynamic expiryDate,
      DateTime? startTime,
      DateTime? lastPlayedTime,
      String? notes,
      DateTime? lastUpdateDate,
      String? lastUpdatedBy,
      bool? primaryAccount,
      String? accountIdentifier,
      String? membershipName,
      num? membershipId,
      num? customerId,
      num? uploadSiteId,
      DateTime? uploadTime,
      num? downloadBatchId,
      DateTime? refreshFromHqTime,
      num? siteId,
      num? masterEntityId,
      bool? synchStatus,
      String? guid,
      DateTime? creationDate,
      String? createdBy,
      dynamic accountDiscountDtoList,
      List<AccountCreditPlusDtoList>? accountCreditPlusDtoList,
      dynamic accountGameDtoList,
      dynamic accountRelationshipDtoList,
      dynamic refundAccountGameDtoList,
      dynamic refundAccountCreditPlusDtoList,
      List<GamePlayDto>? gamePlayDtoList,
      List<AccountActivityDto>? accountActivityDtoList,
      AccountSummaryDto? accountSummaryDto,
      num? totalCreditPlusBalance,
      bool? isChanged,
      num? totalCreditsBalance,
      num? totalBonusBalance,
      num? totalCourtesyBalance,
      num? totalTimeBalance,
      num? totalGamesBalance,
      num? totalTicketsBalance,
      dynamic totalVirtualPointBalance,
      bool? isChangedRecursive}) {
    _accountId = accountId;
    _tagNumber = tagNumber;
    _customerName = customerName;
    _issueDate = issueDate;
    _faceValue = faceValue;
    _credits = credits;
    _courtesy = courtesy;
    _bonus = bonus;
    _time = time;
    _ticketCount = ticketCount;
    _loyaltyPoints = loyaltyPoints;
    _creditsPlayed = creditsPlayed;
    _realTicketMode = realTicketMode;
    _vipCustomer = vipCustomer;
    _ticketAllowed = ticketAllowed;
    _technicianCard = technicianCard;
    _timerResetCard = timerResetCard;
    _techGames = techGames;
    _validFlag = validFlag;
    _refundFlag = refundFlag;
    _refundAmount = refundAmount;
    _refundDate = refundDate;
    _expiryDate = expiryDate;
    _startTime = startTime;
    _lastPlayedTime = lastPlayedTime;
    _notes = notes;
    _lastUpdateDate = lastUpdateDate;
    _lastUpdatedBy = lastUpdatedBy;
    _primaryAccount = primaryAccount;
    _accountIdentifier = accountIdentifier;
    _membershipName = membershipName;
    _membershipId = membershipId;
    _customerId = customerId;
    _uploadSiteId = uploadSiteId;
    _uploadTime = uploadTime;
    _downloadBatchId = downloadBatchId;
    _refreshFromHqTime = refreshFromHqTime;
    _siteId = siteId;
    _masterEntityId = masterEntityId;
    _synchStatus = synchStatus;
    _guid = guid;
    _creationDate = creationDate;
    _createdBy = createdBy;
    _accountDiscountDtoList = accountDiscountDtoList;
    _accountCreditPlusDtoList = accountCreditPlusDtoList;
    _accountGameDtoList = accountGameDtoList;
    _accountRelationshipDtoList = accountRelationshipDtoList;
    _refundAccountGameDtoList = refundAccountGameDtoList;
    _refundAccountCreditPlusDtoList = refundAccountCreditPlusDtoList;
    _gamePlayDtoList = gamePlayDtoList;
    _accountActivityDtoList = accountActivityDtoList;
    _accountSummaryDto = accountSummaryDto;
    _totalCreditPlusBalance = totalCreditPlusBalance;
    _isChanged = isChanged;
    _totalCreditsBalance = totalCreditsBalance;
    _totalBonusBalance = totalBonusBalance;
    _totalCourtesyBalance = totalCourtesyBalance;
    _totalTimeBalance = totalTimeBalance;
    _totalGamesBalance = totalGamesBalance;
    _totalTicketsBalance = totalTicketsBalance;
    _totalVirtualPointBalance = totalVirtualPointBalance;
    _isChangedRecursive = isChangedRecursive;
  }

  num? _accountId;
  String? _tagNumber;
  String? _customerName;
  DateTime? _issueDate;
  num? _faceValue;
  num? _credits;
  num? _courtesy;
  num? _bonus;
  num? _time;
  num? _ticketCount;
  num? _loyaltyPoints;
  num? _creditsPlayed;
  bool? _realTicketMode;
  bool? _vipCustomer;
  bool? _ticketAllowed;
  String? _technicianCard;
  bool? _timerResetCard;
  dynamic _techGames;
  bool? _validFlag;
  bool? _refundFlag;
  dynamic _refundAmount;
  dynamic _refundDate;
  dynamic _expiryDate;
  DateTime? _startTime;
  DateTime? _lastPlayedTime;
  String? _notes;
  DateTime? _lastUpdateDate;
  String? _lastUpdatedBy;
  bool? _primaryAccount;
  String? _accountIdentifier;
  String? _membershipName;
  num? _membershipId;
  num? _customerId;
  num? _uploadSiteId;
  DateTime? _uploadTime;
  num? _downloadBatchId;
  DateTime? _refreshFromHqTime;
  num? _siteId;
  num? _masterEntityId;
  bool? _synchStatus;
  String? _guid;
  DateTime? _creationDate;
  String? _createdBy;
  dynamic _accountDiscountDtoList;
  List<AccountCreditPlusDtoList>? _accountCreditPlusDtoList;
  dynamic _accountGameDtoList;
  dynamic _accountRelationshipDtoList;
  dynamic _refundAccountGameDtoList;
  dynamic _refundAccountCreditPlusDtoList;
  List<GamePlayDto>? _gamePlayDtoList;
  List<AccountActivityDto>? _accountActivityDtoList;
  AccountSummaryDto? _accountSummaryDto;
  num? _totalCreditPlusBalance;
  bool? _isChanged;
  num? _totalCreditsBalance;
  num? _totalBonusBalance;
  num? _totalCourtesyBalance;
  num? _totalTimeBalance;
  num? _totalGamesBalance;
  num? _totalTicketsBalance;
  dynamic _totalVirtualPointBalance;
  bool? _isChangedRecursive;

  num? get accountId => _accountId;
  String? get tagNumber => _tagNumber;
  String? get customerName => _customerName;
  DateTime? get issueDate => _issueDate;
  num? get faceValue => _faceValue;
  num? get credits => _credits;
  num? get courtesy => _courtesy;
  num? get bonus => _bonus;
  num? get time => _time;
  num? get ticketCount => _ticketCount;
  num? get loyaltyPoints => _loyaltyPoints;
  num? get creditsPlayed => _creditsPlayed;
  bool? get realTicketMode => _realTicketMode;
  bool? get vipCustomer => _vipCustomer;
  bool? get ticketAllowed => _ticketAllowed;
  String? get technicianCard => _technicianCard;
  bool? get timerResetCard => _timerResetCard;
  dynamic get techGames => _techGames;
  bool? get validFlag => _validFlag;
  bool? get refundFlag => _refundFlag;
  dynamic get refundAmount => _refundAmount;
  dynamic get refundDate => _refundDate;
  dynamic get expiryDate => _expiryDate;
  DateTime? get startTime => _startTime;
  DateTime? get lastPlayedTime => _lastPlayedTime;
  String? get notes => _notes;
  DateTime? get lastUpdateDate => _lastUpdateDate;
  String? get lastUpdatedBy => _lastUpdatedBy;
  bool? get primaryAccount => _primaryAccount;
  String? get accountIdentifier => _accountIdentifier;
  String? get membershipName => _membershipName;
  num? get membershipId => _membershipId;
  num? get customerId => _customerId;
  num? get uploadSiteId => _uploadSiteId;
  DateTime? get uploadTime => _uploadTime;
  num? get downloadBatchId => _downloadBatchId;
  DateTime? get refreshFromHqTime => _refreshFromHqTime;
  num? get siteId => _siteId;
  num? get masterEntityId => _masterEntityId;
  bool? get synchStatus => _synchStatus;
  String? get guid => _guid;
  DateTime? get creationDate => _creationDate;
  String? get createdBy => _createdBy;
  dynamic get accountDiscountDtoList => _accountDiscountDtoList;
  List<AccountCreditPlusDtoList>? get accountCreditPlusDtoList =>
      _accountCreditPlusDtoList;
  dynamic get accountGameDtoList => _accountGameDtoList;
  dynamic get accountRelationshipDtoList => _accountRelationshipDtoList;
  dynamic get refundAccountGameDtoList => _refundAccountGameDtoList;
  dynamic get refundAccountCreditPlusDtoList => _refundAccountCreditPlusDtoList;
  List<GamePlayDto>? get gamePlayDtoList => _gamePlayDtoList;
  List<AccountActivityDto>? get accountActivityDtoList =>
      _accountActivityDtoList;
  AccountSummaryDto? get accountSummaryDto => _accountSummaryDto;
  num? get totalCreditPlusBalance => _totalCreditPlusBalance;
  bool? get isChanged => _isChanged;
  num? get totalCreditsBalance => _totalCreditsBalance;
  num? get totalBonusBalance => _totalBonusBalance;
  num? get totalCourtesyBalance => _totalCourtesyBalance;
  num? get totalTimeBalance => _totalTimeBalance;
  num? get totalGamesBalance => _totalGamesBalance;
  num? get totalTicketsBalance => _totalTicketsBalance;
  dynamic get totalVirtualPointBalance => _totalVirtualPointBalance;
  bool? get isChangedRecursive => _isChangedRecursive;

  factory AccountDto.fromJson(String str) =>
      AccountDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AccountDto.fromMap(Map<String, dynamic> json) => AccountDto(
        accountId: json["AccountId"],
        tagNumber: json["TagNumber"],
        customerName: json["CustomerName"],
        issueDate: json["IssueDate"] == null
            ? null
            : DateTime.parse(json["IssueDate"]),
        faceValue: json["FaceValue"],
        credits: json["Credits"],
        courtesy: json["Courtesy"],
        bonus: json["Bonus"],
        time: json["Time"],
        ticketCount: json["TicketCount"],
        loyaltyPoints: json["LoyaltyPoints"],
        creditsPlayed: json["CreditsPlayed"],
        realTicketMode: json["RealTicketMode"],
        vipCustomer: json["VipCustomer"],
        ticketAllowed: json["TicketAllowed"],
        technicianCard: json["TechnicianCard"],
        timerResetCard: json["TimerResetCard"],
        techGames: json["TechGames"],
        validFlag: json["ValidFlag"],
        refundFlag: json["RefundFlag"],
        refundAmount: json["RefundAmount"],
        refundDate: json["RefundDate"],
        expiryDate: json["ExpiryDate"],
        startTime: json["StartTime"] == null
            ? null
            : DateTime.parse(json["StartTime"]),
        lastPlayedTime: json["LastPlayedTime"] == null
            ? null
            : DateTime.parse(json["LastPlayedTime"]),
        notes: json["Notes"],
        lastUpdateDate: json["LastUpdateDate"] == null
            ? null
            : DateTime.parse(json["LastUpdateDate"]),
        lastUpdatedBy: json["LastUpdatedBy"],
        primaryAccount: json["PrimaryAccount"],
        accountIdentifier: json["AccountIdentifier"],
        membershipName: json["MembershipName"],
        membershipId: json["MembershipId"],
        customerId: json["CustomerId"],
        uploadSiteId: json["UploadSiteId"],
        uploadTime: json["UploadTime"] == null
            ? null
            : DateTime.parse(json["UploadTime"]),
        downloadBatchId: json["DownloadBatchId"],
        refreshFromHqTime: json["RefreshFromHQTime"] == null
            ? null
            : DateTime.parse(json["RefreshFromHQTime"]),
        siteId: json["SiteId"],
        masterEntityId: json["MasterEntityId"],
        synchStatus: json["SynchStatus"],
        guid: json["Guid"],
        creationDate: json["CreationDate"] == null
            ? null
            : DateTime.parse(json["CreationDate"]),
        createdBy: json["CreatedBy"],
        accountDiscountDtoList: json["AccountDiscountDTOList"],
        accountCreditPlusDtoList: json["AccountCreditPlusDTOList"] == null
            ? null
            : List<AccountCreditPlusDtoList>.from(
                json["AccountCreditPlusDTOList"]
                    .map((x) => AccountCreditPlusDtoList.fromMap(x))),
        accountGameDtoList: json["AccountGameDTOList"],
        accountRelationshipDtoList: json["AccountRelationshipDTOList"],
        refundAccountGameDtoList: json["RefundAccountGameDTOList"],
        refundAccountCreditPlusDtoList: json["RefundAccountCreditPlusDTOList"],
        gamePlayDtoList: json["GamePlayDTOList"] == null
            ? null
            : List<GamePlayDto>.from(
                json["GamePlayDTOList"].map((x) => GamePlayDto.fromMap(x))),
        accountActivityDtoList: json["AccountActivityDTOList"] == null
            ? null
            : List<AccountActivityDto>.from(json["AccountActivityDTOList"]
                .map((x) => AccountActivityDto.fromMap(x))),
        accountSummaryDto: json["AccountSummaryDTO"] == null
            ? null
            : AccountSummaryDto.fromMap(json["AccountSummaryDTO"]),
        totalCreditPlusBalance: json["TotalCreditPlusBalance"],
        isChanged: json["IsChanged"],
        totalCreditsBalance: json["TotalCreditsBalance"],
        totalBonusBalance: json["TotalBonusBalance"],
        totalCourtesyBalance: json["TotalCourtesyBalance"],
        totalTimeBalance: json["TotalTimeBalance"],
        totalGamesBalance: json["TotalGamesBalance"],
        totalTicketsBalance: json["TotalTicketsBalance"],
        totalVirtualPointBalance: json["TotalVirtualPointBalance"],
        isChangedRecursive: json["IsChangedRecursive"],
      );

  Map<String, dynamic> toMap() => {
        "AccountId": accountId,
        "TagNumber": tagNumber,
        "CustomerName": customerName,
        "IssueDate": issueDate == null ? null : issueDate!.toIso8601String(),
        "FaceValue": faceValue,
        "Credits": credits,
        "Courtesy": courtesy,
        "Bonus": bonus,
        "Time": time,
        "TicketCount": ticketCount,
        "LoyaltyPoints": loyaltyPoints,
        "CreditsPlayed": creditsPlayed,
        "RealTicketMode": realTicketMode,
        "VipCustomer": vipCustomer,
        "TicketAllowed": ticketAllowed,
        "TechnicianCard": technicianCard,
        "TimerResetCard": timerResetCard,
        "TechGames": techGames,
        "ValidFlag": validFlag,
        "RefundFlag": refundFlag,
        "RefundAmount": refundAmount,
        "RefundDate": refundDate,
        "ExpiryDate": expiryDate,
        "StartTime": startTime == null ? null : startTime!.toIso8601String(),
        "LastPlayedTime":
            lastPlayedTime == null ? null : lastPlayedTime!.toIso8601String(),
        "Notes": notes,
        "LastUpdateDate":
            lastUpdateDate == null ? null : lastUpdateDate!.toIso8601String(),
        "LastUpdatedBy": lastUpdatedBy,
        "PrimaryAccount": primaryAccount,
        "AccountIdentifier": accountIdentifier,
        "MembershipName": membershipName,
        "MembershipId": membershipId,
        "CustomerId": customerId,
        "UploadSiteId": uploadSiteId,
        "UploadTime": uploadTime == null ? null : uploadTime!.toIso8601String(),
        "DownloadBatchId": downloadBatchId,
        "RefreshFromHQTime": refreshFromHqTime == null
            ? null
            : refreshFromHqTime!.toIso8601String(),
        "SiteId": siteId,
        "MasterEntityId": masterEntityId,
        "SynchStatus": synchStatus,
        "Guid": guid,
        "CreationDate":
            creationDate == null ? null : creationDate!.toIso8601String(),
        "CreatedBy": createdBy,
        "AccountDiscountDTOList": accountDiscountDtoList,
        "AccountCreditPlusDTOList": accountCreditPlusDtoList == null
            ? null
            : List<dynamic>.from(
                accountCreditPlusDtoList!.map((x) => x.toMap())),
        "AccountGameDTOList": accountGameDtoList,
        "AccountRelationshipDTOList": accountRelationshipDtoList,
        "RefundAccountGameDTOList": refundAccountGameDtoList,
        "RefundAccountCreditPlusDTOList": refundAccountCreditPlusDtoList,
        "GamePlayDTOList": gamePlayDtoList == null
            ? null
            : List<GamePlayDto>.from(gamePlayDtoList!.map((x) => x.toMap())),
        "AccountActivityDTOList": accountActivityDtoList == null
            ? null
            : List<AccountActivityDto>.from(
                accountActivityDtoList!.map((x) => x.toMap())),
        "AccountSummaryDTO":
            accountSummaryDto == null ? null : accountSummaryDto!.toMap(),
        "TotalCreditPlusBalance": totalCreditPlusBalance,
        "IsChanged": isChanged,
        "TotalCreditsBalance": totalCreditsBalance,
        "TotalBonusBalance": totalBonusBalance,
        "TotalCourtesyBalance": totalCourtesyBalance,
        "TotalTimeBalance": totalTimeBalance,
        "TotalGamesBalance": totalGamesBalance,
        "TotalTicketsBalance": totalTicketsBalance,
        "TotalVirtualPointBalance": totalVirtualPointBalance,
        "IsChangedRecursive": isChangedRecursive,
      };
}

class AccountCreditPlusDtoList {
  AccountCreditPlusDtoList({
    this.accountCreditPlusId,
    this.accountId,
    this.creditPlusType,
    this.creditPlus,
    this.creditPlusBalance,
    this.periodFrom,
    this.periodTo,
    this.extendOnReload,
    this.refundable,
    this.timeFrom,
    this.timeTo,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
    this.ticketAllowed,
    this.pauseAllowed,
    this.remarks,
    this.expireWithMembership,
    this.transactionId,
    this.transactionLineId,
    this.numberOfDays,
    this.minimumSaleAmount,
    this.loyaltyRuleId,
    this.playStartTime,
    this.validityStatus,
    this.forMembershipOnly,
    this.membershipId,
    this.membershipRewardsId,
    this.creationDate,
    this.lastUpdatedBy,
    this.lastUpdateDate,
    this.siteId,
    this.masterEntityId,
    this.synchStatus,
    this.guid,
    this.isActive,
    this.createdBy,
    this.accountCreditPlusConsumptionDtoList,
    this.accountCreditPlusPurchaseCriteriaDtoList,
    this.entityOverrideDatesDtoList,
    this.isChanged,
    this.isChangedRecursive,
    this.sourceCreditPlusId,
    this.subscriptionBillingScheduleId,
  });

  final num? accountCreditPlusId;
  final num? accountId;
  final num? creditPlusType;
  final num? creditPlus;
  final num? creditPlusBalance;
  final dynamic periodFrom;
  final dynamic periodTo;
  final bool? extendOnReload;
  final bool? refundable;
  final dynamic timeFrom;
  final dynamic timeTo;
  final bool? monday;
  final bool? tuesday;
  final bool? wednesday;
  final bool? thursday;
  final bool? friday;
  final bool? saturday;
  final bool? sunday;
  final bool? ticketAllowed;
  final bool? pauseAllowed;
  final String? remarks;
  final bool? expireWithMembership;
  final num? transactionId;
  final num? transactionLineId;
  final dynamic numberOfDays;
  final dynamic minimumSaleAmount;
  final num? loyaltyRuleId;
  final dynamic playStartTime;
  final num? validityStatus;
  final bool? forMembershipOnly;
  final num? membershipId;
  final num? membershipRewardsId;
  final DateTime? creationDate;
  final String? lastUpdatedBy;
  final DateTime? lastUpdateDate;
  final num? siteId;
  final num? masterEntityId;
  final bool? synchStatus;
  final String? guid;
  final bool? isActive;
  final String? createdBy;
  final List<dynamic>? accountCreditPlusConsumptionDtoList;
  final List<dynamic>? accountCreditPlusPurchaseCriteriaDtoList;
  final List<dynamic>? entityOverrideDatesDtoList;
  final bool? isChanged;
  final bool? isChangedRecursive;
  final num? sourceCreditPlusId;
  final num? subscriptionBillingScheduleId;

  factory AccountCreditPlusDtoList.fromJson(String str) =>
      AccountCreditPlusDtoList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AccountCreditPlusDtoList.fromMap(Map<String, dynamic> json) =>
      AccountCreditPlusDtoList(
        accountCreditPlusId: json["AccountCreditPlusId"] == null
            ? null
            : json["AccountCreditPlusId"],
        accountId: json["AccountId"] == null ? null : json["AccountId"],
        creditPlusType:
            json["CreditPlusType"] == null ? null : json["CreditPlusType"],
        creditPlus: json["CreditPlus"] == null ? null : json["CreditPlus"],
        creditPlusBalance: json["CreditPlusBalance"] == null
            ? null
            : json["CreditPlusBalance"],
        periodFrom: json["PeriodFrom"],
        periodTo: json["PeriodTo"],
        extendOnReload:
            json["ExtendOnReload"] == null ? null : json["ExtendOnReload"],
        refundable: json["Refundable"] == null ? null : json["Refundable"],
        timeFrom: json["TimeFrom"],
        timeTo: json["TimeTo"],
        monday: json["Monday"] == null ? null : json["Monday"],
        tuesday: json["Tuesday"] == null ? null : json["Tuesday"],
        wednesday: json["Wednesday"] == null ? null : json["Wednesday"],
        thursday: json["Thursday"] == null ? null : json["Thursday"],
        friday: json["Friday"] == null ? null : json["Friday"],
        saturday: json["Saturday"] == null ? null : json["Saturday"],
        sunday: json["Sunday"] == null ? null : json["Sunday"],
        ticketAllowed:
            json["TicketAllowed"] == null ? null : json["TicketAllowed"],
        pauseAllowed:
            json["PauseAllowed"] == null ? null : json["PauseAllowed"],
        remarks: json["Remarks"] == null ? null : json["Remarks"],
        expireWithMembership: json["ExpireWithMembership"] == null
            ? null
            : json["ExpireWithMembership"],
        transactionId:
            json["TransactionId"] == null ? null : json["TransactionId"],
        transactionLineId: json["TransactionLineId"] == null
            ? null
            : json["TransactionLineId"],
        numberOfDays: json["NumberOfDays"],
        minimumSaleAmount: json["MinimumSaleAmount"],
        loyaltyRuleId:
            json["LoyaltyRuleId"] == null ? null : json["LoyaltyRuleId"],
        playStartTime: json["PlayStartTime"],
        validityStatus:
            json["ValidityStatus"] == null ? null : json["ValidityStatus"],
        forMembershipOnly: json["ForMembershipOnly"] == null
            ? null
            : json["ForMembershipOnly"],
        membershipId:
            json["MembershipId"] == null ? null : json["MembershipId"],
        membershipRewardsId: json["MembershipRewardsId"] == null
            ? null
            : json["MembershipRewardsId"],
        creationDate: json["CreationDate"] == null
            ? null
            : DateTime.parse(json["CreationDate"]),
        lastUpdatedBy:
            json["LastUpdatedBy"] == null ? null : json["LastUpdatedBy"],
        lastUpdateDate: json["LastUpdateDate"] == null
            ? null
            : DateTime.parse(json["LastUpdateDate"]),
        siteId: json["SiteId"] == null ? null : json["SiteId"],
        masterEntityId:
            json["MasterEntityId"] == null ? null : json["MasterEntityId"],
        synchStatus: json["SynchStatus"] == null ? null : json["SynchStatus"],
        guid: json["Guid"] == null ? null : json["Guid"],
        isActive: json["IsActive"] == null ? null : json["IsActive"],
        createdBy: json["CreatedBy"] == null ? null : json["CreatedBy"],
        accountCreditPlusConsumptionDtoList:
            json["AccountCreditPlusConsumptionDTOList"] == null
                ? null
                : List<dynamic>.from(
                    json["AccountCreditPlusConsumptionDTOList"].map((x) => x)),
        accountCreditPlusPurchaseCriteriaDtoList:
            json["AccountCreditPlusPurchaseCriteriaDTOList"] == null
                ? null
                : List<dynamic>.from(
                    json["AccountCreditPlusPurchaseCriteriaDTOList"]
                        .map((x) => x)),
        entityOverrideDatesDtoList: json["EntityOverrideDatesDTOList"] == null
            ? null
            : List<dynamic>.from(
                json["EntityOverrideDatesDTOList"].map((x) => x)),
        isChanged: json["IsChanged"] == null ? null : json["IsChanged"],
        isChangedRecursive: json["IsChangedRecursive"] == null
            ? null
            : json["IsChangedRecursive"],
        sourceCreditPlusId: json["SourceCreditPlusId"] == null
            ? null
            : json["SourceCreditPlusId"],
        subscriptionBillingScheduleId:
            json["SubscriptionBillingScheduleId"] == null
                ? null
                : json["SubscriptionBillingScheduleId"],
      );

  Map<String, dynamic> toMap() => {
        "AccountCreditPlusId":
            accountCreditPlusId == null ? null : accountCreditPlusId,
        "AccountId": accountId == null ? null : accountId,
        "CreditPlusType": creditPlusType == null ? null : creditPlusType,
        "CreditPlus": creditPlus == null ? null : creditPlus,
        "CreditPlusBalance":
            creditPlusBalance == null ? null : creditPlusBalance,
        "PeriodFrom": periodFrom,
        "PeriodTo": periodTo,
        "ExtendOnReload": extendOnReload == null ? null : extendOnReload,
        "Refundable": refundable == null ? null : refundable,
        "TimeFrom": timeFrom,
        "TimeTo": timeTo,
        "Monday": monday == null ? null : monday,
        "Tuesday": tuesday == null ? null : tuesday,
        "Wednesday": wednesday == null ? null : wednesday,
        "Thursday": thursday == null ? null : thursday,
        "Friday": friday == null ? null : friday,
        "Saturday": saturday == null ? null : saturday,
        "Sunday": sunday == null ? null : sunday,
        "TicketAllowed": ticketAllowed == null ? null : ticketAllowed,
        "PauseAllowed": pauseAllowed == null ? null : pauseAllowed,
        "Remarks": remarks == null ? null : remarks,
        "ExpireWithMembership":
            expireWithMembership == null ? null : expireWithMembership,
        "TransactionId": transactionId == null ? null : transactionId,
        "TransactionLineId":
            transactionLineId == null ? null : transactionLineId,
        "NumberOfDays": numberOfDays,
        "MinimumSaleAmount": minimumSaleAmount,
        "LoyaltyRuleId": loyaltyRuleId == null ? null : loyaltyRuleId,
        "PlayStartTime": playStartTime,
        "ValidityStatus": validityStatus == null ? null : validityStatus,
        "ForMembershipOnly":
            forMembershipOnly == null ? null : forMembershipOnly,
        "MembershipId": membershipId == null ? null : membershipId,
        "MembershipRewardsId":
            membershipRewardsId == null ? null : membershipRewardsId,
        "CreationDate":
            creationDate == null ? null : creationDate!.toIso8601String(),
        "LastUpdatedBy": lastUpdatedBy == null ? null : lastUpdatedBy,
        "LastUpdateDate":
            lastUpdateDate == null ? null : lastUpdateDate!.toIso8601String(),
        "SiteId": siteId == null ? null : siteId,
        "MasterEntityId": masterEntityId == null ? null : masterEntityId,
        "SynchStatus": synchStatus == null ? null : synchStatus,
        "Guid": guid == null ? null : guid,
        "IsActive": isActive == null ? null : isActive,
        "CreatedBy": createdBy == null ? null : createdBy,
        "AccountCreditPlusConsumptionDTOList":
            accountCreditPlusConsumptionDtoList == null
                ? null
                : List<dynamic>.from(
                    accountCreditPlusConsumptionDtoList!.map((x) => x)),
        "AccountCreditPlusPurchaseCriteriaDTOList":
            accountCreditPlusPurchaseCriteriaDtoList == null
                ? null
                : List<dynamic>.from(
                    accountCreditPlusPurchaseCriteriaDtoList!.map((x) => x)),
        "EntityOverrideDatesDTOList": entityOverrideDatesDtoList == null
            ? null
            : List<dynamic>.from(entityOverrideDatesDtoList!.map((x) => x)),
        "IsChanged": isChanged == null ? null : isChanged,
        "IsChangedRecursive":
            isChangedRecursive == null ? null : isChangedRecursive,
        "SourceCreditPlusId":
            sourceCreditPlusId == null ? null : sourceCreditPlusId,
        "SubscriptionBillingScheduleId": subscriptionBillingScheduleId == null
            ? null
            : subscriptionBillingScheduleId,
      };
}

class AccountSummaryDto {
  AccountSummaryDto({
    this.creditPlusCardBalance,
    this.creditPlusGamePlayCredits,
    this.creditPlusItemPurchase,
    this.creditPlusBonus,
    this.creditPlusLoyaltyPoints,
    this.creditPlusTickets,
    this.creditPlusVirtualPoints,
    this.creditPlusTime,
    this.creditPlusRefundableBalance,
    this.redeemableCreditPlusLoyaltyPoints,
    this.accountGameBalance,
    this.totalGamePlayCreditsBalance,
    this.totalBonusBalance,
    this.totalCourtesyBalance,
    this.totalTimeBalance,
    this.totalVirtualPointBalance,
    this.totalGamesBalance,
    this.totalTicketsBalance,
    this.totalLoyaltyPointBalance,
    this.accountExpiryDate,
    this.formattedCreditPlusCardBalance,
    this.formattedCreditPlusVirtualPointBalance,
    this.formattedCreditPlusGamePlayCredits,
    this.formattedCreditPlusItemPurchase,
    this.formattedCreditPlusBonus,
    this.formattedCreditPlusLoyaltyPoints,
    this.formattedCreditPlusTickets,
    this.formattedCreditPlusTime,
    this.formattedCreditPlusRefundableBalance,
    this.formattedRedeemableCreditPlusLoyaltyPoints,
    this.formattedTotalGamePlayCreditsBalance,
    this.formattedTotalBonusBalance,
    this.formattedTotalCourtesyBalance,
    this.formattedTotalTimeBalance,
    this.formattedTotalGamesBalance,
    this.formattedTotalTicketsBalance,
    this.formattedTotalLoyaltyPointBalance,
    this.formattedAccountExpiryDate,
  });

  final num? creditPlusCardBalance;
  final num? creditPlusGamePlayCredits;
  final num? creditPlusItemPurchase;
  final num? creditPlusBonus;
  final num? creditPlusLoyaltyPoints;
  final num? creditPlusTickets;
  final num? creditPlusVirtualPoints;
  final num? creditPlusTime;
  final num? creditPlusRefundableBalance;
  final num? redeemableCreditPlusLoyaltyPoints;
  final num? accountGameBalance;
  final num? totalGamePlayCreditsBalance;
  final num? totalBonusBalance;
  final num? totalCourtesyBalance;
  final num? totalTimeBalance;
  final num? totalVirtualPointBalance;
  final num? totalGamesBalance;
  final num? totalTicketsBalance;
  final num? totalLoyaltyPointBalance;
  final dynamic accountExpiryDate;
  final String? formattedCreditPlusCardBalance;
  final String? formattedCreditPlusVirtualPointBalance;
  final String? formattedCreditPlusGamePlayCredits;
  final String? formattedCreditPlusItemPurchase;
  final String? formattedCreditPlusBonus;
  final String? formattedCreditPlusLoyaltyPoints;
  final String? formattedCreditPlusTickets;
  final String? formattedCreditPlusTime;
  final String? formattedCreditPlusRefundableBalance;
  final String? formattedRedeemableCreditPlusLoyaltyPoints;
  final String? formattedTotalGamePlayCreditsBalance;
  final String? formattedTotalBonusBalance;
  final String? formattedTotalCourtesyBalance;
  final String? formattedTotalTimeBalance;
  final String? formattedTotalGamesBalance;
  final String? formattedTotalTicketsBalance;
  final String? formattedTotalLoyaltyPointBalance;
  final String? formattedAccountExpiryDate;

  factory AccountSummaryDto.fromJson(String str) =>
      AccountSummaryDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AccountSummaryDto.fromMap(Map<String, dynamic> json) =>
      AccountSummaryDto(
        creditPlusCardBalance: json["CreditPlusCardBalance"] == null
            ? null
            : json["CreditPlusCardBalance"],
        creditPlusGamePlayCredits: json["CreditPlusGamePlayCredits"] == null
            ? null
            : json["CreditPlusGamePlayCredits"],
        creditPlusItemPurchase: json["CreditPlusItemPurchase"] == null
            ? null
            : json["CreditPlusItemPurchase"],
        creditPlusBonus:
            json["CreditPlusBonus"] == null ? null : json["CreditPlusBonus"],
        creditPlusLoyaltyPoints: json["CreditPlusLoyaltyPoints"] == null
            ? null
            : json["CreditPlusLoyaltyPoints"],
        creditPlusTickets: json["CreditPlusTickets"] == null
            ? null
            : json["CreditPlusTickets"],
        creditPlusVirtualPoints: json["CreditPlusVirtualPoints"] == null
            ? null
            : json["CreditPlusVirtualPoints"],
        creditPlusTime:
            json["CreditPlusTime"] == null ? null : json["CreditPlusTime"],
        creditPlusRefundableBalance: json["CreditPlusRefundableBalance"] == null
            ? null
            : json["CreditPlusRefundableBalance"],
        redeemableCreditPlusLoyaltyPoints:
            json["RedeemableCreditPlusLoyaltyPoints"] == null
                ? null
                : json["RedeemableCreditPlusLoyaltyPoints"],
        accountGameBalance: json["AccountGameBalance"] == null
            ? null
            : json["AccountGameBalance"],
        totalGamePlayCreditsBalance: json["TotalGamePlayCreditsBalance"] == null
            ? null
            : json["TotalGamePlayCreditsBalance"],
        totalBonusBalance: json["TotalBonusBalance"] == null
            ? null
            : json["TotalBonusBalance"],
        totalCourtesyBalance: json["TotalCourtesyBalance"] == null
            ? null
            : json["TotalCourtesyBalance"],
        totalTimeBalance:
            json["TotalTimeBalance"] == null ? null : json["TotalTimeBalance"],
        totalVirtualPointBalance: json["TotalVirtualPointBalance"] == null
            ? null
            : json["TotalVirtualPointBalance"],
        totalGamesBalance: json["TotalGamesBalance"] == null
            ? null
            : json["TotalGamesBalance"],
        totalTicketsBalance: json["TotalTicketsBalance"] == null
            ? null
            : json["TotalTicketsBalance"],
        totalLoyaltyPointBalance: json["TotalLoyaltyPointBalance"] == null
            ? null
            : json["TotalLoyaltyPointBalance"],
        accountExpiryDate: json["AccountExpiryDate"],
        formattedCreditPlusCardBalance:
            json["FormattedCreditPlusCardBalance"] == null
                ? null
                : json["FormattedCreditPlusCardBalance"],
        formattedCreditPlusVirtualPointBalance:
            json["FormattedCreditPlusVirtualPointBalance"] == null
                ? null
                : json["FormattedCreditPlusVirtualPointBalance"],
        formattedCreditPlusGamePlayCredits:
            json["FormattedCreditPlusGamePlayCredits"] == null
                ? null
                : json["FormattedCreditPlusGamePlayCredits"],
        formattedCreditPlusItemPurchase:
            json["FormattedCreditPlusItemPurchase"] == null
                ? null
                : json["FormattedCreditPlusItemPurchase"],
        formattedCreditPlusBonus: json["FormattedCreditPlusBonus"] == null
            ? null
            : json["FormattedCreditPlusBonus"],
        formattedCreditPlusLoyaltyPoints:
            json["FormattedCreditPlusLoyaltyPoints"] == null
                ? null
                : json["FormattedCreditPlusLoyaltyPoints"],
        formattedCreditPlusTickets: json["FormattedCreditPlusTickets"] == null
            ? null
            : json["FormattedCreditPlusTickets"],
        formattedCreditPlusTime: json["FormattedCreditPlusTime"] == null
            ? null
            : json["FormattedCreditPlusTime"],
        formattedCreditPlusRefundableBalance:
            json["FormattedCreditPlusRefundableBalance"] == null
                ? null
                : json["FormattedCreditPlusRefundableBalance"],
        formattedRedeemableCreditPlusLoyaltyPoints:
            json["FormattedRedeemableCreditPlusLoyaltyPoints"] == null
                ? null
                : json["FormattedRedeemableCreditPlusLoyaltyPoints"],
        formattedTotalGamePlayCreditsBalance:
            json["FormattedTotalGamePlayCreditsBalance"] == null
                ? null
                : json["FormattedTotalGamePlayCreditsBalance"],
        formattedTotalBonusBalance: json["FormattedTotalBonusBalance"] == null
            ? null
            : json["FormattedTotalBonusBalance"],
        formattedTotalCourtesyBalance:
            json["FormattedTotalCourtesyBalance"] == null
                ? null
                : json["FormattedTotalCourtesyBalance"],
        formattedTotalTimeBalance: json["FormattedTotalTimeBalance"] == null
            ? null
            : json["FormattedTotalTimeBalance"],
        formattedTotalGamesBalance: json["FormattedTotalGamesBalance"] == null
            ? null
            : json["FormattedTotalGamesBalance"],
        formattedTotalTicketsBalance:
            json["FormattedTotalTicketsBalance"] == null
                ? null
                : json["FormattedTotalTicketsBalance"],
        formattedTotalLoyaltyPointBalance:
            json["FormattedTotalLoyaltyPointBalance"] == null
                ? null
                : json["FormattedTotalLoyaltyPointBalance"],
        formattedAccountExpiryDate: json["FormattedAccountExpiryDate"] == null
            ? null
            : json["FormattedAccountExpiryDate"],
      );

  Map<String, dynamic> toMap() => {
        "CreditPlusCardBalance":
            creditPlusCardBalance == null ? null : creditPlusCardBalance,
        "CreditPlusGamePlayCredits": creditPlusGamePlayCredits == null
            ? null
            : creditPlusGamePlayCredits,
        "CreditPlusItemPurchase":
            creditPlusItemPurchase == null ? null : creditPlusItemPurchase,
        "CreditPlusBonus": creditPlusBonus == null ? null : creditPlusBonus,
        "CreditPlusLoyaltyPoints":
            creditPlusLoyaltyPoints == null ? null : creditPlusLoyaltyPoints,
        "CreditPlusTickets":
            creditPlusTickets == null ? null : creditPlusTickets,
        "CreditPlusVirtualPoints":
            creditPlusVirtualPoints == null ? null : creditPlusVirtualPoints,
        "CreditPlusTime": creditPlusTime == null ? null : creditPlusTime,
        "CreditPlusRefundableBalance": creditPlusRefundableBalance == null
            ? null
            : creditPlusRefundableBalance,
        "RedeemableCreditPlusLoyaltyPoints":
            redeemableCreditPlusLoyaltyPoints == null
                ? null
                : redeemableCreditPlusLoyaltyPoints,
        "AccountGameBalance":
            accountGameBalance == null ? null : accountGameBalance,
        "TotalGamePlayCreditsBalance": totalGamePlayCreditsBalance == null
            ? null
            : totalGamePlayCreditsBalance,
        "TotalBonusBalance":
            totalBonusBalance == null ? null : totalBonusBalance,
        "TotalCourtesyBalance":
            totalCourtesyBalance == null ? null : totalCourtesyBalance,
        "TotalTimeBalance": totalTimeBalance == null ? null : totalTimeBalance,
        "TotalVirtualPointBalance":
            totalVirtualPointBalance == null ? null : totalVirtualPointBalance,
        "TotalGamesBalance":
            totalGamesBalance == null ? null : totalGamesBalance,
        "TotalTicketsBalance":
            totalTicketsBalance == null ? null : totalTicketsBalance,
        "TotalLoyaltyPointBalance":
            totalLoyaltyPointBalance == null ? null : totalLoyaltyPointBalance,
        "AccountExpiryDate": accountExpiryDate,
        "FormattedCreditPlusCardBalance": formattedCreditPlusCardBalance == null
            ? null
            : formattedCreditPlusCardBalance,
        "FormattedCreditPlusVirtualPointBalance":
            formattedCreditPlusVirtualPointBalance == null
                ? null
                : formattedCreditPlusVirtualPointBalance,
        "FormattedCreditPlusGamePlayCredits":
            formattedCreditPlusGamePlayCredits == null
                ? null
                : formattedCreditPlusGamePlayCredits,
        "FormattedCreditPlusItemPurchase":
            formattedCreditPlusItemPurchase == null
                ? null
                : formattedCreditPlusItemPurchase,
        "FormattedCreditPlusBonus":
            formattedCreditPlusBonus == null ? null : formattedCreditPlusBonus,
        "FormattedCreditPlusLoyaltyPoints":
            formattedCreditPlusLoyaltyPoints == null
                ? null
                : formattedCreditPlusLoyaltyPoints,
        "FormattedCreditPlusTickets": formattedCreditPlusTickets == null
            ? null
            : formattedCreditPlusTickets,
        "FormattedCreditPlusTime":
            formattedCreditPlusTime == null ? null : formattedCreditPlusTime,
        "FormattedCreditPlusRefundableBalance":
            formattedCreditPlusRefundableBalance == null
                ? null
                : formattedCreditPlusRefundableBalance,
        "FormattedRedeemableCreditPlusLoyaltyPoints":
            formattedRedeemableCreditPlusLoyaltyPoints == null
                ? null
                : formattedRedeemableCreditPlusLoyaltyPoints,
        "FormattedTotalGamePlayCreditsBalance":
            formattedTotalGamePlayCreditsBalance == null
                ? null
                : formattedTotalGamePlayCreditsBalance,
        "FormattedTotalBonusBalance": formattedTotalBonusBalance == null
            ? null
            : formattedTotalBonusBalance,
        "FormattedTotalCourtesyBalance": formattedTotalCourtesyBalance == null
            ? null
            : formattedTotalCourtesyBalance,
        "FormattedTotalTimeBalance": formattedTotalTimeBalance == null
            ? null
            : formattedTotalTimeBalance,
        "FormattedTotalGamesBalance": formattedTotalGamesBalance == null
            ? null
            : formattedTotalGamesBalance,
        "FormattedTotalTicketsBalance": formattedTotalTicketsBalance == null
            ? null
            : formattedTotalTicketsBalance,
        "FormattedTotalLoyaltyPointBalance":
            formattedTotalLoyaltyPointBalance == null
                ? null
                : formattedTotalLoyaltyPointBalance,
        "FormattedAccountExpiryDate": formattedAccountExpiryDate == null
            ? null
            : formattedAccountExpiryDate,
      };
}

// class GamePlayDtoList {
//     GamePlayDtoList({
//         this.gameplayId,
//         this.machineId,
//         this.cardId,
//         this.cardNumber,
//         this.credits,
//         this.courtesy,
//         this.bonus,
//         this.time,
//         this.playDate,
//         this.notes,
//         this.ticketCount,
//         this.ticketMode,
//         this.guid,
//         this.siteId,
//         this.synchStatus,
//         this.cardGame,
//         this.cpCardBalance,
//         this.cpCredits,
//         this.cpBonus,
//         this.cardGameId,
//         this.payoutCost,
//         this.masterEntityId,
//         this.multiGamePlayReference,
//         this.gamePriceTierInfo,
//         this.gamePlayInfoDtoList,
//         this.lastUpdatedDate,
//         this.lastUpdatedBy,
//         this.promotionId,
//         this.playRequestTime,
//         this.createdBy,
//         this.creationDate,
//         this.game,
//         this.machine,
//         this.eTickets,
//         this.manualTickets,
//         this.ticketEaterTickets,
//         this.mode,
//         this.site,
//         this.taskId,
//         this.externalSystemReference,
//         this.isChangedRecursive,
//         this.isChanged,
//     });

//     final num? gameplayId;
//     final num? machineId;
//     final num? cardId;
//     final dynamic cardNumber;
//     final num? credits;
//     final num? courtesy;
//     final num? bonus;
//     final num? time;
//     final DateTime? playDate;
//     final dynamic notes;
//     final num? ticketCount;
//     final dynamic ticketMode;
//     final dynamic guid;
//     final num? siteId;
//     final bool? synchStatus;
//     final num? cardGame;
//     final num? cpCardBalance;
//     final num? cpCredits;
//     final num? cpBonus;
//     final num? cardGameId;
//     final num? payoutCost;
//     final num? masterEntityId;
//     final dynamic multiGamePlayReference;
//     final dynamic gamePriceTierInfo;
//     final dynamic gamePlayInfoDtoList;
//     final DateTime? lastUpdatedDate;
//     final dynamic lastUpdatedBy;
//     final num? promotionId;
//     final dynamic playRequestTime;
//     final dynamic createdBy;
//     final DateTime? creationDate;
//     final String? game;
//     final String? machine;
//     final num? eTickets;
//     final num? manualTickets;
//     final num? ticketEaterTickets;
//     final String? mode;
//     final String? site;
//     final num? taskId;
//     final dynamic externalSystemReference;
//     final bool? isChangedRecursive;
//     final bool? isChanged;

//     factory GamePlayDtoList.fromJson(String str) => GamePlayDtoList.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory GamePlayDtoList.fromMap(Map<String, dynamic> json) => GamePlayDtoList(
//         gameplayId: json["GameplayId"] == null ? null : json["GameplayId"],
//         machineId: json["MachineId"] == null ? null : json["MachineId"],
//         cardId: json["CardId"] == null ? null : json["CardId"],
//         cardNumber: json["CardNumber"],
//         credits: json["Credits"] == null ? null : json["Credits"],
//         courtesy: json["Courtesy"] == null ? null : json["Courtesy"],
//         bonus: json["Bonus"] == null ? null : json["Bonus"],
//         time: json["Time"] == null ? null : json["Time"],
//         playDate: json["PlayDate"] == null ? null : DateTime.parse(json["PlayDate"]),
//         notes: json["Notes"],
//         ticketCount: json["TicketCount"] == null ? null : json["TicketCount"],
//         ticketMode: json["TicketMode"],
//         guid: json["Guid"],
//         siteId: json["SiteId"] == null ? null : json["SiteId"],
//         synchStatus: json["SynchStatus"] == null ? null : json["SynchStatus"],
//         cardGame: json["CardGame"] == null ? null : json["CardGame"],
//         cpCardBalance: json["CPCardBalance"] == null ? null : json["CPCardBalance"],
//         cpCredits: json["CPCredits"] == null ? null : json["CPCredits"],
//         cpBonus: json["CPBonus"] == null ? null : json["CPBonus"],
//         cardGameId: json["CardGameId"] == null ? null : json["CardGameId"],
//         payoutCost: json["PayoutCost"] == null ? null : json["PayoutCost"],
//         masterEntityId: json["MasterEntityId"] == null ? null : json["MasterEntityId"],
//         multiGamePlayReference: json["MultiGamePlayReference"],
//         gamePriceTierInfo: json["GamePriceTierInfo"],
//         gamePlayInfoDtoList: json["GamePlayInfoDTOList"],
//         lastUpdatedDate: json["LastUpdatedDate"] == null ? null : DateTime.parse(json["LastUpdatedDate"]),
//         lastUpdatedBy: json["LastUpdatedBy"],
//         promotionId: json["PromotionId"] == null ? null : json["PromotionId"],
//         playRequestTime: json["PlayRequestTime"],
//         createdBy: json["CreatedBy"],
//         creationDate: json["CreationDate"] == null ? null : DateTime.parse(json["CreationDate"]),
//         game: json["Game"] == null ? null : json["Game"],
//         machine: json["Machine"] == null ? null : json["Machine"],
//         eTickets: json["ETickets"] == null ? null : json["ETickets"],
//         manualTickets: json["ManualTickets"] == null ? null : json["ManualTickets"],
//         ticketEaterTickets: json["TicketEaterTickets"] == null ? null : json["TicketEaterTickets"],
//         mode: json["Mode"] == null ? null : json["Mode"],
//         site: json["Site"] == null ? null : json["Site"],
//         taskId: json["TaskId"] == null ? null : json["TaskId"],
//         externalSystemReference: json["ExternalSystemReference"],
//         isChangedRecursive: json["IsChangedRecursive"] == null ? null : json["IsChangedRecursive"],
//         isChanged: json["IsChanged"] == null ? null : json["IsChanged"],
//     );

//     Map<String, dynamic> toMap() => {
//         "GameplayId": gameplayId == null ? null : gameplayId,
//         "MachineId": machineId == null ? null : machineId,
//         "CardId": cardId == null ? null : cardId,
//         "CardNumber": cardNumber,
//         "Credits": credits == null ? null : credits,
//         "Courtesy": courtesy == null ? null : courtesy,
//         "Bonus": bonus == null ? null : bonus,
//         "Time": time == null ? null : time,
//         "PlayDate": playDate == null ? null : playDate!.toIso8601String(),
//         "Notes": notes,
//         "TicketCount": ticketCount == null ? null : ticketCount,
//         "TicketMode": ticketMode,
//         "Guid": guid,
//         "SiteId": siteId == null ? null : siteId,
//         "SynchStatus": synchStatus == null ? null : synchStatus,
//         "CardGame": cardGame == null ? null : cardGame,
//         "CPCardBalance": cpCardBalance == null ? null : cpCardBalance,
//         "CPCredits": cpCredits == null ? null : cpCredits,
//         "CPBonus": cpBonus == null ? null : cpBonus,
//         "CardGameId": cardGameId == null ? null : cardGameId,
//         "PayoutCost": payoutCost == null ? null : payoutCost,
//         "MasterEntityId": masterEntityId == null ? null : masterEntityId,
//         "MultiGamePlayReference": multiGamePlayReference,
//         "GamePriceTierInfo": gamePriceTierInfo,
//         "GamePlayInfoDTOList": gamePlayInfoDtoList,
//         "LastUpdatedDate": lastUpdatedDate == null ? null : lastUpdatedDate!.toIso8601String(),
//         "LastUpdatedBy": lastUpdatedBy,
//         "PromotionId": promotionId == null ? null : promotionId,
//         "PlayRequestTime": playRequestTime,
//         "CreatedBy": createdBy,
//         "CreationDate": creationDate == null ? null : creationDate!.toIso8601String(),
//         "Game": game == null ? null : game,
//         "Machine": machine == null ? null : machine,
//         "ETickets": eTickets == null ? null : eTickets,
//         "ManualTickets": manualTickets == null ? null : manualTickets,
//         "TicketEaterTickets": ticketEaterTickets == null ? null : ticketEaterTickets,
//         "Mode": mode == null ? null : mode,
//         "Site": site == null ? null : site,
//         "TaskId": taskId == null ? null : taskId,
//         "ExternalSystemReference": externalSystemReference,
//         "IsChangedRecursive": isChangedRecursive == null ? null : isChangedRecursive,
//         "IsChanged": isChanged == null ? null : isChanged,
//     };
// }
