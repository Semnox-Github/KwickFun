import 'package:semnox_core/modules/customer/model/customer/phone_contact_dto.dart';

class AddressDTO {
  AddressDTO(
      {int? id,
      int? profileId,
      int? addressTypeId,
      int? addressType,
      String? line1,
      String? line2,
      String? line3,
      String? city,
      int? stateId,
      int? countryId,
      String? postalCode,
      String? stateCode,
      String? stateName,
      String? countryName,
      bool? isActive,
      String? createdBy,
      DateTime? creationDate,
      String? lastUpdatedBy,
      DateTime? lastUpdateDate,
      int? siteId,
      int? masterEntityId,
      bool? synchStatus,
      String? guid,
      bool? isDefault,
      List<PhoneContactDTO>? contactDtoList,
      bool? isChanged,
      bool? isChangedRecursive}) {
    _id = id;
    _profileId = profileId;
    _addressTypeId = addressTypeId;
    _addressType = addressType;
    _line1 = line1;
    _line2 = line2;
    _line3 = line3;
    _city = city;
    _stateId = stateId;
    _countryId = countryId;
    _postalCode = postalCode;
    _stateCode = stateCode;
    _stateName = stateName;
    _countryName = countryName;
    _isActive = isActive;
    _createdBy = createdBy;
    _creationDate = creationDate;
    _lastUpdatedBy = lastUpdatedBy;
    _lastUpdateDate = lastUpdateDate;
    _siteId = siteId;
    _masterEntityId = masterEntityId;
    _synchStatus = synchStatus;
    _guid = guid;
    _isDefault = isDefault;
    _contactDtoList = contactDtoList;
    _isChanged = isChanged;
    _isChangedRecursive = isChangedRecursive;
  }

  int? get id => _id;
  int? get profileId => _profileId;
  int? get addressTypeId => _addressTypeId;
  int? get addressType => _addressType;
  String? get line1 => _line1;
  String? get line2 => _line2;
  String? get line3 => _line3;
  String? get city => _city;
  int? get stateId => _stateId;
  int? get countryId => _countryId;
  String? get postalCode => _postalCode;
  String? get stateCode => _stateCode;
  String? get stateName => _stateName;
  String? get countryName => _countryName;
  bool? get isActive => _isActive;
  String? get createdBy => _createdBy;
  DateTime? get creationDate => _creationDate;
  String? get lastUpdatedBy => _lastUpdatedBy;
  DateTime? get lastUpdateDate => _lastUpdateDate;
  int? get siteId => _siteId;
  int? get masterEntityId => _masterEntityId;
  bool? get synchStatus => _synchStatus;
  String? get guid => _guid;
  bool? get isDefault => _isDefault;
  List<PhoneContactDTO>? get contactDtoList => _contactDtoList;
  bool? get isChanged => _isChanged;
  bool? get isChangedRecursive => _isChangedRecursive;

  int? _id;
  int? _profileId;
  int? _addressTypeId;
  int? _addressType;
  String? _line1;
  String? _line2;
  String? _line3;
  String? _city;
  int? _stateId;
  int? _countryId;
  String? _postalCode;
  String? _stateCode;
  String? _stateName;
  String? _countryName;
  bool? _isActive;
  String? _createdBy;
  DateTime? _creationDate;
  String? _lastUpdatedBy;
  DateTime? _lastUpdateDate;
  int? _siteId;
  int? _masterEntityId;
  bool? _synchStatus;
  String? _guid;
  bool? _isDefault;
  List<PhoneContactDTO>? _contactDtoList;
  bool? _isChanged;
  bool? _isChangedRecursive;

  factory AddressDTO.fromJson(Map<String, dynamic> json) => AddressDTO(
        id: json["Id"],
        profileId: json["ProfileId"],
        addressTypeId: json["AddressTypeId"],
        addressType: json["AddressType"],
        line1: json["Line1"],
        line2: json["Line2"],
        line3: json["Line3"],
        city: json["City"],
        stateId: json["StateId"],
        countryId: json["CountryId"],
        postalCode: json["PostalCode"],
        stateCode: json["StateCode"],
        stateName: json["StateName"],
        countryName: json["CountryName"],
        isActive: json["IsActive"],
        createdBy: json["CreatedBy"],
        creationDate: DateTime.parse(json["CreationDate"]),
        lastUpdatedBy: json["LastUpdatedBy"],
        lastUpdateDate: DateTime.parse(json["LastUpdateDate"]),
        siteId: json["SiteId"],
        masterEntityId: json["MasterEntityId"],
        synchStatus: json["SynchStatus"],
        guid: json["Guid"],
        isDefault: json["IsDefault"],
        contactDtoList:
            List<PhoneContactDTO>.from(json["ContactDTOList"].map((x) => x)),
        isChanged: json["IsChanged"],
        isChangedRecursive: json["IsChangedRecursive"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ProfileId": profileId,
        "AddressTypeId": addressTypeId,
        "AddressType": addressType,
        "Line1": line1,
        "Line2": line2,
        "Line3": line3,
        "City": city,
        "StateId": stateId,
        "CountryId": countryId,
        "PostalCode": postalCode,
        "StateCode": stateCode,
        "StateName": stateName,
        "CountryName": countryName,
        "IsActive": isActive,
        "CreatedBy": createdBy,
        "CreationDate": creationDate?.toIso8601String(),
        "LastUpdatedBy": lastUpdatedBy,
        "LastUpdateDate": lastUpdateDate?.toIso8601String(),
        "SiteId": siteId,
        "MasterEntityId": masterEntityId,
        "SynchStatus": synchStatus,
        "Guid": guid,
        "IsDefault": isDefault,
        "ContactDTOList":
            List<PhoneContactDTO>.from(contactDtoList!.map((x) => x)),
        "IsChanged": isChanged,
        "IsChangedRecursive": isChangedRecursive,
      };
}
