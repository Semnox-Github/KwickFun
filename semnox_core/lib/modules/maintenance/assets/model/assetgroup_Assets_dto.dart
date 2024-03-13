// To parse this JSON data, do
//
//     final assetGroupAssetsDto = assetGroupAssetsDtoFromJson(jsonString);

import 'dart:convert';

List<AssetGroupAssetsDto> assetGroupAssetsDtoFromJson(String str) =>
    List<AssetGroupAssetsDto>.from(
        json.decode(str).map((x) => AssetGroupAssetsDto.fromJson(x)));

String assetGroupAssetsDtoToJson(List<AssetGroupAssetsDto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AssetGroupAssetsDto {
  AssetGroupAssetsDto(
      {this.assetGroupAssetId,
      this.assetGroupId,
      this.assetId,
      this.isActive,
      this.guid,
      this.siteid,
      this.synchStatus,
      this.masterEntityId,
      this.lastUpdatedBy,
      this.createdBy,
      this.creationDate,
      this.lastUpdatedDate,
      this.isChanged,
      this.serverSync,
      this.serverSyncTime,
      this.appLastUpdatedTime,
      this.appLastUpdatedBy});

  int? assetGroupAssetId;
  int? assetGroupId;
  int? assetId;
  bool? isActive;
  String? guid;
  int? siteid;
  bool? synchStatus;
  int? masterEntityId;
  String? lastUpdatedBy;
  String? createdBy;
  DateTime? creationDate;
  DateTime? lastUpdatedDate;
  bool? isChanged;

  bool? serverSync;
  DateTime? serverSyncTime;
  DateTime? appLastUpdatedTime;
  String? appLastUpdatedBy;

  factory AssetGroupAssetsDto.fromJson(Map<String, dynamic> json) =>
      AssetGroupAssetsDto(
          assetGroupAssetId: json["AssetGroupAssetId"] == null
              ? null
              : json["AssetGroupAssetId"],
          assetGroupId:
              json["AssetGroupId"] == null ? null : json["AssetGroupId"],
          assetId: json["AssetId"] == null ? null : json["AssetId"],
          isActive: json["IsActive"] == false ? false : true,
          guid: json["Guid"] == null ? null : json["Guid"],
          siteid: json["Siteid"] == null ? null : json["Siteid"],
          synchStatus: json["SynchStatus"] == false ? false : true,
          masterEntityId:
              json["MasterEntityId"] == null ? null : json["MasterEntityId"],
          lastUpdatedBy:
              json["LastUpdatedBy"] == null ? null : json["LastUpdatedBy"],
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
          appLastUpdatedBy: json["AppLastUpdatedBy"] == null
              ? null
              : json["AppLastUpdatedBy"]);

  Map<String, dynamic> toJson() => {
        "AssetGroupAssetId":
            assetGroupAssetId == null ? null : assetGroupAssetId,
        "AssetGroupId": assetGroupId == null ? null : assetGroupId,
        "AssetId": assetId == null ? null : assetId,
        "IsActive": isActive == false ? 0 : 1,
        "Guid": guid == null ? null : guid,
        "Siteid": siteid == null ? null : siteid,
        "SynchStatus": synchStatus == false ? 0 : 1,
        "MasterEntityId": masterEntityId == null ? null : masterEntityId,
        "LastUpdatedBy": lastUpdatedBy == null ? null : lastUpdatedBy,
        "CreatedBy": createdBy == null ? null : createdBy,
        "CreationDate":
            creationDate == null ? null : creationDate!.toIso8601String(),
        "LastUpdatedDate":
            lastUpdatedDate == null ? null : lastUpdatedDate!.toIso8601String(),
        "IsChanged": isChanged == false ? 0 : 1,
        "ServerSync": serverSync == false ? 0 : 1,
        "ServerSyncTime": serverSyncTime == null
            ? DateTime.now().toString()
            : serverSyncTime!.toIso8601String(),
        "AppLastUpdatedTime": appLastUpdatedTime == null
            ? DateTime.now().toString()
            : appLastUpdatedTime!.toIso8601String(),
        "AppLastUpdatedBy": appLastUpdatedBy == null ? null : appLastUpdatedBy,
      };

  void RefreshServerValues(AssetGroupAssetsDto element) {
    this.assetGroupAssetId = element.assetGroupAssetId;
    this.assetGroupId = element.assetGroupId;
    this.assetId = element.assetId;
    this.isActive = element.isActive;
    this.guid = element.guid;
    this.siteid = element.siteid;
    this.synchStatus = element.synchStatus;
    this.masterEntityId = element.masterEntityId;
    this.lastUpdatedBy = element.lastUpdatedBy;
    this.createdBy = element.createdBy;
    this.creationDate = element.creationDate;
    this.lastUpdatedDate = element.lastUpdatedDate;
    this.isChanged = element.isChanged;
  }
}

// ASSET_ID,SITE_ID
enum AssetGroupAssetsDTOSearchParameter {
  ASSETGROUP_ASSETID,
  ISACTIVE,
  ASSETGROUPID,
  ASSETID,
  SITEID
}
