// ignore_for_file: unnecessary_getters_setters

import 'package:semnox_core/modules/customer/model/customer/address_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/phone_contact_dto.dart';

class ProfileDTO {
  ProfileDTO(
      {int? id,
      int? profileTypeId,
      int? profileType,
      String? title,
      String? firstName,
      String? middleName,
      String? lastName,
      String? nickName,
      String? notes,
      String? dateOfBirth,
      String? gender,
      String? anniversary,
      String? photoUrl,
      bool? rightHanded,
      bool? teamUser,
      String? uniqueIdentifier,
      String? idProofFileUrl,
      String? taxCode,
      String? designation,
      String? company,
      String? userName,
      String? password,
      String? lastLoginTime,
      List<PhoneContactDTO>? contactDtoList,
      List<AddressDTO>? addressDtoList,
      dynamic? profileContentHistoryDtoList,
      bool? optInPromotions,
      String? optInPromotionsMode,
      String? optInLastUpdatedDate,
      bool? policyTermsAccepted,
      bool? isActive,
      String? createdBy,
      String? creationDate,
      String? lastUpdatedBy,
      String? lastUpdateDate,
      int? siteId,
      int? masterEntityId,
      bool? synchStatus,
      String? guid,
      String? externalSystemReference,
      bool? optOutWhatsApp,
      String? userStatus,
      String? passwordChangeDate,
      int? invalidAccessAttempts,
      String? lockedOutTime,
      bool? passwordChangeOnNextLogin,
      bool? isChanged,
      bool? isChangedRecursive,}) {
    _id = id;
    _profileTypeId = profileTypeId;
    _profileType = profileType;
    _title = title;
    _firstName = firstName;
    _middleName = middleName;
    _lastName = lastName;
    _nickName = nickName;
    _notes = notes;
    _dateOfBirth = dateOfBirth;
    _gender = gender;
    _anniversary = anniversary;
    _photoUrl = photoUrl;
    _rightHanded = rightHanded;
    _teamUser = teamUser;
    _uniqueIdentifier = uniqueIdentifier;
    _idProofFileUrl = idProofFileUrl;
    _taxCode = taxCode;
    _designation = designation;
    _company = company;
    _userName = userName;
    _password = password;
    _lastLoginTime = lastLoginTime;
    _contactDtoList = contactDtoList;
    _addressDtoList = addressDtoList;
    _profileContentHistoryDtoList = profileContentHistoryDtoList;
    _optInPromotions = optInPromotions;
    _optInPromotionsMode = optInPromotionsMode;
    _optInLastUpdatedDate = optInLastUpdatedDate;
    _policyTermsAccepted = policyTermsAccepted;
    _isActive = isActive;
    _createdBy = createdBy;
    _creationDate = creationDate;
    _lastUpdatedBy = lastUpdatedBy;
    _lastUpdateDate = lastUpdateDate;
    _siteId = siteId;
    _masterEntityId = masterEntityId;
    _synchStatus = synchStatus;
    _guid = guid;
    _externalSystemReference = externalSystemReference;
    _optOutWhatsApp = optOutWhatsApp;
    _userStatus = userStatus;
    _passwordChangeDate = passwordChangeDate;
    _invalidAccessAttempts = invalidAccessAttempts;
    _lockedOutTime = lockedOutTime;
    _passwordChangeOnNextLogin = passwordChangeOnNextLogin;
    _isChanged = isChanged;
    _isChangedRecursive = isChangedRecursive;
  }

  int? _id;
  int? _profileTypeId;
  int? _profileType;
  String? _title;
  String? _firstName;
  String? _middleName;
  String? _lastName;
  String? _nickName;
  String? _notes;
  String? _dateOfBirth;
  String? _gender;
  String? _anniversary;
  String? _photoUrl;
  bool? _rightHanded;
  bool? _teamUser;
  String? _uniqueIdentifier;
  String? _idProofFileUrl;
  String? _taxCode;
  String? _designation;
  String? _company;
  String? _userName;
  String? _password;
  String? _lastLoginTime;
  List<PhoneContactDTO>? _contactDtoList;
  List<AddressDTO>? _addressDtoList;
  dynamic? _profileContentHistoryDtoList;
  bool? _optInPromotions;
  String? _optInPromotionsMode;
  String? _optInLastUpdatedDate;
  bool? _policyTermsAccepted;
  bool? _isActive;
  String? _createdBy;
  String? _creationDate;
  String? _lastUpdatedBy;
  String? _lastUpdateDate;
  int? _siteId;
  int? _masterEntityId;
  bool? _synchStatus;
  String? _guid;
  String? _externalSystemReference;
  bool? _optOutWhatsApp;
  String? _userStatus;
  String? _passwordChangeDate;
  int? _invalidAccessAttempts;
  String? _lockedOutTime;
  bool? _passwordChangeOnNextLogin;
  bool? _isChanged;
  bool? _isChangedRecursive;

  int? get id => _id;
  int? get profileTypeId => _profileTypeId;
  int? get profileType => _profileType;
  String? get title => _title;
  String? get firstName => _firstName;
  String? get middleName => _middleName;
  String? get lastName => _lastName;
  String? get nickName => _nickName;
  String? get notes => _notes;
  String? get dateOfBirth => _dateOfBirth;
  String? get gender => _gender;
  String? get anniversary => _anniversary;
  String? get photoUrl => _photoUrl;
  bool? get rightHanded => _rightHanded;
  bool? get teamUser => _teamUser;
  String? get uniqueIdentifier => _uniqueIdentifier;
  String? get idProofFileUrl => _idProofFileUrl;
  String? get taxCode => _taxCode;
  String? get designation => _designation;
  String? get company => _company;
  String? get userName => _userName;
  String? get password => _password;
  String? get lastLoginTime => _lastLoginTime;
  List<PhoneContactDTO>? get contactDtoList => _contactDtoList;
  List<AddressDTO>? get addressDtoList => _addressDtoList;
  dynamic? get profileContentHistoryDtoList => _profileContentHistoryDtoList;
  bool? get optInPromotions => _optInPromotions;
  String? get optInPromotionsMode => _optInPromotionsMode;
  String? get optInLastUpdatedDate => _optInLastUpdatedDate;
  bool? get policyTermsAccepted => _policyTermsAccepted;
  bool? get isActive => _isActive;
  String? get createdBy => _createdBy;
  String? get creationDate => _creationDate;
  String? get lastUpdatedBy => _lastUpdatedBy;
  String? get lastUpdateDate => _lastUpdateDate;
  int? get siteId => _siteId;
  int? get masterEntityId => _masterEntityId;
  bool? get synchStatus => _synchStatus;
  String? get guid => _guid;
  String? get externalSystemReference => _externalSystemReference;
  bool? get optOutWhatsApp => _optOutWhatsApp;
  String? get userStatus => _userStatus;
  String? get passwordChangeDate => _passwordChangeDate;
  int? get invalidAccessAttempts => _invalidAccessAttempts;
  String? get lockedOutTime => _lockedOutTime;
  bool? get passwordChangeOnNextLogin => _passwordChangeOnNextLogin;
  bool? get isChanged => _isChanged;
  bool? get isChangedRecursive => _isChangedRecursive;

  set title(String? title) {
    _title = title;
  }

  set firtName(String? firtName) {
    _firstName = firtName;
  }

  set middleName(String? middleName) {
    _middleName = middleName;
  }

  set lastName(String? lastName) {
    _lastName = lastName;
  }

  set nickName(String? nickName) {
    _nickName = nickName;
  }

  set dateOfBirth(String? dateOfBirth) {
    _dateOfBirth = dateOfBirth;
  }

  set gender(String? gender) {
    _gender = gender;
  }

  set anniversary(String? anniversary) {
    _anniversary = anniversary;
  }

  set photoUrl(String? photoUrl) {
    _photoUrl = photoUrl;
  }

  set contactDtoList(List<PhoneContactDTO>? contactDtoList) {
    _contactDtoList = contactDtoList;
  }

  set addressDtoList(List<AddressDTO>? addressDtoList) {
    _addressDtoList = addressDtoList;
  }

  factory ProfileDTO.fromJson(Map<String, dynamic> json) => ProfileDTO(
        id: json["Id"],
        profileTypeId: json["ProfileTypeId"],
        profileType: json["ProfileType"],
        title: json["Title"],
        firstName: json["FirstName"],
        middleName: json["MiddleName"],
        lastName: json["LastName"],
        nickName: json["NickName"],
        notes: json["Notes"],
        dateOfBirth: json["DateOfBirth"],
        gender: json["Gender"],
        anniversary: json["Anniversary"],
        photoUrl: json["PhotoURL"],
        rightHanded: json["RightHanded"],
        teamUser: json["TeamUser"],
        uniqueIdentifier: json["UniqueIdentifier"],
        idProofFileUrl: json["IdProofFileURL"],
        taxCode: json["TaxCode"],
        designation: json["Designation"],
        company: json["Company"],
        userName: json["UserName"],
        password: json["Password"],
        lastLoginTime: json["LastLoginTime"],
        contactDtoList: List<PhoneContactDTO>.from(
            json["ContactDTOList"].map((x) => PhoneContactDTO.fromJson(x))),
        addressDtoList: List<AddressDTO>.from(
            json["AddressDTOList"].map((x) => AddressDTO.fromJson(x))),
        profileContentHistoryDtoList: json["ProfileContentHistoryDTOList"],
        optInPromotions: json["OptInPromotions"],
        optInPromotionsMode: json["OptInPromotionsMode"],
        optInLastUpdatedDate: json["OptInLastUpdatedDate"],
        policyTermsAccepted: json["PolicyTermsAccepted"],
        isActive: json["IsActive"],
        createdBy: json["CreatedBy"],
        creationDate: json["CreationDate"],
        lastUpdatedBy: json["LastUpdatedBy"],
        lastUpdateDate: json["LastUpdateDate"],
        siteId: json["SiteId"],
        masterEntityId: json["MasterEntityId"],
        synchStatus: json["SynchStatus"],
        guid: json["Guid"],
        externalSystemReference: json["ExternalSystemReference"],
        optOutWhatsApp: json["OptOutWhatsApp"],
        userStatus: json["UserStatus"],
        passwordChangeDate: json["PasswordChangeDate"],
        invalidAccessAttempts: json["InvalidAccessAttempts"],
        lockedOutTime: json["LockedOutTime"],
        passwordChangeOnNextLogin: json["PasswordChangeOnNextLogin"],
        isChanged: json["IsChanged"],
        isChangedRecursive: json["IsChangedRecursive"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ProfileTypeId": profileTypeId,
        "ProfileType": profileType,
        "Title": title,
        "FirstName": firstName,
        "MiddleName": middleName,
        "LastName": lastName,
        "NickName": nickName,
        "Notes": notes,
        "DateOfBirth": dateOfBirth,
        "Gender": gender,
        "Anniversary": anniversary,
        "PhotoURL": photoUrl,
        "RightHanded": rightHanded,
        "TeamUser": teamUser,
        "UniqueIdentifier": uniqueIdentifier,
        "IdProofFileURL": idProofFileUrl,
        "TaxCode": taxCode,
        "Designation": designation,
        "Company": company,
        "UserName": userName,
        "Password": password,
        "LastLoginTime": lastLoginTime,
        "ContactDTOList":
            List<PhoneContactDTO>.from(contactDtoList!.map((x) => x.toJson())),
        "AddressDTOList":
            List<AddressDTO>.from(addressDtoList!.map((x) => x.toJson())),
        "ProfileContentHistoryDTOList": profileContentHistoryDtoList,
        "OptInPromotions": optInPromotions,
        "OptInPromotionsMode": optInPromotionsMode,
        "OptInLastUpdatedDate": optInLastUpdatedDate,
        "PolicyTermsAccepted": policyTermsAccepted,
        "IsActive": isActive,
        "CreatedBy": createdBy,
        "CreationDate": creationDate,
        "LastUpdatedBy": lastUpdatedBy,
        "LastUpdateDate": lastUpdateDate,
        "SiteId": siteId,
        "MasterEntityId": masterEntityId,
        "SynchStatus": synchStatus,
        "Guid": guid,
        "ExternalSystemReference": externalSystemReference,
        "OptOutWhatsApp": optOutWhatsApp,
        "UserStatus": userStatus,
        "PasswordChangeDate": passwordChangeDate,
        "InvalidAccessAttempts": invalidAccessAttempts,
        "LockedOutTime": lockedOutTime,
        "PasswordChangeOnNextLogin": passwordChangeOnNextLogin,
        "IsChanged": isChanged,
        "IsChangedRecursive": isChangedRecursive,
      };
}
