import 'package:semnox_core/modules/customer/model/customer/custom_data_dto.dart';

class CustomDataSetDTO {
  CustomDataSetDTO(
      {int? customDataSetId,
      String? dummy,
      String? createdBy,
      DateTime? creationDate,
      String? lastUpdatedBy,
      DateTime? lastUpdateDate,
      int? siteId,
      int? masterEntityId,
      bool? synchStatus,
      String? guid,
      bool? isChanged,
      bool? isChangedRecursive,
      List<CustomDataDTO>? customDataDtoList}) {
    _customDataSetId = customDataSetId;
    _dummy = dummy;
    _createdBy = createdBy;
    _creationDate = creationDate;
    _lastUpdatedBy = lastUpdatedBy;
    _lastUpdateDate = lastUpdateDate;
    _siteId = siteId;
    _masterEntityId = masterEntityId;
    _synchStatus = synchStatus;
    _guid = guid;
    _isChanged = isChanged;
    _isChangedRecursive = isChangedRecursive;
    _customDataDtoList = customDataDtoList;
  }

  int? get customDataSetId => _customDataSetId;
  String? get dummy => _dummy;
  String? get createdBy => _createdBy;
  DateTime? get creationDate => _creationDate;
  String? get lastUpdatedBy => _lastUpdatedBy;
  DateTime? get lastUpdateDate => _lastUpdateDate;
  int? get siteId => _siteId;
  int? get masterEntityId => _masterEntityId;
  bool? get synchStatus => _synchStatus;
  String? get guid => _guid;
  bool? get isChanged => _isChanged;
  bool? get isChangedRecursive => _isChangedRecursive;
  List<CustomDataDTO>? get customDataDtoList => _customDataDtoList;

  int? _customDataSetId;
  String? _dummy;
  String? _createdBy;
  DateTime? _creationDate;
  String? _lastUpdatedBy;
  DateTime? _lastUpdateDate;
  int? _siteId;
  int? _masterEntityId;
  bool? _synchStatus;
  String? _guid;
  bool? _isChanged;
  bool? _isChangedRecursive;
  List<CustomDataDTO>? _customDataDtoList;

  factory CustomDataSetDTO.fromJson(Map<String, dynamic> json) =>
      CustomDataSetDTO(
        customDataSetId: json["CustomDataSetId"],
        dummy: json["Dummy"],
        createdBy: json["CreatedBy"],
        creationDate: DateTime.parse(json["CreationDate"]),
        lastUpdatedBy: json["LastUpdatedBy"],
        lastUpdateDate: DateTime.parse(json["LastUpdateDate"]),
        siteId: json["SiteId"],
        masterEntityId: json["MasterEntityId"],
        synchStatus: json["SynchStatus"],
        guid: json["Guid"],
        isChanged: json["IsChanged"],
        isChangedRecursive: json["IsChangedRecursive"],
        customDataDtoList: List<CustomDataDTO>.from(
            json["CustomDataDTOList"].map((x) => CustomDataDTO.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CustomDataSetId": customDataSetId,
        "Dummy": dummy,
        "CreatedBy": createdBy,
        "CreationDate": creationDate?.toIso8601String(),
        "LastUpdatedBy": lastUpdatedBy,
        "LastUpdateDate": lastUpdateDate?.toIso8601String(),
        "SiteId": siteId,
        "MasterEntityId": masterEntityId,
        "SynchStatus": synchStatus,
        "Guid": guid,
        "IsChanged": isChanged,
        "IsChangedRecursive": isChangedRecursive,
        "CustomDataDTOList":
            List<CustomDataDTO>.from(customDataDtoList!.map((x) => x.toJson())),
      };
}
