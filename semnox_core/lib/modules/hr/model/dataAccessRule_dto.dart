class DataAccessRuleDto {
  DataAccessRuleDto(
      {int? dataAccessRuleId,
      String? name,
      bool? isActive,
      String? createdBy,
      String? creationDate,
      String? lastUpdatedBy,
      String? lastUpdatedDate,
      String? guid,
      int? siteId,
      bool? synchStatus,
      int? masterEntityId,
      dynamic dataAccessDetailDtoList,
      bool? isChangedRecursive,
      bool? isChanged}) {
    _dataAccessRuleId = dataAccessRuleId;
    _name = name;
    _isActive = isActive;
    _createdBy = createdBy;
    _creationDate = creationDate;
    _lastUpdatedBy = lastUpdatedBy;
    _lastUpdatedDate = lastUpdatedDate;
    _guid = guid;
    _siteId = siteId;
    _synchStatus = synchStatus;
    _masterEntityId = masterEntityId;
    _dataAccessDetailDtoList = dataAccessDetailDtoList;
    _isChangedRecursive = isChangedRecursive;
    _isChanged = isChanged;
  }

  int? _dataAccessRuleId;
  String? _name;
  bool? _isActive;
  String? _createdBy;
  String? _creationDate;
  String? _lastUpdatedBy;
  String? _lastUpdatedDate;
  String? _guid;
  int? _siteId;
  bool? _synchStatus;
  int? _masterEntityId;
  dynamic _dataAccessDetailDtoList;
  bool? _isChangedRecursive;
  bool? _isChanged;

  int? get dataAccessRuleId => _dataAccessRuleId;
  String? get name => _name;
  bool? get isActive => _isActive;
  String? get createdBy => _createdBy;
  String? get creationDate => _creationDate;
  String? get lastUpdatedBy => _lastUpdatedBy;
  String? get lastUpdatedDate => _lastUpdatedDate;
  String? get guid => _guid;
  int? get siteId => _siteId;
  bool? get synchStatus => _synchStatus;
  int? get masterEntityId => _masterEntityId;
  dynamic get dataAccessDetailDtoList => _dataAccessDetailDtoList;
  bool? get isChangedRecursive => _isChangedRecursive;
  bool? get isChanged => _isChanged;

  factory DataAccessRuleDto.fromJson(Map<String, dynamic> json) =>
      DataAccessRuleDto(
        dataAccessRuleId: json["DataAccessRuleId"],
        name: json["Name"],
        isActive: json["IsActive"],
        createdBy: json["CreatedBy"],
        creationDate: json["CreationDate"],
        lastUpdatedBy: json["LastUpdatedBy"],
        lastUpdatedDate: json["LastUpdatedDate"],
        guid: json["Guid"],
        siteId: json["SiteId"],
        synchStatus: json["SynchStatus"],
        masterEntityId: json["MasterEntityId"],
        dataAccessDetailDtoList: json["DataAccessDetailDTOList"],
        isChangedRecursive: json["IsChangedRecursive"],
        isChanged: json["IsChanged"],
      );

  Map<String, dynamic> toJson() => {
        "DataAccessRuleId": dataAccessRuleId,
        "Name": name,
        "IsActive": isActive,
        "CreatedBy": createdBy,
        "CreationDate": creationDate,
        "LastUpdatedBy": lastUpdatedBy,
        "LastUpdatedDate": lastUpdatedDate,
        "Guid": guid,
        "SiteId": siteId,
        "SynchStatus": synchStatus,
        "MasterEntityId": masterEntityId,
        "DataAccessDetailDTOList": dataAccessDetailDtoList,
        "IsChangedRecursive": isChangedRecursive,
        "IsChanged": isChanged,
      };
}
