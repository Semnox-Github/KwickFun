class AppInformationDTO {
  String? _appName;
  String? _buildNumber;
  String? _releaseNumber;
  bool? _isOfflineEnabled;
  String? _systemUsername;
  String? _systemPassword;
  String? _macAddress;
  bool? _inWebMode;
  String? _packageName;
  String? _version;

  AppInformationDTO(
      {String? appName,
      String? buildNumber,
      String? releaseNumber,
      bool? isOfflineEnabled,
      String? systemUsername,
      String? systemPassword,
      String? macAddress,
      bool? inWebMode,
      String? packageName,
      String? version}) {
    _appName = appName;
    _buildNumber = buildNumber;
    _releaseNumber = releaseNumber;
    _isOfflineEnabled = isOfflineEnabled;
    _systemUsername = systemUsername;
    _systemPassword = systemPassword;
    _macAddress = macAddress;
    _inWebMode = inWebMode;
    _packageName = packageName;
    _version = version;
  }

  String? get appName => _appName;
  String? get buildNumber => _buildNumber;
  String? get releaseNumber => _releaseNumber;
  bool? get isOfflineEnabled => _isOfflineEnabled;
  String? get systemUsername => _systemUsername;
  String? get systemPassword => _systemPassword;
  String? get macAddress => _macAddress;
  bool? get inWebMode => _inWebMode;
  String? get packageName => _packageName;
  String? get version => _version;

  set systemusername(String? systemUsername) {
    _systemUsername = systemUsername;
  }

  set systempassword(String? systemPassword) {
    _systemPassword = systemPassword;
  }

  factory AppInformationDTO.fromJson(Map<String, dynamic> json) =>
      AppInformationDTO(
        appName: json['AppName'],
        buildNumber: json['BuildNumber'],
        releaseNumber: json['ReleaseNumber'],
        isOfflineEnabled: json['IsOfflineEnabled'],
        systemUsername: json['SystemUsername'],
        systemPassword: json['SystemPassword'],
        macAddress: json['MacAddress'],
        inWebMode: json['InWebMode'],
        packageName: json['PackageName'],
        version: json['Version'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AppName'] = appName;
    data['BuildNumber'] = buildNumber;
    data['ReleaseNumber'] = releaseNumber;
    data['IsOfflineEnabled'] = isOfflineEnabled;
    data['SystemUsername'] = systemUsername;
    data['SystemPassword'] = systemPassword;
    data['MacAddress'] = macAddress;
    data['InWebMode'] = inWebMode;
    data['PackageName'] = packageName;
    data['Version'] = version;
    return data;
  }
}
