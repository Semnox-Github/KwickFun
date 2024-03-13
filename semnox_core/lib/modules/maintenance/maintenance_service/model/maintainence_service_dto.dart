import 'dart:convert';

class CheckListDetailDTO {
  int? Id;
  String? saveType;
  int? maintChklstdetId;
  int? localmaintChklstdetId;
  int? jobScheduleId;
  int? jobTaskId;
  String? maintJobName;
  int? maintJobType;
  DateTime? chklstScheduleTime;
  String? assignedTo;
  int? assignedUserId;
  int? departmentId;
  int? status;
  DateTime? checklistCloseDate;
  String? taskName;
  bool? validateTag;
  int? cardId;
  String? cardNumber;
  String? taskCardNumber;
  bool? remarksMandatory;
  int? assetId;
  String? assetName;
  String? assetType;
  String? assetGroupName;
  bool? chklistValue;
  String? chklistRemarks;
  String? sourceSystemId;
  int? durationToComplete;
  int? requestType;
  DateTime? requestDate;
  int? priority;
  String? requestDetail;
  String? imageName;
  String? requestedBy;
  String? contactPhone;
  String? contactEmailId;
  String? resolution;
  String? comments;
  double? repairCost;
  String? docFileName;
  String? attribute1;
  bool? isActive;
  String? createdBy;
  DateTime? creationDate;
  String? lastUpdatedBy;
  DateTime? lastUpdatedDate;
  String? guid;
  int? siteid;
  bool? synchStatus;
  int? masterEntityId;
  int? bookingId;
  int? bookingCheckListId;
  int? jobScheduleTaskId;
  String? maintJobNumber;
  bool? isChanged;
  List<dynamic>? maintenanceJobStatusDTOList;
  bool? isChangedRecursive;
  String? lookUpValue;
  bool? serverSync;
  DateTime? serverSyncTime;
  DateTime? appLastUpdatedTime;
  String? appLastUpdatedBy;

  CheckListDetailDTO({
    this.Id,
    this.saveType,
    this.maintChklstdetId,
    this.localmaintChklstdetId,
    this.jobScheduleId,
    this.jobTaskId,
    this.maintJobName,
    this.maintJobType,
    this.chklstScheduleTime,
    this.assignedTo,
    this.assignedUserId,
    this.departmentId,
    this.status,
    this.checklistCloseDate,
    this.taskName,
    this.validateTag,
    this.cardId,
    this.cardNumber,
    this.taskCardNumber,
    this.remarksMandatory,
    this.assetId,
    this.assetName,
    this.assetType,
    this.assetGroupName,
    this.chklistValue,
    this.chklistRemarks,
    this.sourceSystemId,
    this.durationToComplete,
    this.requestType,
    this.requestDate,
    this.priority,
    this.requestDetail,
    this.imageName,
    this.requestedBy,
    this.contactPhone,
    this.contactEmailId,
    this.resolution,
    this.comments,
    this.repairCost,
    this.docFileName,
    this.attribute1,
    this.isActive,
    this.createdBy,
    this.creationDate,
    this.lastUpdatedBy,
    this.lastUpdatedDate,
    this.guid,
    this.siteid,
    this.synchStatus,
    this.masterEntityId,
    this.bookingId,
    this.bookingCheckListId,
    this.jobScheduleTaskId,
    this.maintJobNumber,
    this.isChanged,
    this.maintenanceJobStatusDTOList,
    this.isChangedRecursive,
    this.lookUpValue,
    this.serverSync,
    this.serverSyncTime,
    this.appLastUpdatedTime,
    this.appLastUpdatedBy,
  });

  factory CheckListDetailDTO.fromJson(String str) =>
      CheckListDetailDTO.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CheckListDetailDTO.fromMap(Map<String, dynamic> json) =>
      CheckListDetailDTO(
          saveType: json["SaveType"],
          maintChklstdetId: json["MaintChklstdetId"],
          localmaintChklstdetId: json["LocalMaintChklstdetId"],
          jobScheduleId: json["JobScheduleId"],
          jobTaskId: json["JobTaskId"],
          maintJobName: json["MaintJobName"],
          maintJobType: json["MaintJobType"],
          chklstScheduleTime: json["ChklstScheduleTime"] == null
              ? null
              : json["ChklstScheduleTime"] == ''
                  ? null
                  : DateTime.parse(json["ChklstScheduleTime"]),
          assignedTo: json["AssignedTo"],
          assignedUserId: json["AssignedUserId"],
          departmentId: json["DepartmentId"],
          status: json["Status"],
          checklistCloseDate: json["ChecklistCloseDate"] == null
              ? null
              : json["ChecklistCloseDate"] == ''
                  ? null
                  : DateTime.now(),
          taskName: json["TaskName"],
          validateTag: json["ValidateTag"] != null
              ? json["ValidateTag"] == 1 || json["ValidateTag"] == true
                  ? true
                  : false
              : false,
          cardId: json["CardId"],
          cardNumber: json["CardNumber"],
          taskCardNumber: json["TaskCardNumber"],
          remarksMandatory: json["RemarksMandatory"] != null
              ? json["RemarksMandatory"] == 1 ||
                      json["RemarksMandatory"] == true
                  ? true
                  : false
              : false,
          assetId: json["AssetId"],
          assetName: json["AssetName"],
          assetType: json["AssetType"],
          assetGroupName: json["AssetGroupName"],
          chklistValue: json["ChklistValue"] != null
              ? json["ChklistValue"] == 1 || json["ChklistValue"] == true
                  ? true
                  : false
              : false,
          chklistRemarks: json["ChklistRemarks"],
          sourceSystemId: json["SourceSystemId"],
          durationToComplete: json["DurationToComplete"],
          requestType: json["RequestType"],
          requestDate: json["RequestDate"] == null
              ? null
              : json["RequestDate"] == ''
                  ? null
                  : DateTime.parse(json["RequestDate"]),
          priority: json["Priority"],
          requestDetail: json["RequestDetail"],
          imageName: json["ImageName"],
          requestedBy: json["RequestedBy"],
          contactPhone: json["ContactPhone"],
          contactEmailId: json["ContactEmailId"],
          resolution: json["Resolution"],
          comments: json["Comments"],
          repairCost: json["RepairCost"],
          docFileName: json["DocFileName"],
          attribute1: json["Attribute1"],
          isActive: json["IsActive"] != null
              ? json["IsActive"] == 1 || json["IsActive"] == true
                  ? true
                  : false
              : false,
          createdBy: json["CreatedBy"],
          creationDate: json["CreationDate"] == null
              ? null
              : json["CreationDate"] == ''
                  ? null
                  : DateTime.parse(json["CreationDate"]),
          lastUpdatedBy: json["LastUpdatedBy"],
          lastUpdatedDate: json["LastUpdatedDate"] == null
              ? null
              : json["LastUpdatedDate"] == ''
                  ? null
                  : DateTime.parse(json["LastUpdatedDate"]),
          guid: json["Guid"],
          siteid: json["Siteid"],
          synchStatus: json["SynchStatus"] != null
              ? json["SynchStatus"] == 1 || json["SynchStatus"] == true
                  ? true
                  : false
              : false,
          masterEntityId: json["MasterEntityId"],
          bookingId: json["BookingId"],
          bookingCheckListId: json["BookingCheckListId"],
          jobScheduleTaskId: json["JobScheduleTaskId"],
          maintJobNumber: json["MaintJobNumber"],
          isChanged: json["IsChanged"] != null
              ? json["IsChanged"] == 1 || json["IsChanged"] == true
                  ? true
                  : false
              : false,
          maintenanceJobStatusDTOList: json["MaintenanceJobStatusDTOList"],
          isChangedRecursive: json["IsChangedRecursive"] != null
              ? json["IsChangedRecursive"] == 1 ||
                      json["IsChangedRecursive"] == true
                  ? true
                  : false
              : false,
          lookUpValue: json["LookUpValue"],
          serverSync: json["ServerSync"] != null
              ? json["ServerSync"] == 1 || json["ServerSync"] == true
                  ? true
                  : false
              : false,
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
          appLastUpdatedBy: json["AppLastUpdatedBy"]);

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MaintChklstdetId'] = maintChklstdetId;
    data['LocalMaintChklstdetId'] = localmaintChklstdetId;
    data['JobScheduleId'] = jobScheduleId;
    data['JobTaskId'] = jobTaskId;
    data['MaintJobName'] = maintJobName;
    data['MaintJobType'] = maintJobType;
    data['ChklstScheduleTime'] = chklstScheduleTime == null
        ? null
        : chklstScheduleTime!.toLocal().toString();
    data['AssignedTo'] = assignedTo;
    data['AssignedUserId'] = assignedUserId;
    data['DepartmentId'] = departmentId;
    data['Status'] = status;
    data['ChecklistCloseDate'] = checklistCloseDate == null
        ? null
        : checklistCloseDate!.toLocal().toString();
    data['TaskName'] = taskName;
    data['ValidateTag'] = validateTag != null ? validateTag ?? false : false;
    data['CardId'] = cardId;
    data['CardNumber'] = cardNumber;
    data['TaskCardNumber'] = taskCardNumber;
    data['RemarksMandatory'] =
        remarksMandatory != null ? remarksMandatory ?? false : false;
    data['AssetId'] = assetId;
    data['AssetName'] = assetName;
    data['AssetType'] = assetType;
    data['AssetGroupName'] = assetGroupName;
    data['ChklistValue'] = chklistValue != null ? chklistValue ?? false : false;
    data['ChklistRemarks'] = chklistRemarks;
    data['SourceSystemId'] = sourceSystemId;
    data['DurationToComplete'] = durationToComplete;
    data['RequestType'] = requestType;
    data['RequestDate'] =
        requestDate == null ? null : requestDate!.toLocal().toString();
    data['Priority'] = priority;
    data['RequestDetail'] = requestDetail;
    data['ImageName'] = imageName;
    data['RequestedBy'] = requestedBy;
    data['ContactPhone'] = contactPhone;
    data['ContactEmailId'] = contactEmailId;
    data['Resolution'] = resolution;
    data['Comments'] = comments;
    data['RepairCost'] = repairCost;
    data['DocFileName'] = docFileName;
    data['Attribute1'] = attribute1;
    data['IsActive'] = isActive != null ? isActive ?? false : false;
    data['CreatedBy'] = createdBy;
    data['CreationDate'] =
        creationDate == null ? null : creationDate!.toLocal().toString();
    data['LastUpdatedBy'] = lastUpdatedBy;
    data['LastUpdatedDate'] =
        lastUpdatedDate == null ? null : lastUpdatedDate!.toLocal().toString();
    data['Guid'] = guid;
    data['Siteid'] = siteid;
    data['SynchStatus'] = synchStatus != null ? synchStatus ?? false : false;
    data['MasterEntityId'] = masterEntityId;
    data['BookingId'] = bookingId;
    data['BookingCheckListId'] = bookingCheckListId;
    data['JobScheduleTaskId'] = jobScheduleTaskId;
    data['MaintJobNumber'] = maintJobNumber;
    data['IsChanged'] = isChanged != null ? isChanged ?? false : false;
    data['IsChangedRecursive'] =
        isChangedRecursive != null ? isChangedRecursive ?? false : false;
    data['ServerSync'] = serverSync != null ? serverSync ?? false : false;
    data['ServerSyncTime'] = serverSyncTime == null
        ? DateTime.now().toString()
        : serverSyncTime!.toLocal().toString();
    data['AppLastUpdatedTime'] = appLastUpdatedTime == null
        ? DateTime.now().toString()
        : appLastUpdatedTime!.toLocal().toString();
    data['AppLastUpdatedBy'] = appLastUpdatedBy;
    return data;
  }

  Map<String, dynamic> toseverMap() => {
        "SaveType": "Save",
        "MaintChklstdetId": maintChklstdetId,
        "JobScheduleId": jobScheduleId,
        "JobTaskId": jobTaskId,
        "MaintJobName": maintJobName,
        "MaintJobType": maintJobType,
        "ChklstScheduleTime": chklstScheduleTime == null
            ? null
            : chklstScheduleTime!.toLocal().toString(),
        "AssignedTo": assignedTo,
        "AssignedUserId": assignedUserId,
        "DepartmentId": departmentId,
        "Status": status,
        "ChecklistCloseDate": checklistCloseDate == null
            ? null
            : checklistCloseDate!.toLocal().toString(),
        "TaskName": taskName,
        "ValidateTag": validateTag != null ? validateTag ?? false : false,
        "CardId": cardId,
        "CardNumber": cardNumber,
        "TaskCardNumber": taskCardNumber,
        "RemarksMandatory":
            remarksMandatory != null ? remarksMandatory ?? false : false,
        "AssetId": assetId,
        "AssetName": assetName,
        "AssetType": assetType,
        "AssetGroupName": assetGroupName,
        "ChklistValue": chklistValue != null ? chklistValue ?? false : false,
        "ChklistRemarks": chklistRemarks,
        "SourceSystemId": sourceSystemId,
        "DurationToComplete": durationToComplete,
        "RequestType": requestType,
        "RequestDate":
            requestDate == null ? null : requestDate!.toLocal().toString(),
        "Priority": priority,
        "RequestDetail": requestDetail,
        "ImageName": imageName,
        "RequestedBy": requestedBy,
        "ContactPhone": contactPhone,
        "ContactEmailId": contactEmailId,
        "Resolution": resolution,
        "Comments": comments,
        "RepairCost": repairCost,
        "DocFileName": docFileName,
        "Attribute": attribute1,
        "IsActive": isActive != null ? isActive ?? false : false,
        "CreatedBy": createdBy,
        "CreationDate":
            creationDate == null ? null : creationDate!.toLocal().toString(),
        "LastUpdatedBy": lastUpdatedBy,
        "LastUpdatedDate": lastUpdatedDate == null
            ? null
            : lastUpdatedDate!.toLocal().toString(),
        "Guid": guid,
        "Siteid": siteid,
        "SynchStatus": synchStatus != null ? synchStatus ?? false : false,
        "MasterEntityId": masterEntityId,
        "BookingId": bookingId,
        "BookingCheckListId": bookingCheckListId,
        "JobScheduleTaskId": jobScheduleTaskId,
        "MaintJobNumber": maintJobNumber,
        "IsChanged": isChanged != null ? isChanged ?? false : false,
        "IsChangedRecursive":
            isChangedRecursive != null ? isChangedRecursive ?? false : false,
      };

  static List<CheckListDetailDTO>? getCheckListDetailDTOList(List? dtoList) {
    if (dtoList == null) {
      return null;
    }
    List<CheckListDetailDTO> checkListDetailDTOList = [];
    checkListDetailDTOList = List<CheckListDetailDTO>.from(
        dtoList.map((x) => CheckListDetailDTO.fromMap(x)));
    return checkListDetailDTOList;
  }

  void refreshServerValues(CheckListDetailDTO element) {
    saveType = element.saveType;
    maintChklstdetId = element.maintChklstdetId;
    jobScheduleId = element.jobScheduleId;
    jobTaskId = element.jobTaskId;
    maintJobName = element.maintJobName;
    maintJobType = element.maintJobType;
    chklstScheduleTime = element.chklstScheduleTime;
    assignedTo = element.assignedTo;
    assignedUserId = element.assignedUserId;
    departmentId = element.departmentId;
    status = element.status;
    checklistCloseDate = element.checklistCloseDate;
    taskName = element.taskName;
    validateTag = element.validateTag;
    cardId = element.cardId;
    cardNumber = element.cardNumber;
    taskCardNumber = element.taskCardNumber;
    remarksMandatory = element.remarksMandatory;
    assetId = element.assetId;
    assetName = element.assetName;
    assetType = element.assetType;
    assetGroupName = element.assetGroupName;
    chklistValue = element.chklistValue;
    chklistRemarks = element.chklistRemarks;
    sourceSystemId = element.sourceSystemId;
    durationToComplete = element.durationToComplete;
    requestType = element.requestType;
    requestDate = element.requestDate;
    priority = element.priority;
    requestDetail = element.requestDetail;
    imageName = element.imageName;
    requestedBy = element.requestedBy;
    contactPhone = element.contactPhone;
    contactEmailId = element.contactEmailId;
    resolution = element.resolution;
    comments = element.comments;
    repairCost = element.repairCost;
    docFileName = element.docFileName;
    attribute1 = element.attribute1;
    isActive = element.isActive;
    createdBy = element.createdBy;
    creationDate = element.creationDate;
    lastUpdatedBy = element.lastUpdatedBy;
    lastUpdatedDate = element.lastUpdatedDate;
    guid = element.guid;
    siteid = element.siteid;
    synchStatus = element.synchStatus;
    masterEntityId = element.masterEntityId;
    bookingId = element.bookingId;
    bookingCheckListId = element.bookingCheckListId;
    jobScheduleTaskId = element.jobScheduleTaskId;
    maintJobNumber = element.maintJobNumber;
    isChanged = element.isChanged;
    maintenanceJobStatusDTOList = element.maintenanceJobStatusDTOList;
    isChangedRecursive = element.isChangedRecursive;
    lookUpValue = element.lookUpValue;
  }
}

enum CheckListDetailSearchParameter {
  ACTIVITYTYPE,
  ISACTIVE,
  STATUS,
  REQUESTTYPE,
  PRIORITY,
  SCHEDULEFROMDATE,
  SCHEDULETODATE,
  REQFROMDATE,
  REQTODATE,
  JOBID,
  TASKID,
  ASSIGNEDTO,
  JOBSPASTDUEDATE,
  LOADACTIVECHILD,
  BUILDCHILDRECORDS,
  REQUESTBY,
  SITEID,
  JOBTYPE,
  TASKNAME,
  APPLASTUPDATEDTIME,
  SERVERSYNC,
  ASSIGNEDUSERID,
  ASSETID,
  ChklstScheduleTime,
}
