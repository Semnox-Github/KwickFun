import 'dart:convert';

class AssetTypesDTO {
  int? Id;
  int? assetTypeId;
  String? name;
  int? masterEntityId;
  bool? isActive;
  String? createdBy;
  DateTime? creationDate;
  String? lastUpdatedBy;
  DateTime? lastUpdatedDate;
  String? guid;
  int? siteId;
  bool? synchStatus;
  bool? isChanged;

  bool? serverSync;
  DateTime? serverSyncTime;
  DateTime? appLastUpdatedTime;
  String? appLastUpdatedBy;

  AssetTypesDTO({
    this.Id,
    this.assetTypeId,
    this.name,
    this.masterEntityId,
    this.isActive,
    this.createdBy,
    this.creationDate,
    this.lastUpdatedBy,
    this.lastUpdatedDate,
    this.guid,
    this.siteId,
    this.synchStatus,
    this.isChanged,
    this.serverSync,
    this.serverSyncTime,
    this.appLastUpdatedTime,
    this.appLastUpdatedBy,
  });

  factory AssetTypesDTO.fromJson(String str) =>
      AssetTypesDTO.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AssetTypesDTO.fromMap(Map<String, dynamic> json) => AssetTypesDTO(
      Id: json["_Id"] == null ? null : json["_Id"],
      assetTypeId: json["AssetTypeId"] == null ? null : json["AssetTypeId"],
      name: json["Name"] == null ? null : json["Name"],
      masterEntityId:
          json["MasterEntityId"] == null ? null : json["MasterEntityId"],
      isActive: json["IsActive"] == false ? false : true,
      createdBy: json["CreatedBy"] == null ? null : json["CreatedBy"],
      creationDate: json["CreationDate"] == null
          ? null
          : json["CreationDate"] == ''
              ? null
              : DateTime.parse(json["CreationDate"]),
      lastUpdatedBy:
          json["LastUpdatedBy"] == null ? null : json["LastUpdatedBy"],
      lastUpdatedDate: json["LastUpdatedDate"] == null
          ? null
          : json["LastUpdatedDate"] == ''
              ? null
              : DateTime.parse(json["LastUpdatedDate"]),
      guid: json["Guid"] == null ? null : json["Guid"],
      siteId: json["SiteId"] == null ? null : json["Siteid"],
      synchStatus: json["SynchStatus"] == false ? false : true,
      isChanged: json["IsChanged"] == false ? false : true,
      serverSync: json["ServerSync"] == false ? false : true,
      serverSyncTime: json["ServerSyncTime"] == null
          ? null
          : json["ServerSyncTime"] == ''
              ? null
              : DateTime.parse(json["ServerSyncTime"]),
      appLastUpdatedTime: json["AppLastUpdatedTime"] == null
          ? null
          : json["AppLastUpdatedTime"] == ''
              ? null
              : DateTime.parse(json["AppLastUpdatedTime"]),
      appLastUpdatedBy:
          json["AppLastUpdatedBy"] == null ? null : json["AppLastUpdatedBy"]);

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['_Id'] = this.Id == null ? '' : Id;
    data['AssetTypeId'] = this.assetTypeId == null ? null : assetTypeId;
    data['Name'] = this.name == null ? null : name;
    data['MasterEntityId'] =
        this.masterEntityId == null ? null : masterEntityId;
    data['IsActive'] = this.isActive == false ? 0 : 1;
    data['CreatedBy'] = this.createdBy == null ? null : createdBy;
    data['CreationDate'] =
        this.creationDate == null ? null : creationDate!.toIso8601String();
    data['LastUpdatedBy'] = this.lastUpdatedBy == null ? null : lastUpdatedBy;
    data['LastUpdatedDate'] = this.lastUpdatedDate == null
        ? null
        : lastUpdatedDate!.toIso8601String();
    data['Guid'] = this.guid == null ? null : guid;
    data['SiteId'] = this.siteId == null ? null : siteId;
    data['SynchStatus'] = this.synchStatus == false ? 0 : 1;
    data['IsChanged'] = this.isChanged == false ? 0 : 1;
    data['ServerSync'] = this.serverSync == false ? 0 : 1;
    data['ServerSyncTime'] = this.serverSyncTime == null
        ? DateTime.now().toString()
        : serverSyncTime!.toIso8601String();
    data['AppLastUpdatedTime'] = this.appLastUpdatedTime == null
        ? DateTime.now().toString()
        : appLastUpdatedTime!.toIso8601String();
    data['AppLastUpdatedBy'] =
        this.appLastUpdatedBy == null ? null : appLastUpdatedBy;
    return data;
  }

  void RefreshServerValues(AssetTypesDTO element) {
    this.assetTypeId = element.assetTypeId;
    this.name = element.name;
    this.masterEntityId = element.masterEntityId;
    this.isActive = element.isActive;
    this.createdBy = element.createdBy;
    this.creationDate = element.creationDate;
    this.lastUpdatedBy = element.lastUpdatedBy;
    this.lastUpdatedDate = element.lastUpdatedDate;
    this.guid = element.guid;
    this.siteId = element.siteId;
    this.synchStatus = element.synchStatus;
    this.isChanged = element.isChanged;
  }
}

// ASSET_ID,SITE_ID
enum AssetsTypesDTOSearchParameter {
  ASSETTYPEID,
  ISACTIVE,
  ASSETTYPENAME,
  LASTUPDATEDDATE,
  SITEID
}
