import 'dart:convert';

class TaskGroupsDTO {
  int? Id;
  int? jobTaskGroupId;
  String? taskGroupName;
  int? masterEntityId;
  bool? isActive;
  String? createdBy;
  DateTime? creationDate;
  String? lastUpdatedUser;
  DateTime? lastUpdatedDate;
  String? guid;
  int? siteId;
  bool? synchStatus;
  bool? isChanged;

  bool? serverSync;
  DateTime? serverSyncTime;
  DateTime? appLastUpdatedTime;
  String? appLastUpdatedBy;

  TaskGroupsDTO({
    this.Id,
    this.jobTaskGroupId,
    this.taskGroupName,
    this.masterEntityId,
    this.isActive,
    this.createdBy,
    this.creationDate,
    this.lastUpdatedUser,
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

  factory TaskGroupsDTO.fromJson(String str) =>
      TaskGroupsDTO.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TaskGroupsDTO.fromMap(Map<String, dynamic> json) => TaskGroupsDTO(
      Id: json["_Id"] == null ? null : json["_Id"],
      jobTaskGroupId:
          json["JobTaskGroupId"] == null ? null : json["JobTaskGroupId"],
      taskGroupName:
          json["TaskGroupName"] == null ? null : json["TaskGroupName"],
      masterEntityId:
          json["MasterEntityId"] == null ? null : json["MasterEntityId"],
      isActive: json["IsActive"] == false ? false : true,
      createdBy: json["CreatedBy"] == null ? null : json["CreatedBy"],
      creationDate: json["CreationDate"] == null
          ? null
          : json["CreationDate"] == ''
              ? null
              : DateTime.parse(json["CreationDate"]),
      lastUpdatedUser:
          json["LastUpdatedUser"] == null ? null : json["LastUpdatedUser"],
      lastUpdatedDate: json["LastUpdatedDate"] == null
          ? null
          : json["LastUpdatedDate"] == ''
              ? null
              : DateTime.parse(json["LastUpdatedDate"]),
      guid: json["Guid"] == null ? null : json["Guid"],
      siteId: json["SiteId"] == null ? null : json["SiteId"],
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
    // data['_Id'] = this.Id == null ? null : Id;
    data['JobTaskGroupId'] =
        this.jobTaskGroupId == null ? null : jobTaskGroupId;
    data['TaskGroupName'] = this.taskGroupName == null ? null : taskGroupName;
    data['MasterEntityId'] =
        this.masterEntityId == null ? null : masterEntityId;
    data['IsActive'] = this.isActive == false ? 0 : 1;
    data['CreatedBy'] = this.createdBy == null ? null : createdBy;
    data['CreationDate'] =
        this.creationDate == null ? null : creationDate!.toIso8601String();
    data['LastUpdatedUser'] =
        this.lastUpdatedUser == null ? null : lastUpdatedUser;
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

  void RefreshServerValues(TaskGroupsDTO element) {
    this.jobTaskGroupId = element.jobTaskGroupId;
    this.taskGroupName = element.taskGroupName;
    this.masterEntityId = element.masterEntityId;
    this.isActive = element.isActive;
    this.createdBy = element.createdBy;
    this.creationDate = element.creationDate;
    this.lastUpdatedUser = element.lastUpdatedUser;
    this.lastUpdatedDate = element.lastUpdatedDate;
    this.guid = element.guid;
    this.siteId = element.siteId;
    this.synchStatus = element.synchStatus;
    this.isChanged = element.isChanged;
  }
}

enum TaskGroupsDTOSearchParameter {
  TASKGROUPID,
  TASKGROUPNAME,
  ISACTIVE,
  HASACTIVETASK,
  SITEID
}
