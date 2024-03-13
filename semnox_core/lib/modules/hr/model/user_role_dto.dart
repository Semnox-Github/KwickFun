import 'package:semnox_core/modules/hr/model/management_form_access_dto.dart';
import 'package:semnox_core/modules/hr/model/users_dto.dart';

class UserRoleDTO {
  UserRoleDTO(
      {int? roleId,
      String? role,
      String? description,
      String? managerFlag,
      bool? manager,
      String? allowPosAccess,
      String? dataAccessLevel,
      String? guid,
      int? siteId,
      bool? synchStatus,
      String? lastUpdatedBy,
      String? lastUpdatedDate,
      bool? enablePosClockIn,
      bool? allowShiftOpenClose,
      int? securityPolicyId,
      int? masterEntityId,
      int? assignedManagerRoleId,
      int? dataAccessRuleId,
      bool? isActive,
      String? createdBy,
      String? creationDate,
      int? shiftConfigurationId,
      bool? cashDrawerRequired,
      bool? isSystemRole,
      List<UsersDto?>? usersDto,
      dynamic userRoleDisplayGroupExclusionsDtoList,
      dynamic userRolePriceListDtoList,
      List<ManagementFormAccessDtoList?>? managementFormAccessDtoList,
      List<dynamic>? productMenuPanelExclusionDtoList,
      bool? isChangedRecursive,
      bool? isChanged}) {
    _roleId = roleId;
    _role = role;
    _description = description;
    _managerFlag = managerFlag;
    _manager = manager;
    _allowPosAccess = allowPosAccess;
    _dataAccessLevel = dataAccessLevel;
    _guid = guid;
    _siteId = siteId;
    _synchStatus = synchStatus;
    _lastUpdatedBy = lastUpdatedBy;
    _lastUpdatedDate = lastUpdatedDate;
    _enablePosClockIn = enablePosClockIn;
    _allowShiftOpenClose = allowShiftOpenClose;
    _securityPolicyId = securityPolicyId;
    _masterEntityId = masterEntityId;
    _assignedManagerRoleId = assignedManagerRoleId;
    _dataAccessRuleId = dataAccessRuleId;
    _isActive = isActive;
    _createdBy = createdBy;
    _creationDate = creationDate;
    _shiftConfigurationId = shiftConfigurationId;
    _cashDrawerRequired = cashDrawerRequired;
    _isSystemRole = isSystemRole;
    _usersDto = usersDto;
    _userRoleDisplayGroupExclusionsDtoList =
        userRoleDisplayGroupExclusionsDtoList;
    _userRolePriceListDtoList = userRolePriceListDtoList;
    _managementFormAccessDtoList = managementFormAccessDtoList;
    _productMenuPanelExclusionDtoList = productMenuPanelExclusionDtoList;
    _isChangedRecursive = isChangedRecursive;
    _isChanged = isChanged;
  }

  int? _roleId;
  String? _role;
  String? _description;
  String? _managerFlag;
  bool? _manager;
  String? _allowPosAccess;
  String? _dataAccessLevel;
  String? _guid;
  int? _siteId;
  bool? _synchStatus;
  String? _lastUpdatedBy;
  String? _lastUpdatedDate;
  bool? _enablePosClockIn;
  bool? _allowShiftOpenClose;
  int? _securityPolicyId;
  int? _masterEntityId;
  int? _assignedManagerRoleId;
  int? _dataAccessRuleId;
  bool? _isActive;
  String? _createdBy;
  String? _creationDate;
  int? _shiftConfigurationId;
  bool? _cashDrawerRequired;
  bool? _isSystemRole;
  List<UsersDto?>? _usersDto;
  dynamic _userRoleDisplayGroupExclusionsDtoList;
  dynamic _userRolePriceListDtoList;
  List<ManagementFormAccessDtoList?>? _managementFormAccessDtoList;
  List<dynamic>? _productMenuPanelExclusionDtoList;
  bool? _isChangedRecursive;
  bool? _isChanged;

  int? get roleId => _roleId;
  String? get role => _role;
  String? get description => _description;
  String? get managerFlag => _managerFlag;
  bool? get manager => _manager;
  String? get allowPosAccess => _allowPosAccess;
  String? get dataAccessLevel => _dataAccessLevel;
  String? get guid => _guid;
  int? get siteId => _siteId;
  bool? get synchStatus => _synchStatus;
  String? get lastUpdatedBy => _lastUpdatedBy;
  String? get lastUpdatedDate => _lastUpdatedDate;
  bool? get enablePosClockIn => _enablePosClockIn;
  bool? get allowShiftOpenClose => _allowShiftOpenClose;
  int? get securityPolicyId => _securityPolicyId;
  int? get masterEntityId => _masterEntityId;
  int? get assignedManagerRoleId => _assignedManagerRoleId;
  int? get dataAccessRuleId => _dataAccessRuleId;
  bool? get isActive => _isActive;
  String? get createdBy => _createdBy;
  String? get creationDate => _creationDate;
  int? get shiftConfigurationId => _shiftConfigurationId;
  bool? get cashDrawerRequired => _cashDrawerRequired;
  bool? get isSystemRole => _isSystemRole;
  List<UsersDto?>? get usersDto => _usersDto;
  dynamic get userRoleDisplayGroupExclusionsDtoList =>
      _userRoleDisplayGroupExclusionsDtoList;
  dynamic get userRolePriceListDtoList => _userRolePriceListDtoList;
  List<ManagementFormAccessDtoList?>? get managementFormAccessDtoList =>
      _managementFormAccessDtoList;
  List<dynamic>? get productMenuPanelExclusionDtoList =>
      _productMenuPanelExclusionDtoList;
  bool? get isChangedRecursive => _isChangedRecursive;
  bool? get isChanged => _isChanged;

  factory UserRoleDTO.fromJson(Map<String, dynamic> json) => UserRoleDTO(
        roleId: json["RoleId"],
        role: json["Role"],
        description: json["Description"],
        managerFlag: json["ManagerFlag"],
        manager: json["Manager"],
        allowPosAccess: json["AllowPosAccess"],
        dataAccessLevel: json["DataAccessLevel"],
        guid: json["Guid"],
        siteId: json["SiteId"],
        synchStatus: json["SynchStatus"],
        lastUpdatedBy: json["LastUpdatedBy"],
        lastUpdatedDate: json["LastUpdatedDate"],
        enablePosClockIn: json["EnablePOSClockIn"],
        allowShiftOpenClose: json["AllowShiftOpenClose"],
        securityPolicyId: json["SecurityPolicyId"],
        masterEntityId: json["MasterEntityId"],
        assignedManagerRoleId: json["AssignedManagerRoleId"],
        dataAccessRuleId: json["DataAccessRuleId"],
        isActive: json["IsActive"],
        createdBy: json["CreatedBy"],
        creationDate: json["CreationDate"],
        shiftConfigurationId: json["ShiftConfigurationId"],
        cashDrawerRequired: json["CashDrawerRequired"],
        isSystemRole: json["IsSystemRole"],
        usersDto: json["UsersDTO"] == null
            ? []
            : List<UsersDto?>.from(
                json["UsersDTO"]!.map((x) => UsersDto.fromJson(x))),
        userRoleDisplayGroupExclusionsDtoList:
            json["UserRoleDisplayGroupExclusionsDTOList"],
        userRolePriceListDtoList: json["UserRolePriceListDTOList"],
        managementFormAccessDtoList: json["ManagementFormAccessDTOList"] == null
            ? []
            : List<ManagementFormAccessDtoList?>.from(
                json["ManagementFormAccessDTOList"]!
                    .map((x) => ManagementFormAccessDtoList.fromJson(x))),
        productMenuPanelExclusionDtoList:
            json["ProductMenuPanelExclusionDTOList"] == null
                ? []
                : List<dynamic>.from(
                    json["ProductMenuPanelExclusionDTOList"]!.map((x) => x)),
        isChangedRecursive: json["IsChangedRecursive"],
        isChanged: json["IsChanged"],
      );

  Map<String, dynamic> toJson() => {
        "RoleId": roleId,
        "Role": role,
        "Description": description,
        "ManagerFlag": managerFlag,
        "Manager": manager,
        "AllowPosAccess": allowPosAccess,
        "DataAccessLevel": dataAccessLevel,
        "Guid": guid,
        "SiteId": siteId,
        "SynchStatus": synchStatus,
        "LastUpdatedBy": lastUpdatedBy,
        "LastUpdatedDate": lastUpdatedDate,
        "EnablePOSClockIn": enablePosClockIn,
        "AllowShiftOpenClose": allowShiftOpenClose,
        "SecurityPolicyId": securityPolicyId,
        "MasterEntityId": masterEntityId,
        "AssignedManagerRoleId": assignedManagerRoleId,
        "DataAccessRuleId": dataAccessRuleId,
        "IsActive": isActive,
        "CreatedBy": createdBy,
        "CreationDate": creationDate,
        "ShiftConfigurationId": shiftConfigurationId,
        "CashDrawerRequired": cashDrawerRequired,
        "IsSystemRole": isSystemRole,
        "UsersDTO": usersDto == null
            ? []
            : List<dynamic>.from(usersDto!.map((x) => x!.toJson())),
        "UserRoleDisplayGroupExclusionsDTOList":
            userRoleDisplayGroupExclusionsDtoList,
        "UserRolePriceListDTOList": userRolePriceListDtoList,
        "ManagementFormAccessDTOList": managementFormAccessDtoList == null
            ? []
            : List<dynamic>.from(
                managementFormAccessDtoList!.map((x) => x!.toJson())),
        "ProductMenuPanelExclusionDTOList":
            productMenuPanelExclusionDtoList == null
                ? []
                : List<dynamic>.from(
                    productMenuPanelExclusionDtoList!.map((x) => x)),
        "IsChangedRecursive": isChangedRecursive,
        "IsChanged": isChanged,
      };

  static List<UserRoleDTO>? getUserRoleDTOList(List? dtoList) {
    if (dtoList == null) {
      return null;
    }
    List<UserRoleDTO> useroleDTOList = [];
    useroleDTOList =
        List<UserRoleDTO>.from(dtoList.map((x) => UserRoleDTO.fromJson(x)));
    return useroleDTOList;
  }
}

enum UserRoleViewDTOSearchParameter {
  // roleId,
  // userRole,
  // loadChildRecords,
  // isActive
  siteId,
  rebuildCache
} // Id