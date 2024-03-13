class AuthenticateResponseDTO {
  String? _posMachineGuid;
  String? _webApiToken;
  String? _token;
  int? _languageId;
  bool? _isCorporate;
  int? _userPkId;
  int? _userRoleId;
  int? _machineId;
  int? _siteId;
  int? _sitePkId;
  String? _userId;
  String? _posMachineName;
  String? _languageCode;

  AuthenticateResponseDTO(
      {String? posMachineGuid,
      String? webApiToken,
      String? token,
      int? languageId,
      bool? isCorporate,
      int? userPkId,
      int? userRoleId,
      int? machineId,
      int? siteId,
      int? sitePkId,
      String? userId,
      String? posMachineName,
      String? languageCode}) {
    _posMachineGuid = posMachineGuid;
    _webApiToken = webApiToken;
    _token = token;
    _languageId = languageId;
    _isCorporate = isCorporate;
    _userPkId = userPkId;
    _userRoleId = userRoleId;
    _machineId = machineId;
    _siteId = siteId;
    _sitePkId = sitePkId;
    _userId = userId;
    _posMachineName = posMachineName;
    _languageCode = languageCode;
  }

  String? get posMachineGuid => _posMachineGuid;
  String? get webApiToken => _webApiToken;
  String? get token => _token;
  int? get languageId => _languageId;
  bool? get isCorporate => _isCorporate;
  int? get userPkId => _userPkId;
  int? get userRoleId => _userRoleId;
  int? get machineId => _machineId;
  int? get siteId => _siteId;
  int? get sitePkId => _sitePkId;
  String? get userId => _userId;
  String? get posMachineName => _posMachineName;
  String? get languageCode => _languageCode;

  factory AuthenticateResponseDTO.fromJson(Map<String, dynamic> json) =>
      AuthenticateResponseDTO(
          posMachineGuid: json["PosMachineGuid"],
          webApiToken: json["WebApiToken"],
          token: json["Token"],
          languageId: json["LanguageId"],
          isCorporate: json["IsCorporate"],
          userPkId: json["UserPKId"],
          userRoleId: json["UserRoleId"],
          machineId: json["MachineId"],
          siteId: json["SiteId"],
          sitePkId: json["SitePKId"],
          userId: json["UserId"],
          posMachineName: json["POSMachineName"],
          languageCode: json["LanguageCode"]);

  Map<String, dynamic> toJson() => {
        "PosMachineGuid": posMachineGuid,
        "WebApiToken": webApiToken,
        "Token": token,
        "LanguageId": languageId,
        "IsCorporate": isCorporate,
        "UserPKId": userPkId,
        "UserRoleId": userRoleId,
        "MachineId": machineId,
        "SiteId": siteId,
        "SitePKId": sitePkId,
        "UserId": userId,
        "POSMachineName": posMachineName,
        "LanguageCode": languageCode
      };
}
