import 'dart:convert';

class AssetGroupsDTO {
  int? Id;
  int? assetGroupId;
  String? assetGroupName;
  int? masterEntityId;
  bool? isActive;
  String? createdBy;
  DateTime? creationDate;
  DateTime? lastUpdatedDate;
  String? lastUpdatedBy;
  String? guid;
  int? siteId;
  bool? synchStatus;
  bool? isChanged;

  bool? serverSync;
  DateTime? serverSyncTime;
  DateTime? appLastUpdatedTime;
  String? appLastUpdatedBy;

  AssetGroupsDTO({
    this.Id,
    this.assetGroupId,
    this.assetGroupName,
    this.masterEntityId,
    this.isActive,
    this.createdBy,
    this.creationDate,
    this.lastUpdatedDate,
    this.lastUpdatedBy,
    this.guid,
    this.siteId,
    this.synchStatus,
    this.isChanged,
    this.serverSync,
    this.serverSyncTime,
    this.appLastUpdatedTime,
    this.appLastUpdatedBy,
  });

  factory AssetGroupsDTO.fromJson(String str) =>
      AssetGroupsDTO.fromMap(json.decode(str));

  String toJson() => json.encode(toJson());

  factory AssetGroupsDTO.fromMap(Map<String, dynamic> json) => AssetGroupsDTO(
      Id: json["_Id"] == null ? null : json["_Id"],
      assetGroupId: json["AssetGroupId"] == null ? null : json["AssetGroupId"],
      assetGroupName:
          json["AssetGroupName"] == null ? null : json["AssetGroupName"],
      masterEntityId:
          json["MasterEntityId"] == null ? null : json["MasterEntityId"],
      isActive: json["IsActive"] == false ? false : true,
      createdBy: json["CreatedBy"] == null ? null : json["CreatedBy"],
      creationDate: json["CreationDate"] == null
          ? null
          : json["CreationDate"] == ''
              ? null
              : DateTime.parse(json["CreationDate"]),
      lastUpdatedDate: json["LastUpdatedDate"] == null
          ? null
          : json["LastUpdatedDate"] == ''
              ? null
              : DateTime.parse(json["LastUpdatedDate"]),
      lastUpdatedBy:
          json["LastUpdatedBy"] == null ? null : json["LastUpdatedBy"],
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
    data['AssetGroupId'] = this.assetGroupId == null ? null : assetGroupId;
    data['AssetGroupName'] =
        this.assetGroupName == null ? null : assetGroupName;
    data['MasterEntityId'] =
        this.masterEntityId == null ? null : masterEntityId;
    data['IsActive'] = this.isActive == false ? 0 : 1;
    data['CreatedBy'] = this.createdBy == null ? null : createdBy;
    data['CreationDate'] =
        this.creationDate == null ? null : creationDate!.toIso8601String();
    data['LastUpdatedDate'] = this.lastUpdatedDate == null
        ? null
        : lastUpdatedDate!.toIso8601String();
    data['LastUpdatedBy'] = this.lastUpdatedBy == null ? null : lastUpdatedBy;
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

  void RefreshServerValues(AssetGroupsDTO element) {
    this.assetGroupId = element.assetGroupId;
    this.assetGroupName = element.assetGroupName;
    this.masterEntityId = element.masterEntityId;
    this.isActive = element.isActive;
    this.createdBy = element.createdBy;
    this.creationDate = element.creationDate;
    this.lastUpdatedDate = element.lastUpdatedDate;
    this.lastUpdatedBy = element.lastUpdatedBy;
    this.guid = element.guid;
    this.siteId = element.siteId;
    this.synchStatus = element.synchStatus;
    this.isChanged = element.isChanged;
  }
}

enum AssetGroupsDTOSearchParameter { ASSETGROUPID, ISACTIVE, GROUPNAME, SITEID }
