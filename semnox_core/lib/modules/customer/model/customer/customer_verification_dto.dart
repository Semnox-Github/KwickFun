import 'package:semnox_core/modules/customer/model/customer/profile_dto.dart';

class CustomerVerificationDTO {
  CustomerVerificationDTO(
      {int? id,
      int? customerId,
      int? profileId,
      String? source,
      String? verificationCode,
      String? expiryDate,
      bool? isActive,
      String? createdBy,
      DateTime? creationDate,
      String? lastUpdatedBy,
      DateTime? lastUpdateDate,
      int? siteId,
      int? masterEntityId,
      String? guid,
      ProfileDTO? profileDTO}) {
    _id = id;
    _customerId = customerId;
    _profileId = profileId;
    _source = source;
    _verificationCode = verificationCode;
    _expiryDate = expiryDate;
    _isActive = isActive;
    _createdBy = createdBy;
    _creationDate = creationDate;
    _lastUpdatedBy = lastUpdatedBy;
    _lastUpdateDate = lastUpdateDate;
    _siteId = siteId;
    _masterEntityId = masterEntityId;
    _guid = guid;
    _profileDTO = profileDTO;
  }

  int? get id => _id;
  int? get customerId => _customerId;
  int? get profileId => _profileId;
  String? get source => _source;
  String? get verificationCode => _verificationCode;
  String? get expiryDate => _expiryDate;
  bool? get isActive => _isActive;
  String? get createdBy => _createdBy;
  DateTime? get creationDate => _creationDate;
  String? get lastUpdatedBy => _lastUpdatedBy;
  DateTime? get lastUpdateDate => _lastUpdateDate;
  int? get siteId => _siteId;
  int? get masterEntityId => _masterEntityId;
  String? get guid => _guid;
  ProfileDTO? get profileDTO => _profileDTO;

  int? _id;
  int? _customerId;
  int? _profileId;
  String? _source;
  String? _verificationCode;
  String? _expiryDate;
  bool? _isActive;
  String? _createdBy;
  DateTime? _creationDate;
  String? _lastUpdatedBy;
  DateTime? _lastUpdateDate;
  int? _siteId;
  int? _masterEntityId;
  String? _guid;
  ProfileDTO? _profileDTO;

  factory CustomerVerificationDTO.fromJson(Map<String, dynamic> json) =>
      CustomerVerificationDTO(
          id: json["Id"],
          customerId: json["CustomerId"],
          profileId: json["ProfileId"],
          source: json["Source"],
          verificationCode: json["VerificationCode"],
          expiryDate: json["ExpiryDate"],
          isActive: json["IsActive"],
          createdBy: json["CreatedBy"],
          creationDate: DateTime.parse(json["CreationDate"]),
          lastUpdatedBy: json["LastUpdatedBy"],
          lastUpdateDate: DateTime.parse(json["LastUpdateDate"]),
          siteId: json["SiteId"],
          masterEntityId: json["MasterEntityId"],
          guid: json["Guid"],
          profileDTO: ProfileDTO.fromJson(json["ProfileDTO"]));

  Map<String, dynamic> toJson() => {
        "Id": id,
        "CustomerId": customerId,
        "ProfileId": profileId,
        "Source": source,
        "VerificationCode": verificationCode,
        "ExpiryDate": expiryDate,
        "IsActive": isActive,
        "CreatedBy": createdBy,
        "CreationDate": creationDate?.toIso8601String(),
        "LastUpdatedBy": lastUpdatedBy,
        "LastUpdateDate": lastUpdateDate?.toIso8601String(),
        "SiteId": siteId,
        "MasterEntityId": masterEntityId,
        "Guid": guid,
        "ProfileDTO": profileDTO?.toJson()
      };
}
