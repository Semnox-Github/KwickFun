class CustomDataDTO {
  CustomDataDTO(
      {int? customDataId,
      int? customDataSetId,
      int? customAttributeId,
      int? valueId,
      String? customDataText,
      int? customDataNumber,
      DateTime? customDataDate,
      String? createdBy,
      DateTime? creationDate,
      String? lastUpdatedBy,
      DateTime? lastUpdateDate,
      int? siteId,
      int? masterEntityId,
      bool? synchStatus,
      String? guid,
      bool? isChanged}) {
    _customDataId = customDataId;
    _customDataSetId = customDataSetId;
    _customAttributeId = customAttributeId;
    _valueId = valueId;
    _customDataText = customDataText;
    _customDataNumber = customDataNumber;
    _customDataDate = customDataDate;
    _createdBy = createdBy;
    _creationDate = creationDate;
    _lastUpdatedBy = lastUpdatedBy;
    _lastUpdateDate = lastUpdateDate;
    _siteId = siteId;
    _masterEntityId = masterEntityId;
    _synchStatus = synchStatus;
    _guid = guid;
    _isChanged = isChanged;
  }

  int? get customDataId => _customDataId;
  int? get customDataSetId => _customDataSetId;
  int? get customAttributeId => _customAttributeId;
  int? get valueId => _valueId;
  String? get customDataText => _customDataText;
  int? get customDataNumber => _customDataNumber;
  DateTime? get customDataDate => _customDataDate;
  String? get createdBy => _createdBy;
  DateTime? get creationDate => _creationDate;
  String? get lastUpdatedBy => _lastUpdatedBy;
  DateTime? get lastUpdateDate => _lastUpdateDate;
  int? get siteId => _siteId;
  int? get masterEntityId => _masterEntityId;
  bool? get synchStatus => _synchStatus;
  String? get guid => _guid;
  bool? get isChanged => _isChanged;

  int? _customDataId;
  int? _customDataSetId;
  int? _customAttributeId;
  int? _valueId;
  String? _customDataText;
  int? _customDataNumber;
  DateTime? _customDataDate;
  String? _createdBy;
  DateTime? _creationDate;
  String? _lastUpdatedBy;
  DateTime? _lastUpdateDate;
  int? _siteId;
  int? _masterEntityId;
  bool? _synchStatus;
  String? _guid;
  bool? _isChanged;

  factory CustomDataDTO.fromJson(Map<String, dynamic> json) => CustomDataDTO(
        customDataId: json["CustomDataId"],
        customDataSetId: json["CustomDataSetId"],
        customAttributeId: json["CustomAttributeId"],
        valueId: json["ValueId"],
        customDataText: json["CustomDataText"],
        customDataNumber: json["CustomDataNumber"],
        customDataDate: json["CustomDataDate"],
        createdBy: json["CreatedBy"],
        creationDate: DateTime.parse(json["CreationDate"]),
        lastUpdatedBy: json["LastUpdatedBy"],
        lastUpdateDate: DateTime.parse(json["LastUpdateDate"]),
        siteId: json["SiteId"],
        masterEntityId: json["MasterEntityId"],
        synchStatus: json["SynchStatus"],
        guid: json["Guid"],
        isChanged: json["IsChanged"],
      );

  Map<String, dynamic> toJson() => {
        "CustomDataId": customDataId,
        "CustomDataSetId": customDataSetId,
        "CustomAttributeId": customAttributeId,
        "ValueId": valueId,
        "CustomDataText": customDataText,
        "CustomDataNumber": customDataNumber,
        "CustomDataDate": customDataDate,
        "CreatedBy": createdBy,
        "CreationDate": creationDate?.toIso8601String(),
        "LastUpdatedBy": lastUpdatedBy,
        "LastUpdateDate": lastUpdateDate?.toIso8601String(),
        "SiteId": siteId,
        "MasterEntityId": masterEntityId,
        "SynchStatus": synchStatus,
        "Guid": guid,
        "IsChanged": isChanged,
      };
}
