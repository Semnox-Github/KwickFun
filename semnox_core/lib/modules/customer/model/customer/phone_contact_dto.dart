class PhoneContactDTO {
  PhoneContactDTO(
      {int? id,
      int? profileId,
      int? addressId,
      int? countryId,
      int? contactSubTypeId,
      int? contactTypeId,
      int? contactType,
      int? contactSubType,
      String? attribute1,
      String? attribute2,
      bool? isActive,
      bool? isDefault,
      String? createdBy,
      DateTime? creationDate,
      String? lastUpdatedBy,
      DateTime? lastUpdateDate,
      int? siteId,
      int? masterEntityId,
      bool? synchStatus,
      String? guid,
      String? uuid,
      bool? whatsAppEnabled,
      bool? isChanged}) {
    _id = id;
    _profileId = profileId;
    _addressId = addressId;
    _countryId = countryId;
    _contactSubTypeId = contactSubTypeId;
    _contactTypeId = contactTypeId;
    _contactType = contactType;
    _contactSubType = contactSubType;
    _attribute1 = attribute1;
    _attribute2 = attribute2;
    _isActive = isActive;
    _isDefault = isDefault;
    _createdBy = createdBy;
    _creationDate = creationDate;
    _lastUpdatedBy = lastUpdatedBy;
    _lastUpdateDate = lastUpdateDate;
    _siteId = siteId;
    _masterEntityId = masterEntityId;
    _synchStatus = synchStatus;
    _guid = guid;
    _uuid = uuid;
    _whatsAppEnabled = whatsAppEnabled;
    _isChanged = isChanged;
  }

  int? get id => _id;
  int? get profileId => _profileId;
  int? get addressId => _addressId;
  int? get countryId => _countryId;
  int? get contactSubTypeId => _contactSubTypeId;
  int? get contactTypeId => _contactTypeId;
  int? get contactType => _contactType;
  int? get contactSubType => _contactSubType;
  String? get attribute1 => _attribute1;
  String? get attribute2 => _attribute2;
  bool? get isActive => _isActive;
  bool? get isDefault => _isDefault;
  String? get createdBy => _createdBy;
  DateTime? get creationDate => _creationDate;
  String? get lastUpdatedBy => _lastUpdatedBy;
  DateTime? get lastUpdateDate => _lastUpdateDate;
  int? get siteId => _siteId;
  int? get masterEntityId => _masterEntityId;
  bool? get synchStatus => _synchStatus;
  String? get guid => _guid;
  String? get uuid => _uuid;
  bool? get whatsAppEnabled => _whatsAppEnabled;
  bool? get isChanged => _isChanged;

  int? _id;
  int? _profileId;
  int? _addressId;
  int? _countryId;
  int? _contactSubTypeId;
  int? _contactTypeId;
  int? _contactType;
  int? _contactSubType;
  String? _attribute1;
  String? _attribute2;
  bool? _isActive;
  bool? _isDefault;
  String? _createdBy;
  DateTime? _creationDate;
  String? _lastUpdatedBy;
  DateTime? _lastUpdateDate;
  int? _siteId;
  int? _masterEntityId;
  bool? _synchStatus;
  String? _guid;
  String? _uuid;
  bool? _whatsAppEnabled;
  bool? _isChanged;

  factory PhoneContactDTO.fromJson(Map<String, dynamic> json) =>
      PhoneContactDTO(
        id: json["Id"],
        profileId: json["ProfileId"],
        addressId: json["AddressId"],
        countryId: json["CountryId"],
        contactSubTypeId: json["ContactSubTypeId"],
        contactTypeId: json["ContactTypeId"],
        contactType: json["ContactType"],
        contactSubType: json["ContactSubType"],
        attribute1: json["Attribute1"],
        attribute2: json["Attribute2"],
        isActive: json["IsActive"],
        isDefault: json["IsDefault"],
        createdBy: json["CreatedBy"],
        creationDate: DateTime.parse(json["CreationDate"]),
        lastUpdatedBy: json["LastUpdatedBy"],
        lastUpdateDate: DateTime.parse(json["LastUpdateDate"]),
        siteId: json["SiteId"],
        masterEntityId: json["MasterEntityId"],
        synchStatus: json["SynchStatus"],
        guid: json["Guid"],
        uuid: json["UUID"],
        whatsAppEnabled: json["WhatsAppEnabled"],
        isChanged: json["IsChanged"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ProfileId": profileId,
        "AddressId": addressId,
        "CountryId": countryId,
        "ContactSubTypeId": contactSubTypeId,
        "ContactTypeId": contactTypeId,
        "ContactType": contactType,
        "ContactSubType": contactSubType,
        "Attribute1": attribute1,
        "Attribute2": attribute2,
        "IsActive": isActive,
        "IsDefault": isDefault,
        "CreatedBy": createdBy,
        "CreationDate": creationDate?.toIso8601String(),
        "LastUpdatedBy": lastUpdatedBy,
        "LastUpdateDate": lastUpdateDate?.toIso8601String(),
        "SiteId": siteId,
        "MasterEntityId": masterEntityId,
        "SynchStatus": synchStatus,
        "Guid": guid,
        "UUID": uuid,
        "WhatsAppEnabled": whatsAppEnabled,
        "IsChanged": isChanged,
      };
}
