// import 'package:semnox_core/modules/hr/model/dataAccessRule_dto.dart';

// class UsersDto {
//   UsersDto(
//       {int? userId,
//       String? userName,
//       String? loginId,
//       int? roleId,
//       String? cardNumber,
//       String? lastLoginTime,
//       String? logoutTime,
//       String? overrideFingerPrint,
//       String? passwordHash,
//       String? passwordSalt,
//       String? password,
//       int? masterEntityId,
//       int? posTypeId,
//       int? departmentId,
//       String? departmentName,
//       String? empStartDate,
//       String? empEndDate,
//       String? empEndReason,
//       int? managerId,
//       String? empLastName,
//       String? empNumber,
//       String? companyAdministrator,
//       int? fingerNumber,
//       String? userStatus,
//       String? passwordChangeDate,
//       int? invalidAccessAttempts,
//       String? lockedOutTime,
//       bool? passwordChangeOnNextLogin,
//       String? email,
//       bool? isActive,
//       String? createdBy,
//       String? creationDate,
//       String? lastUpdatedBy,
//       String? lastUpdatedDate,
//       String? guid,
//       int? siteId,
//       bool? synchStatus,
//       String? dateOfBirth,
//       String? phoneNumber,
//       int? shiftConfigurationId,
//       List<dynamic>? userIdentificationTagsDtoList,
//       List<dynamic>? userPasswordHistoryDtoList,
//       bool? isChangedRecursive,
//       bool? isChanged,
//       DataAccessRuleDto? dataAccessRuleDto}) {
//     _userId = userId;
//     _userName = userName;
//     _loginId = loginId;
//     _roleId = roleId;
//     _cardNumber = cardNumber;
//     _lastLoginTime = lastLoginTime;
//     _logoutTime = logoutTime;
//     _overrideFingerPrint = overrideFingerPrint;
//     _passwordHash = passwordHash;
//     _passwordSalt = passwordSalt;
//     _password = password;
//     _masterEntityId = masterEntityId;
//     _posTypeId = posTypeId;
//     _departmentId = departmentId;
//     _departmentName = departmentName;
//     _empStartDate = empStartDate;
//     _empEndDate = empEndDate;
//     _empEndReason = empEndReason;
//     _managerId = managerId;
//     _empLastName = empLastName;
//     _empNumber = empNumber;
//     _companyAdministrator = companyAdministrator;
//     _fingerNumber = fingerNumber;
//     _userStatus = userStatus;
//     _passwordChangeDate = passwordChangeDate;
//     _invalidAccessAttempts = invalidAccessAttempts;
//     _lockedOutTime = lockedOutTime;
//     _passwordChangeOnNextLogin = passwordChangeOnNextLogin;
//     _email = email;
//     _isActive = isActive;
//     _createdBy = createdBy;
//     _creationDate = creationDate;
//     _lastUpdatedBy = lastUpdatedBy;
//     _lastUpdatedDate = lastUpdatedDate;
//     _guid = guid;
//     _siteId = siteId;
//     _synchStatus = synchStatus;
//     _dateOfBirth = dateOfBirth;
//     _phoneNumber = phoneNumber;
//     _shiftConfigurationId = shiftConfigurationId;
//     _userIdentificationTagsDtoList = userIdentificationTagsDtoList;
//     _userPasswordHistoryDtoList = userPasswordHistoryDtoList;
//     _isChangedRecursive = isChangedRecursive;
//     _isChanged = isChanged;
//     _dataAccessRuleDto = dataAccessRuleDto;
//   }

//   int? _userId;
//   String? _userName;
//   String? _loginId;
//   int? _roleId;
//   String? _cardNumber;
//   String? _lastLoginTime;
//   String? _logoutTime;
//   String? _overrideFingerPrint;
//   String? _passwordHash;
//   String? _passwordSalt;
//   String? _password;
//   int? _masterEntityId;
//   int? _posTypeId;
//   int? _departmentId;
//   String? _departmentName;
//   String? _empStartDate;
//   String? _empEndDate;
//   String? _empEndReason;
//   int? _managerId;
//   String? _empLastName;
//   String? _empNumber;
//   String? _companyAdministrator;
//   int? _fingerNumber;
//   String? _userStatus;
//   String? _passwordChangeDate;
//   int? _invalidAccessAttempts;
//   String? _lockedOutTime;
//   bool? _passwordChangeOnNextLogin;
//   String? _email;
//   bool? _isActive;
//   String? _createdBy;
//   String? _creationDate;
//   String? _lastUpdatedBy;
//   String? _lastUpdatedDate;
//   String? _guid;
//   int? _siteId;
//   bool? _synchStatus;
//   String? _dateOfBirth;
//   String? _phoneNumber;
//   int? _shiftConfigurationId;
//   List<dynamic>? _userIdentificationTagsDtoList;
//   List<dynamic>? _userPasswordHistoryDtoList;
//   bool? _isChangedRecursive;
//   bool? _isChanged;
//   DataAccessRuleDto? _dataAccessRuleDto;

//   int? get userId => _userId;
//   String? get userName => _userName;
//   String? get loginId => _loginId;
//   int? get roleId => _roleId;
//   String? get cardNumber => _cardNumber;
//   String? get lastLoginTime => _lastLoginTime;
//   String? get logoutTime => _logoutTime;
//   String? get overrideFingerPrint => _overrideFingerPrint;
//   String? get passwordHash => _passwordHash;
//   String? get passwordSalt => _passwordSalt;
//   String? get password => _password;
//   int? get masterEntityId => _masterEntityId;
//   int? get posTypeId => _posTypeId;
//   int? get departmentId => _departmentId;
//   String? get departmentName => _departmentName;
//   String? get empStartDate => _empStartDate;
//   String? get empEndDate => _empEndDate;
//   String? get empEndReason => _empEndReason;
//   int? get managerId => _managerId;
//   String? get empLastName => _empLastName;
//   String? get empNumber => _empNumber;
//   String? get companyAdministrator => _companyAdministrator;
//   int? get fingerNumber => _fingerNumber;
//   String? get userStatus => _userStatus;
//   String? get passwordChangeDate => _passwordChangeDate;
//   int? get invalidAccessAttempts => _invalidAccessAttempts;
//   String? get lockedOutTime => _lockedOutTime;
//   bool? get passwordChangeOnNextLogin => _passwordChangeOnNextLogin;
//   String? get email => _email;
//   bool? get isActive => _isActive;
//   String? get createdBy => _createdBy;
//   String? get creationDate => _creationDate;
//   String? get lastUpdatedBy => _lastUpdatedBy;
//   String? get lastUpdatedDate => _lastUpdatedDate;
//   String? get guid => _guid;
//   int? get siteId => _siteId;
//   bool? get synchStatus => _synchStatus;
//   String? get dateOfBirth => _dateOfBirth;
//   String? get phoneNumber => _phoneNumber;
//   int? get shiftConfigurationId => _shiftConfigurationId;
//   List<dynamic>? get userIdentificationTagsDtoList =>
//       _userIdentificationTagsDtoList;
//   List<dynamic>? get userPasswordHistoryDtoList => _userPasswordHistoryDtoList;
//   bool? get isChangedRecursive => _isChangedRecursive;
//   bool? get isChanged => _isChanged;
//   DataAccessRuleDto? get dataAccessRuleDto => _dataAccessRuleDto;

//   factory UsersDto.fromJson(Map<String, dynamic> json) => UsersDto(
//         userId: json["UserId"],
//         userName: json["UserName"],
//         loginId: json["LoginId"],
//         roleId: json["RoleId"],
//         cardNumber: json["CardNumber"],
//         lastLoginTime: json["LastLoginTime"],
//         logoutTime: json["LogoutTime"],
//         overrideFingerPrint: json["OverrideFingerPrint"],
//         passwordHash: json["PasswordHash"],
//         passwordSalt: json["PasswordSalt"],
//         password: json["Password"],
//         masterEntityId: json["MasterEntityId"],
//         posTypeId: json["PosTypeId"],
//         departmentId: json["DepartmentId"],
//         departmentName: json["DepartmentName"],
//         empStartDate: json["EmpStartDate"],
//         empEndDate: json["EmpEndDate"],
//         empEndReason: json["EmpEndReason"],
//         managerId: json["ManagerId"],
//         empLastName: json["EmpLastName"],
//         empNumber: json["EmpNumber"],
//         companyAdministrator: json["CompanyAdministrator"],
//         fingerNumber: json["FingerNumber"],
//         userStatus: json["UserStatus"],
//         passwordChangeDate: json["PasswordChangeDate"],
//         invalidAccessAttempts: json["InvalidAccessAttempts"],
//         lockedOutTime: json["LockedOutTime"],
//         passwordChangeOnNextLogin: json["PasswordChangeOnNextLogin"],
//         email: json["Email"],
//         isActive: json["IsActive"],
//         createdBy: json["CreatedBy"],
//         creationDate: json["CreationDate"],
//         lastUpdatedBy: json["LastUpdatedBy"],
//         lastUpdatedDate: json["LastUpdatedDate"],
//         guid: json["Guid"],
//         siteId: json["SiteId"],
//         synchStatus: json["SynchStatus"],
//         dateOfBirth: json["DateOfBirth"],
//         phoneNumber: json["PhoneNumber"],
//         shiftConfigurationId: json["ShiftConfigurationId"],
//         userIdentificationTagsDtoList:
//             json["UserIdentificationTagsDTOList"] == null
//                 ? []
//                 : List<dynamic>.from(
//                     json["UserIdentificationTagsDTOList"]!.map((x) => x)),
//         userPasswordHistoryDtoList: json["UserPasswordHistoryDTOList"] == null
//             ? []
//             : List<dynamic>.from(
//                 json["UserPasswordHistoryDTOList"]!.map((x) => x)),
//         isChangedRecursive: json["IsChangedRecursive"],
//         isChanged: json["IsChanged"],
//         dataAccessRuleDto:
//             DataAccessRuleDto.fromJson(json["DataAccessRuleDTO"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "UserId": userId,
//         "UserName": userName,
//         "LoginId": loginId,
//         "RoleId": roleId,
//         "CardNumber": cardNumber,
//         "LastLoginTime": lastLoginTime,
//         "LogoutTime": logoutTime,
//         "OverrideFingerPrint": overrideFingerPrint,
//         "PasswordHash": passwordHash,
//         "PasswordSalt": passwordSalt,
//         "Password": password,
//         "MasterEntityId": masterEntityId,
//         "PosTypeId": posTypeId,
//         "DepartmentId": departmentId,
//         "DepartmentName": departmentName,
//         "EmpStartDate": empStartDate,
//         "EmpEndDate": empEndDate,
//         "EmpEndReason": empEndReason,
//         "ManagerId": managerId,
//         "EmpLastName": empLastName,
//         "EmpNumber": empNumber,
//         "CompanyAdministrator": companyAdministrator,
//         "FingerNumber": fingerNumber,
//         "UserStatus": userStatus,
//         "PasswordChangeDate": passwordChangeDate,
//         "InvalidAccessAttempts": invalidAccessAttempts,
//         "LockedOutTime": lockedOutTime,
//         "PasswordChangeOnNextLogin": passwordChangeOnNextLogin,
//         "Email": email,
//         "IsActive": isActive,
//         "CreatedBy": createdBy,
//         "CreationDate": creationDate,
//         "LastUpdatedBy": lastUpdatedBy,
//         "LastUpdatedDate": lastUpdatedDate,
//         "Guid": guid,
//         "SiteId": siteId,
//         "SynchStatus": synchStatus,
//         "DateOfBirth": dateOfBirth,
//         "PhoneNumber": phoneNumber,
//         "ShiftConfigurationId": shiftConfigurationId,
//         "UserIdentificationTagsDTOList": userIdentificationTagsDtoList == null
//             ? []
//             : List<dynamic>.from(userIdentificationTagsDtoList!.map((x) => x)),
//         "UserPasswordHistoryDTOList": userPasswordHistoryDtoList == null
//             ? []
//             : List<dynamic>.from(userPasswordHistoryDtoList!.map((x) => x)),
//         "IsChangedRecursive": isChangedRecursive,
//         "IsChanged": isChanged,
//         "DataAccessRuleDTO": dataAccessRuleDto!.toJson(),
//       };
// }

// enum UserDTOSearchParameter {
//   isActive,
//   userId,
//   userRoleId,
//   userName,
//   userStatus,
//   empNumber,
//   departmentId,
//   cardNumber,
//   loadUserTags
// } // Id

class UsersDto {
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

  UsersDto(
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

  factory UsersDto.fromJson(Map<String, dynamic> json) => UsersDto(
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

  static List<UsersDto>? getUserContainerDtoList(List? dtoList) {
    if (dtoList == null) {
      return null;
    }
    List<UsersDto> userContainerDTOList = [];
    userContainerDTOList =
        List<UsersDto>.from(dtoList.map((x) => UsersDto.fromJson(x)));
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

enum UserDTOSearchParameter { HASH, REBUILDCACHE, SITEID, isActive }
