class ParafaitDefaultValueDto {
  String? _name;
  String? _value;
  ParafaitDefaultValueDto({String? name, String? value}) {
    _name = name;
    _value = value;
  }

  String? get name => _name;
  String? get value => _value;

  Map<String, dynamic> toMap() {
    return {
      'DefaultValueName': name,
      'DefaultValue': value,
    };
  }

  factory ParafaitDefaultValueDto.fromMap(Map<String, dynamic> map) {
    return ParafaitDefaultValueDto(
      name: map['DefaultValueName'],
      value: map['DefaultValue'],
    );
  }

  static List<ParafaitDefaultValueDto>? getParafaitDefaultDTOList(
      List? dtoList) {
    if (dtoList == null) {
      return null;
    }
    List<ParafaitDefaultValueDto> parafaitDefaultValueDtoList = [];
    parafaitDefaultValueDtoList = List<ParafaitDefaultValueDto>.from(
        dtoList.map((x) => ParafaitDefaultValueDto.fromMap(x)));
    return parafaitDefaultValueDtoList;
  }

  static dynamic getListMap(List<dynamic> items) {
    if (items == null) {
      return null;
    }
    List<Map<String, dynamic>> list = [];
    for (var element in items) {
      list.add(element.toMap());
    }
    return list;
  }
}

enum ParafaitDefaultValueDTOSearchParameter { hash, rebuildcache, siteId } // Id
