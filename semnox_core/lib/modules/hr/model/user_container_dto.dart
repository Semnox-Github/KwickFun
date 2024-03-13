class UserContainerDto {
  int? _userId;
  int? _roleId;
  String? _userName;
  String? _empLastName;
  String? _loginId;
  int? _managerId;
  int? _siteId;
  int? _posTypeId;
  bool? _selfApprovalAllowed;
  String? _guid;
  List<UserIdentificationTagContainerDtoList>?
      _userIdentificationTagContainerDtoList;
  String? _phoneNumber;

  UserContainerDto(
      {int? userId,
      int? roleId,
      String? userName,
      String? empLastName,
      String? loginId,
      int? managerId,
      int? siteId,
      int? posTypeId,
      bool? selfApprovalAllowed,
      String? guid,
      List<UserIdentificationTagContainerDtoList>?
          userIdentificationTagContainerDtoList,
      String? phoneNumber}) {
    _userId = userId;
    _roleId = roleId;
    _userName = userName;
    _empLastName = empLastName;
    _loginId = loginId;
    _managerId = managerId;
    _siteId = siteId;
    _posTypeId = posTypeId;
    _selfApprovalAllowed = selfApprovalAllowed;
    _guid = guid;
    _userIdentificationTagContainerDtoList =
        userIdentificationTagContainerDtoList;
    _phoneNumber = phoneNumber;
  }

  int? get userId => _userId;
  int? get roleId => _roleId;
  String? get userName => _userName;
  String? get empLastName => _empLastName;
  String? get loginId => _loginId;
  int? get managerId => _managerId;
  int? get siteId => _siteId;
  int? get posTypeId => _posTypeId;
  bool? get selfApprovalAllowed => _selfApprovalAllowed;
  String? get guid => _guid;
  List<UserIdentificationTagContainerDtoList>?
      get userIdentificationTagContainerDtoList =>
          _userIdentificationTagContainerDtoList;
  String? get phoneNumber => _phoneNumber;

  factory UserContainerDto.fromJson(Map<String, dynamic> json) =>
      UserContainerDto(
        userId: json["UserId"],
        roleId: json["RoleId"],
        userName: json["UserName"],
        empLastName: json["EmpLastName"],
        loginId: json["LoginId"],
        managerId: json["ManagerId"],
        siteId: json["SiteId"],
        posTypeId: json["POSTypeId"],
        selfApprovalAllowed: json["SelfApprovalAllowed"],
        guid: json["Guid"],
        userIdentificationTagContainerDtoList:
            List<UserIdentificationTagContainerDtoList>.from(
                json["UserIdentificationTagContainerDTOList"].map(
                    (x) => UserIdentificationTagContainerDtoList.fromJson(x))),
        phoneNumber: json["PhoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "UserId": userId,
        "RoleId": roleId,
        "UserName": userName,
        "EmpLastName": empLastName,
        "LoginId": loginId,
        "ManagerId": managerId,
        "SiteId": siteId,
        "POSTypeId": posTypeId,
        "SelfApprovalAllowed": selfApprovalAllowed,
        "Guid": guid,
        "UserIdentificationTagContainerDTOList":
            List<UserIdentificationTagContainerDtoList>.from(
                userIdentificationTagContainerDtoList!.map((x) => x.toJson())),
        "PhoneNumber": phoneNumber,
      };

  static List<UserContainerDto>? getUserContainerDtoList(List? dtoList) {
    if (dtoList == null) {
      return null;
    }
    List<UserContainerDto> userContainerDTOList = [];
    userContainerDTOList = List<UserContainerDto>.from(
        dtoList.map((x) => UserContainerDto.fromJson(x)));
    return userContainerDTOList;
  }
}

class UserIdentificationTagContainerDtoList {
  int? _id;
  String? _cardNumber;
  int? _cardId;
  DateTime? _startDate;
  DateTime? _endDate;
  UserIdentificationTagContainerDtoList(
      {int? id,
      String? cardNumber,
      int? cardId,
      DateTime? startDate,
      DateTime? endDate}) {
    _id = id;
    _cardNumber = cardNumber;
    _cardId = cardId;
    _startDate = startDate;
    _endDate = endDate;
  }

  int? get id => _id;
  String? get cardNumber => _cardNumber;
  int? get cardId => _cardId;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;

  factory UserIdentificationTagContainerDtoList.fromJson(
          Map<String, dynamic> json) =>
      UserIdentificationTagContainerDtoList(
        id: json["Id"],
        cardNumber: json["CardNumber"],
        cardId: json["CardId"],
        startDate: DateTime.parse(json["StartDate"]),
        endDate: DateTime.parse(json["EndDate"]),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "CardNumber": cardNumber,
        "CardId": cardId,
        "StartDate": startDate,
        "EndDate": endDate,
      };
}

enum UserContainerDTOSearchParameter { HASH, REBUILDCACHE, SITEID }
