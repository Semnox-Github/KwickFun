class ManagementFormAccessDtoList {
  ManagementFormAccessDtoList(
      {int? managementFormAccessId,
      int? roleId,
      String? mainMenu,
      String? formName,
      bool? accessAllowed,
      int? functionId,
      String? functionGroup,
      String? functionGuid,
      int? siteId,
      int? masterEntityId,
      bool? synchStatus,
      String? guid,
      String? createdBy,
      String? creationDate,
      String? lastUpdatedBy,
      String? lastUpdateDate,
      bool? isChanged}) {
    _managementFormAccessId = managementFormAccessId;
    _roleId = roleId;
    _mainMenu = mainMenu;
    _formName = formName;
    _accessAllowed = accessAllowed;
    _functionId = functionId;
    _functionGroup = functionGroup;
    _functionGuid = functionGuid;
    _siteId = siteId;
    _masterEntityId = masterEntityId;
    _synchStatus = synchStatus;
    _guid = guid;
    _createdBy = createdBy;
    _creationDate = creationDate;
    _lastUpdatedBy = lastUpdatedBy;
    _lastUpdateDate = lastUpdateDate;
    _isChanged = isChanged;
  }

  int? _managementFormAccessId;
  int? _roleId;
  String? _mainMenu;
  String? _formName;
  bool? _accessAllowed;
  int? _functionId;
  String? _functionGroup;
  String? _functionGuid;
  int? _siteId;
  int? _masterEntityId;
  bool? _synchStatus;
  String? _guid;
  String? _createdBy;
  String? _creationDate;
  String? _lastUpdatedBy;
  String? _lastUpdateDate;
  bool? _isChanged;

  int? get managementFormAccessId => _managementFormAccessId;
  int? get roleId => _roleId;
  String? get mainMenu => _mainMenu;
  String? get formName => _formName;
  bool? get accessAllowed => _accessAllowed;
  int? get functionId => _functionId;
  String? get functionGroup => _functionGroup;
  String? get functionGuid => _functionGuid;
  int? get siteId => _siteId;
  int? get masterEntityId => _masterEntityId;
  bool? get synchStatus => _synchStatus;
  String? get guid => _guid;
  String? get createdBy => _createdBy;
  String? get creationDate => _creationDate;
  String? get lastUpdatedBy => _lastUpdatedBy;
  String? get lastUpdateDate => _lastUpdateDate;
  bool? get isChanged => _isChanged;

  factory ManagementFormAccessDtoList.fromJson(Map<String, dynamic> json) =>
      ManagementFormAccessDtoList(
        managementFormAccessId: json["ManagementFormAccessId"],
        roleId: json["RoleId"],
        mainMenu: json["MainMenu"],
        formName: json["FormName"],
        accessAllowed: json["AccessAllowed"],
        functionId: json["FunctionId"],
        functionGroup: json["FunctionGroup"],
        functionGuid: json["FunctionGUID"],
        siteId: json["SiteId"],
        masterEntityId: json["MasterEntityId"],
        synchStatus: json["SynchStatus"],
        guid: json["Guid"],
        createdBy: json["CreatedBy"],
        creationDate: json["CreationDate"],
        lastUpdatedBy: json["LastUpdatedBy"],
        lastUpdateDate: json["LastUpdateDate"],
        isChanged: json["IsChanged"],
      );

  Map<String, dynamic> toJson() => {
        "ManagementFormAccessId": managementFormAccessId,
        "RoleId": roleId,
        "MainMenu": mainMenu,
        "FormName": formName,
        "AccessAllowed": accessAllowed,
        "FunctionId": functionId,
        "FunctionGroup": functionGroup,
        "FunctionGUID": functionGuid,
        "SiteId": siteId,
        "MasterEntityId": masterEntityId,
        "SynchStatus": synchStatus,
        "Guid": guid,
        "CreatedBy": createdBy,
        "CreationDate": creationDate,
        "LastUpdatedBy": lastUpdatedBy,
        "LastUpdateDate": lastUpdateDate,
        "IsChanged": isChanged,
      };
}
