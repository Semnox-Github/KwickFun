class ExecutionContextDTO {
  int? _languageId;
  int? _machineId;
  int? _siteId;
  String? _loginId;
  String? _apiUrl;
  String? _authToken;
  String? _posMachineName;
  String? _languageCode;
  bool? _isCorporate;
  bool? _inWebMode;
  bool? _isSystemLogined;
  bool? _isSiteLogined;
  bool? _isUserLogined;
  int? _roleId;
  int? _userPKId;
  String? _userId;

  ExecutionContextDTO(
      {int? languageId,
      int? machineId,
      int? siteId,
      String? loginId,
      String? apiUrl,
      String? authToken,
      String? posMachineName,
      String? languageCode,
      bool? isCorporate,
      bool? inWebMode,
      bool? isSystemLogined,
      bool? isSiteLogined,
      bool? isUserLogined,
      int? roleId,
      int? userPKId,
      String? userId}) {
    _languageId = languageId;
    _machineId = machineId;
    _siteId = siteId;
    _loginId = loginId;
    _apiUrl = apiUrl;
    _authToken = authToken;
    _posMachineName = posMachineName;
    _languageCode = languageCode;
    _isCorporate = isCorporate;
    _inWebMode = inWebMode;
    _isSystemLogined = isSystemLogined;
    _isSiteLogined = isSiteLogined;
    _isUserLogined = isUserLogined;
    _roleId = roleId;
    _userPKId = userPKId;
    _userId = userId;
  }

  int? get languageId => _languageId;
  int? get machineId => _machineId;
  int? get siteId => _siteId;
  String? get loginId => _loginId;
  String? get apiUrl => _apiUrl;
  String? get authToken => _authToken;
  String? get posMachineName => _posMachineName;
  String? get languageCode => _languageCode;
  bool get isCorporate => _isCorporate ?? false;
  bool? get inWebMode => _inWebMode;
  bool? get isSystemLogined => _isSystemLogined ?? false;
  bool? get isSiteLogined => _isSiteLogined ?? false;
  bool? get isUserLogined => _isUserLogined ?? false;
  int? get roleId => _roleId;
  int? get userPKId => _userPKId;
  String? get userId => _userId;

  set siteId(int? siteId) {
    _siteId = siteId;
  }

  set isSystemLogined(bool? isSystemLogined) {
    _isSystemLogined = isSystemLogined;
  }

  set isSiteLogined(bool? isSiteLogined) {
    _isSiteLogined = isSiteLogined;
  }

  set isUserLogined(bool? isUserLogined) {
    _isUserLogined = isUserLogined;
  }

  String siteHash() {
    String hash = siteId.toString();
    return hash;
  }

  String longsiteHash() {
    String hash = ("$siteId|$loginId|$_machineId");
    return hash;
  }

  ExecutionContextDTO copyWith(
      {int? languageId,
      int? machineId,
      int? siteId,
      String? loginId,
      String? apiUrl,
      String? authToken,
      String? posMachineName,
      String? languageCode,
      bool? isCorporate,
      bool? inWebMode,
      bool? isSystemLogined,
      bool? isSiteLogined,
      bool? isUserLogined,
      int? roleId,
      int? userPKId,
      String? userId}) {
    return ExecutionContextDTO(
        languageId: languageId ?? _languageId,
        machineId: machineId ?? _machineId,
        siteId: siteId ?? _siteId,
        loginId: loginId ?? _loginId,
        apiUrl: apiUrl ?? _apiUrl,
        authToken: authToken ?? _authToken,
        posMachineName: posMachineName ?? _posMachineName,
        languageCode: languageCode ?? _languageCode,
        isCorporate: isCorporate ?? _isCorporate,
        inWebMode: inWebMode ?? _inWebMode,
        isSystemLogined: isSystemLogined ?? _isSystemLogined,
        isSiteLogined: isSiteLogined ?? _isSiteLogined,
        isUserLogined: isUserLogined ?? _isUserLogined,
        roleId: roleId ?? _roleId,
        userPKId: userPKId ?? _userPKId,
        userId: userId ?? _userId);
  }

  factory ExecutionContextDTO.fromMap(Map<String, dynamic> json) =>
      ExecutionContextDTO(
          languageId: json["LanguageId"],
          machineId: json["MachineId"],
          siteId: json["SiteId"],
          loginId: json["LoginId"],
          apiUrl: json["ApiUrl"],
          authToken: json["AuthToken"],
          posMachineName: json["PosMachineName"],
          languageCode: json["LanguageCode"],
          isCorporate: json["IsCorporate"],
          inWebMode: json["InWebMode"],
          isSystemLogined: json["IsSystemLogined"],
          isSiteLogined: json["IsSiteLogined"],
          isUserLogined: json["IsUserLogined"],
          roleId: json["RoleId"],
          userPKId: json["UserPKId"],
          userId: json["UserId"]);

  Map<String, dynamic> toMap() => {
        "LanguageId": languageId,
        "MachineId": machineId,
        "SiteId": siteId,
        "LoginId": loginId,
        "ApiUrl": apiUrl,
        "AuthToken": authToken,
        "PosMachineName": posMachineName,
        "LanguageCode": languageCode,
        "IsCorporate": isCorporate,
        "InWebMode": inWebMode,
        "IsSystemLogined": isSystemLogined,
        "IsSiteLogined": isSiteLogined,
        "IsUserLogined": isUserLogined,
        "RoleId": roleId,
        "UserPKId": userPKId,
        "UserId": userId
      };
}
