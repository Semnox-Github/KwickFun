class SiteViewDTO {
  int? _siteId;
  String? _siteName;
  String? _siteAddress;
  bool? _isMasterSite;
  bool? _onlineEnabled;
  String? _pinCode;
  String? _siteUrl;
  String? _siteShortName;
  String? _city;
  String? _state;
  String? _country;
  String? _storeType;
  String? _storeRanking;
  double? _openTime;
  double? _closeTime;
  DateTime? _openDate;
  DateTime? _closureDate;
  int? _businessDayStartTime;
  String? _timeZoneName;
  String? _email;
  String? _phoneNumber;

  SiteViewDTO({
    int? siteId,
    String? siteName,
    String? siteAddress,
    bool? isMasterSite,
    bool? onlineEnabled,
    String? pinCode,
    String? siteUrl,
    String? siteShortName,
    String? city,
    String? state,
    String? country,
    String? storeType,
    String? storeRanking,
    double? openTime,
    double? closeTime,
    DateTime? openDate,
    DateTime? closureDate,
    int? businessDayStartTime,
    String? timeZoneName,
    String? email,
    String? phoneNumber,
  }) {
    _siteId = siteId;
    _siteName = siteName;
    _siteAddress = siteAddress;
    _isMasterSite = isMasterSite;
    _onlineEnabled = onlineEnabled;
    _pinCode = pinCode;
    _siteUrl = siteUrl;
    _siteShortName = siteShortName;
    _city = city;
    _state = state;
    _country = country;
    _storeType = storeType;
    _storeRanking = storeRanking;
    _openTime = openTime;
    _closeTime = closeTime;
    _openDate = openDate;
    _closureDate = closureDate;
    _businessDayStartTime = businessDayStartTime;
    _timeZoneName = timeZoneName;
    _email = email;
    _phoneNumber = phoneNumber;
  }

  int? get siteId => _siteId;
  String? get siteName => _siteName;
  String? get siteAddress => _siteAddress;
  bool? get isMasterSite => _isMasterSite;
  bool? get onlineEnabled => _onlineEnabled;
  String? get pincode => _pinCode;
  String? get siteUrl => _siteUrl;
  String? get siteShortName => _siteShortName;
  String? get city => _city;
  String? get state => _state;
  String? get country => _country;
  String? get storeType => _storeType;
  String? get storeRanking => _storeRanking;
  double? get openTime => _openTime;
  double? get closeTime => _closeTime;
  DateTime? get openDate => _openDate;
  DateTime? get closureDate => _closureDate;
  int? get businessDayStartTime => _businessDayStartTime;
  String? get timeZoneName => _timeZoneName;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;

  factory SiteViewDTO.fromJson(Map<String, dynamic> json) => SiteViewDTO(
        siteId: json["SiteId"],
        siteName: json["SiteName"],
        siteAddress: json["SiteAddress"],
        isMasterSite: json["IsMasterSite"],
        onlineEnabled: json["OnlineEnabled"],
        pinCode: json["PinCode"],
        siteUrl: json["SiteURL"],
        siteShortName: json["SiteShortName"],
        city: json["City"],
        state: json["State"],
        country: json["Country"],
        storeType: json["StoreType"],
        storeRanking: json["StoreRanking"],
        openTime: json["OpenTime"],
        closeTime: json["CloseTime"],
        openDate: DateTime.parse(json["OpenDate"]),
        closureDate: DateTime.parse(json["ClosureDate"]),
        businessDayStartTime: json["BusinessDayStartTime"],
        timeZoneName: json["TimeZoneName"],
        email: json["Email"],
        phoneNumber: json["PhoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "SiteId": siteId,
        "SiteName": siteName,
        "SiteAddress": siteAddress,
        "IsMasterSite": isMasterSite,
        "OnlineEnabled": onlineEnabled,
        "PinCode": pincode,
        "SiteURL": siteUrl,
        "SiteShortName": siteShortName,
        "City": city,
        "State": state,
        "Country": country,
        "StoreType": storeType,
        "StoreRanking": storeRanking,
        "OpenTime": openTime,
        "CloseTime": closeTime,
        "OpenDate": openDate?.toIso8601String(),
        "ClosureDate": closureDate?.toIso8601String(),
        "BusinessDayStartTime": businessDayStartTime,
        "TimeZoneName": timeZoneName,
        "Email": email,
        "PhoneNumber": phoneNumber,
      };

  static List<SiteViewDTO>? getSiteDTOList(List? dtoList) {
    if (dtoList == null) {
      return null;
    }
    List<SiteViewDTO> siteViewDTOList = [];
    siteViewDTOList =
        List<SiteViewDTO>.from(dtoList.map((x) => SiteViewDTO.fromJson(x)));
    return siteViewDTOList;
  }
}

enum SiteViewDTOSearchParameter { hash, rebuildcache, siteId }
