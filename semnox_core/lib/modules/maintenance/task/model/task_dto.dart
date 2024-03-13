import 'dart:convert';

class TaskDto {
  TaskDto({
    this.Id,
    this.jobTaskId,
    this.taskName,
    this.jobTaskGroupId,
    this.validateTag,
    this.cardNumber,
    this.cardId,
    this.remarksMandatory,
    this.isActive,
    this.createdBy,
    this.creationDate,
    this.lastUpdatedBy,
    this.lastupdatedDate,
    this.guid,
    this.siteid,
    this.synchStatus,
    this.masterEntityId,
    this.isChanged,
    this.serverSync,
    this.serverSyncTime,
    this.appLastUpdatedTime,
    this.appLastUpdatedBy,
  });

  int? Id;
  int? jobTaskId;
  String? taskName;
  int? jobTaskGroupId;
  bool? validateTag;
  String? cardNumber;
  int? cardId;
  bool? remarksMandatory;
  bool? isActive;
  String? createdBy;
  DateTime? creationDate;
  String? lastUpdatedBy;
  DateTime? lastupdatedDate;
  String? guid;
  int? siteid;
  bool? synchStatus;
  int? masterEntityId;
  bool? isChanged;

  bool? serverSync;
  DateTime? serverSyncTime;
  DateTime? appLastUpdatedTime;
  String? appLastUpdatedBy;

  factory TaskDto.fromJson(String str) => TaskDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TaskDto.fromMap(Map<String, dynamic> json) => TaskDto(
      Id: json["_Id"] == null ? null : json["_Id"],
      jobTaskId: json["JobTaskId"] == null ? null : json["JobTaskId"],
      taskName: json["TaskName"] == null ? null : json["TaskName"],
      jobTaskGroupId:
          json["JobTaskGroupId"] == null ? null : json["JobTaskGroupId"],
      validateTag: json["ValidateTag"] == false ? false : true,
      cardNumber: json["CardNumber"] == null ? null : json["CardNumber"],
      cardId: json["CardId"] == null ? null : json["CardId"],
      remarksMandatory: json["RemarksMandatory"] == false ? false : true,
      isActive: json["IsActive"] == false ? false : true,
      createdBy: json["CreatedBy"] == null ? null : json["CreatedBy"],
      creationDate: json["CreationDate"] == null
          ? null
          : json["CreationDate"] == ''
              ? null
              : DateTime.parse(json["CreationDate"]),
      lastUpdatedBy:
          json["LastUpdatedBy"] == null ? null : json["LastUpdatedBy"],
      lastupdatedDate: json["LastupdatedDate"] == null
          ? null
          : json["LastupdatedDate"] == ''
              ? null
              : DateTime.parse(json["LastupdatedDate"]),
      guid: json["Guid"] == null ? null : json["Guid"],
      siteid: json["Siteid"] == null ? null : json["Siteid"],
      synchStatus: json["SynchStatus"] == false ? false : true,
      masterEntityId:
          json["MasterEntityId"] == null ? null : json["MasterEntityId"],
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
    data['JobTaskId'] = jobTaskId == null ? null : jobTaskId;
    data['TaskName'] = taskName == null ? null : taskName;
    data['JobTaskGroupId'] = jobTaskGroupId == null ? null : jobTaskGroupId;
    data['ValidateTag'] = validateTag == null ? null : validateTag;
    data['CardNumber'] = cardNumber == null ? null : cardNumber;
    data['CardId'] = cardId == null ? null : cardId;
    data['RemarksMandatory'] =
        remarksMandatory == null ? null : remarksMandatory;
    data['IsActive'] = isActive == null ? null : isActive;
    data['CreatedBy'] = createdBy == null ? null : createdBy;
    data['CreationDate'] = creationDate == null
        ? DateTime.now().toString()
        : creationDate!.toIso8601String();
    data['LastUpdatedBy'] = lastUpdatedBy == null ? null : lastUpdatedBy;
    data['LastupdatedDate'] = lastupdatedDate == null
        ? DateTime.now().toString()
        : lastupdatedDate!.toIso8601String();
    data['Guid'] = guid == null ? null : guid;
    data['Siteid'] = siteid == null ? null : siteid;
    data['SynchStatus'] = synchStatus == null ? null : synchStatus;
    data['MasterEntityId'] = masterEntityId == null ? null : masterEntityId;
    data['IsChanged'] = isChanged == null ? null : isChanged;
    data['ServerSync'] = serverSync == false ? 0 : 1;
    data['ServerSyncTime'] = serverSyncTime == null
        ? DateTime.now().toString()
        : serverSyncTime!.toIso8601String();
    data['AppLastUpdatedTime'] = appLastUpdatedTime == null
        ? DateTime.now().toString()
        : appLastUpdatedTime!.toIso8601String();
    data['AppLastUpdatedBy'] =
        appLastUpdatedBy == null ? null : appLastUpdatedBy;
    return data;
  }

  void refreshServerValues(TaskDto element) {
    jobTaskId = element.jobTaskId;
    taskName = element.taskName;
    jobTaskGroupId = element.jobTaskGroupId;
    validateTag = element.validateTag;
    cardNumber = element.cardNumber;
    cardId = element.cardId;
    remarksMandatory = element.remarksMandatory;
    isActive = element.isActive;
    createdBy = element.createdBy;
    creationDate = element.creationDate;
    lastUpdatedBy = element.lastUpdatedBy;
    lastupdatedDate = element.lastupdatedDate;
    guid = element.guid;
    siteid = element.siteid;
    synchStatus = element.synchStatus;
    masterEntityId = element.masterEntityId;
  }
}

enum TaskDTOSearchParameter { TASKID, ISACTIVE, TASKGROUPID, TASKNAME, SITEID }
