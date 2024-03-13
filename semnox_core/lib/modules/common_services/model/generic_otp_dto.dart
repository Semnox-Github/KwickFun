class GenericOtpDTO {
  GenericOtpDTO(
      {int? id,
      String? code,
      String? phone,
      String? countryCode,
      String? emailId,
      String? source,
      bool? isVerified,
      int? remainingAttempts,
      String? expirytime,
      String? guid,
      bool? isActive,
      int? siteId,
      bool? synchStatus,
      int? masterEntityId,
      String? lastUpdatedby,
      String? lastUpdateDate,
      String? creationDate,
      String? createdBy,
      bool? isChanged}) {
    _id = id;
    _code = code;
    _phone = phone;
    _countryCode = countryCode;
    _emailId = emailId;
    _source = source;
    _isVerified = isVerified;
    _remainingAttempts = remainingAttempts;
    _expirytime = expirytime;
    _guid = guid;
    _isActive = isActive;
    _siteId = siteId;
    _synchStatus = synchStatus;
    _masterEntityId = masterEntityId;
    _lastUpdatedby = lastUpdatedby;
    _lastUpdateDate = lastUpdateDate;
    _creationDate = creationDate;
    _createdBy = createdBy;
    _isChanged = isChanged;
  }

  int? _id;
  String? _code;
  String? _phone;
  String? _countryCode;
  String? _emailId;
  String? _source;
  bool? _isVerified;
  int? _remainingAttempts;
  String? _expirytime;
  String? _guid;
  bool? _isActive;
  int? _siteId;
  bool? _synchStatus;
  int? _masterEntityId;
  String? _lastUpdatedby;
  String? _lastUpdateDate;
  String? _creationDate;
  String? _createdBy;
  bool? _isChanged;

  int? get id => _id;
  String? get code => _code;
  String? get phone => _phone;
  String? get countryCode => _countryCode;
  String? get emailId => _emailId;
  String? get source => _source;
  bool? get isVerified => _isVerified;
  int? get remainingAttempts => _remainingAttempts;
  String? get expirytime => _expirytime;
  String? get guid => _guid;
  bool? get isActive => _isActive;
  int? get siteId => _siteId;
  bool? get synchStatus => _synchStatus;
  int? get masterEntityId => _masterEntityId;
  String? get lastUpdatedby => _lastUpdatedby;
  String? get lastUpdateDate => _lastUpdateDate;
  String? get creationDate => _creationDate;
  String? get createdBy => _createdBy;
  bool? get isChanged => _isChanged;

  factory GenericOtpDTO.fromJson(Map<String, dynamic> json) => GenericOtpDTO(
      id: json["Id"],
      code: json["Code"],
      phone: json["Phone"],
      countryCode: json["CountryCode"],
      emailId: json["EmailId"],
      source: json["Source"],
      isVerified: json["IsVerified"],
      remainingAttempts: json["RemainingAttempts"],
      expirytime: json["ExpiryTime"],
      guid: json["guid"],
      isActive: json["IsActive"],
      siteId: json["SiteId"],
      synchStatus: json["SynchStatus"],
      masterEntityId: json["MasterEntityId"],
      lastUpdatedby: json["LastUpdatedby"],
      lastUpdateDate: json["LastUpdateDate"],
      creationDate: json["CreationDate"],
      createdBy: json["CreatedBy"],
      isChanged: json["IsChanged"]);

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Code": code,
        "Phone": phone,
        "CountryCode": countryCode,
        "EmailId": emailId,
        "Source": source,
        "IsVerified": isVerified,
        "RemainingAttempts": remainingAttempts,
        "Expirytime": expirytime,
        "Guid": guid,
        "IsActive": isActive,
        "SiteId": siteId,
        "SynchStatus": synchStatus,
        "MasterEntityId": masterEntityId,
        "LastUpdatedby": lastUpdatedby,
        "LastUpdateDate": lastUpdateDate,
        "CreationDate": creationDate,
        "CreatedBy": createdBy,
        "IsChanged": isChanged
      };
}
