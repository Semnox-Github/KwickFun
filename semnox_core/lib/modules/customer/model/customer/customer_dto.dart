import 'package:semnox_core/modules/customer/model/customer/address_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/custom_data_set_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/phone_contact_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/profile_dto.dart';

class CustomerDTO {
  CustomerDTO(
      {int? id,
      int? profileId,
      int? masterEntityId,
      int? membershipId,
      ProfileDTO? profileDto,
      CustomDataSetDTO? customDataSetDto,
      String? creationDate,
      String? lastUpdateDate,
      int? siteId,
      String? guid,
      // we need to check
      String? memberShipName,
      String? phone,
      String? email}) {
    _id = id;
    _profileId = profileId;
    _masterEntityId = masterEntityId;
    _membershipId = membershipId;
    _profileDto = profileDto;
    _customDataSetDto = customDataSetDto;
    _creationDate = creationDate;
    _lastUpdateDate = lastUpdateDate;
    _siteId = siteId;
    _guid = guid;
    _memberShipName = memberShipName;
    _phone = phone;
    _email = email;
  }

  int? _id;
  int? _profileId;
  int? _masterEntityId;
  int? _membershipId;
  ProfileDTO? _profileDto;
  CustomDataSetDTO? _customDataSetDto;
  String? _creationDate;
  String? _lastUpdateDate;
  int? _siteId;
  String? _guid;
  String? _memberShipName;
  String? _phone;
  String? _email;

  int? get id => _id;
  int? get profileId => _profileId;
  int? get masterEntityId => _masterEntityId;
  int? get membershipId => _membershipId;
  CustomDataSetDTO? get customDataSetDto => _customDataSetDto;
  String? get creationDate => _creationDate;
  String? get lastUpdateDate => _lastUpdateDate;
  int? get siteId => _siteId;
  String? get guid => _guid;
  String? get memberShipName => _memberShipName;
  String? get phone => _phone;
  String? get email => _email;

  // ProfileDTO gettter
  ProfileDTO? get profileDto => _profileDto;
  int? get profileTypeId => _profileDto?.profileTypeId;
  int? get profileType => _profileDto?.profileType;
  String? get title => _profileDto?.title;
  String? get firstName => _profileDto?.firstName;
  String? get middleName => _profileDto?.middleName;
  String? get lastName => _profileDto?.lastName;
  String? get nickName => _profileDto?.nickName;
  String? get notes => _profileDto?.notes;
  String? get dateOfBirth => _profileDto?.dateOfBirth;
  String? get gender => _profileDto?.gender;
  String? get anniversary => _profileDto?.anniversary;
  String? get photoUrl => _profileDto?.photoUrl;
  bool? get rightHanded => _profileDto?.rightHanded;
  bool? get teamUser => _profileDto?.teamUser;
  String? get uniqueIdentifier => _profileDto?.uniqueIdentifier;
  String? get idProofFileUrl => _profileDto?.idProofFileUrl;
  String? get taxCode => _profileDto?.taxCode;
  String? get designation => _profileDto?.designation;
  String? get company => _profileDto?.company;
  String? get userName => _profileDto?.userName;
  String? get password => _profileDto?.password;
  String? get lastLoginTime => _profileDto?.lastLoginTime;
  List<PhoneContactDTO>? get contactDtoList => _profileDto?.contactDtoList;
  List<AddressDTO>? get addressDtoList => _profileDto?.addressDtoList;
  dynamic get profileContentHistoryDtoList =>
      _profileDto?.profileContentHistoryDtoList;
  bool? get optInPromotions => _profileDto?.optInPromotions;
  String? get optInPromotionsMode => _profileDto?.optInPromotionsMode;
  String? get optInLastUpdatedDate => _profileDto?.optInLastUpdatedDate;
  bool? get policyTermsAccepted => _profileDto?.policyTermsAccepted;
  bool? get isActive => _profileDto?.isActive;
  String? get profilecreatedBy => _profileDto?.createdBy;
  String? get profilecreationDate => _profileDto?.creationDate;
  String? get profilelastUpdatedBy => _profileDto?.lastUpdatedBy;
  String? get profilelastUpdateDate => _profileDto?.lastUpdateDate;
  bool? get synchStatus => _profileDto?.synchStatus;
  String? get externalSystemReference => _profileDto?.externalSystemReference;
  bool? get optOutWhatsApp => _profileDto?.optOutWhatsApp;
  String? get userStatus => _profileDto?.userStatus;
  String? get passwordChangeDate => _profileDto?.passwordChangeDate;
  int? get invalidAccessAttempts => _profileDto?.invalidAccessAttempts;
  String? get lockedOutTime => _profileDto?.lockedOutTime;
  bool? get passwordChangeOnNextLogin => _profileDto?.passwordChangeOnNextLogin;
  bool? get isChanged => _profileDto?.isChanged;
  bool? get isChangedRecursive => _profileDto?.isChangedRecursive;

// ProfileDTO setter
  set profiletitle(String? title) {
    _profileDto?.title = title;
  }

  set profilefirtName(String firtName) {
    _profileDto?.firtName = firtName;
  }

  set profilemiddleName(String middleName) {
    _profileDto?.middleName = middleName;
  }

  set profilelastName(String lastName) {
    _profileDto?.lastName = lastName;
  }

  set profilenickName(String nickName) {
    _profileDto?.nickName = nickName;
  }

  set profiledateOfBirth(String dateOfBirth) {
    _profileDto?.dateOfBirth = dateOfBirth;
  }

  set profilegender(String gender) {
    _profileDto?.gender = gender;
  }

  set profileanniversary(String anniversary) {
    _profileDto?.anniversary = anniversary;
  }

  set profilephotoUrl(String photoUrl) {
    _profileDto?.photoUrl = photoUrl;
  }

  set profilecontactDtoList(List<PhoneContactDTO>? contactDtoList) {
    _profileDto?.contactDtoList = contactDtoList;
  }

  set profileaddressDtoList(List<AddressDTO>? addressDtoList) {
    _profileDto?.addressDtoList = addressDtoList;
  }

  factory CustomerDTO.fromJson(Map<String, dynamic> json) => CustomerDTO(
      id: json["Id"],
      profileId: json["ProfileId"],
      masterEntityId: json["MasterEntityId"],
      membershipId: json["MembershipId"],
      profileDto: ProfileDTO.fromJson(json["ProfileDTO"]),
      customDataSetDto: CustomDataSetDTO.fromJson(json["CustomDataSetDTO"]),
      creationDate: json["CreationDate"],
      lastUpdateDate: json["LastUpdateDate"],
      siteId: json["SiteId"],
      guid: json["Guid"],
      memberShipName: json["MemberShipName"],
      phone: json["PhoneNumber"],
      email: json["Email"]);

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ProfileId": profileId,
        "MasterEntityId": masterEntityId,
        "MembershipId": membershipId,
        "ProfileDTO": profileDto?.toJson(),
        "CustomDataSetDTO": customDataSetDto?.toJson(),
        "CreationDate": creationDate,
        "LastUpdateDate": lastUpdateDate,
        "SiteId": siteId,
        "Guid": guid,
        "MemberShipName": memberShipName,
        "PhoneNumber": phone,
        "Email": email
      };
}

enum CustomerDTOSearchParameter {
  customerId,
  contactNumber,
  emailId,
  firstName,
  lastName,
  fromDate,
  toDate,
  pageNumber,
  pageSize,
  buildChildRecords,
  activeRecordsOnly,
  profilePic,
  idPic,
  buildActiveCampaignActivity,
  loadSignedWaiverFileContent,
  loadSignedWaivers,
  loadAdultOnly,
  buildLastVistitedDate,
  customerGUID,
  customerMembershipId,
  uniqueIdentifier,
  middleName,
  phoneOrEmail
}
