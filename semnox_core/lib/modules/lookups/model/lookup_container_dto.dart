class LookupsContainerDTO {
  int? _lookupId;
  String? _lookupName;
  String? _isProtected;
  List<LookupValuesContainerDtoList>? _lookupValuesContainerDtoList;

  LookupsContainerDTO(
      {int? lookupId,
      String? lookupName,
      String? isProtected,
      List<LookupValuesContainerDtoList>? lookupValuesContainerDtoList}) {
    _lookupId = lookupId;
    _lookupName = lookupName;
    _isProtected = isProtected;
    _lookupValuesContainerDtoList = lookupValuesContainerDtoList;
  }

  int? get lookupId => _lookupId;
  String? get lookupName => _lookupName;
  String? get isProtected => _isProtected;
  List<LookupValuesContainerDtoList>? get lookupValuesContainerDtoList =>
      _lookupValuesContainerDtoList;

  set lookupId(int? lookupId) {
    _lookupId = lookupId;
  }

  set lookupName(String? lookupName) {
    _lookupName = lookupName;
  }

  set isProtected(String? isProtected) {
    _isProtected = isProtected;
  }

  set lookupValuesContainerDtoList(
      List<LookupValuesContainerDtoList>? lookupValuesContainerDtoList) {
    _lookupValuesContainerDtoList = lookupValuesContainerDtoList;
  }

  factory LookupsContainerDTO.fromMap(Map<String, dynamic> json) =>
      LookupsContainerDTO(
        lookupId: json["LookupId"],
        lookupName: json["LookupName"],
        isProtected: json["IsProtected"],
        lookupValuesContainerDtoList: List<LookupValuesContainerDtoList>.from(
            json["LookupValuesContainerDTOList"]
                .map((x) => LookupValuesContainerDtoList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "LookupId": lookupId,
        "LookupName": lookupName,
        "IsProtected": isProtected,
        "LookupValuesContainerDTOList": List<dynamic>.from(
            lookupValuesContainerDtoList!.map((x) => x.toMap())),
      };

  static List<LookupsContainerDTO>? getLookupContainerDTOList(List? dtoList) {
    if (dtoList == null) {
      return null;
    }
    List<LookupsContainerDTO> lookupsContainerDTOList = [];
    lookupsContainerDTOList = List<LookupsContainerDTO>.from(
        dtoList.map((x) => LookupsContainerDTO.fromMap(x)));
    return lookupsContainerDTOList;
  }
}

class LookupValuesContainerDtoList {
  LookupValuesContainerDtoList(
      {int? lookupValueId,
      String? lookupValue,
      String? description,
      String? lookupName}) {
    _lookupValueId = lookupValueId;
    _lookupValue = lookupValue;
    _description = description;
    _lookupName = lookupName;
  }

  int? _lookupValueId;
  String? _lookupValue;
  String? _description;
  String? _lookupName;

  int? get lookupValueId => _lookupValueId;
  String? get lookupValue => _lookupValue;
  String? get description => _description;
  String? get lookupName => _lookupName;

  set lookupValueId(int? lookupValueId) {
    _lookupValueId = lookupValueId;
  }

  set lookupValue(String? lookupValue) {
    _lookupValue = lookupValue;
  }

  set description(String? description) {
    _description = description;
  }

  set lookupName(String? lookupName) {
    _lookupName = lookupName;
  }

  // LookupValuesContainerDtoList copyWith({
  //   int? lookupValueId,
  //   String? lookupValue,
  //   String? description,
  //   String? lookupName,
  // }) =>
  //     LookupValuesContainerDtoList(
  //       lookupValueId: lookupValueId ?? this.lookupValueId,
  //       lookupValue: lookupValue ?? this.lookupValue,
  //       description: description ?? this.description,
  //       lookupName: lookupName ?? this.lookupName,
  //     );

  factory LookupValuesContainerDtoList.fromMap(Map<String, dynamic> json) =>
      LookupValuesContainerDtoList(
        lookupValueId: json["LookupValueId"],
        lookupValue: json["LookupValue"],
        description: json["Description"],
        lookupName: json["LookupName"],
      );

  Map<String, dynamic> toMap() => {
        "LookupValueId": lookupValueId,
        "LookupValue": lookupValue,
        "Description": description,
        "LookupName": lookupName,
      };
}

enum LookUpViewDTOSearchParameter { HASH, REBUILDCACHE, SITEID } // Id