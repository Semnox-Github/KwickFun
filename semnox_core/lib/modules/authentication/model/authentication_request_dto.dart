class AuthenticationRequestDTO {
  String? _loginId;
  String? _password;
  String? _machineName;
  String? _tagNumber;
  String? _languageCode;
  int? _siteId;

  AuthenticationRequestDTO(
      {String? loginId,
      String? password,
      String? machineName,
      String? tagNumber,
      String? languageCode,
      int? siteId}) {
    _loginId = loginId;
    _password = password;
    _machineName = machineName;
    _tagNumber = tagNumber;
    _languageCode = languageCode;
    _siteId = siteId;
  }

  String? get loginId => _loginId;
  String? get password => _password;
  String? get machineName => _machineName;
  String? get tagNumber => _tagNumber;
  String? get languageCode => _languageCode;
  int? get siteId => _siteId;

  Map<String, dynamic> toJson() => {
        "LoginId": loginId,
        "Password": password,
        "MachineName": machineName,
        "TagNumber": tagNumber,
        "LanguageCode": languageCode,
        "SiteId": siteId
      };
}
