import 'dart:convert';

class CommentsDTO {
  int? localcommentId;
  int? commentId;
  int? maintCheckListDetailId;
  int? commentType;
  String? comment;
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

  CommentsDTO({
    this.localcommentId,
    this.commentId,
    this.maintCheckListDetailId,
    this.commentType,
    this.comment,
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

  factory CommentsDTO.fromJson(String str) =>
      CommentsDTO.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommentsDTO.fromMap(Map<String, dynamic> json) => CommentsDTO(
      localcommentId:
          json["LocalCommentId"] == null ? null : json["LocalCommentId"],
      commentId: json["CommentId"] == null ? null : json["CommentId"],
      maintCheckListDetailId: json["MaintCheckListDetailId"] == null
          ? null
          : json["MaintCheckListDetailId"],
      commentType: json["CommentType"] == null ? null : json["CommentType"],
      comment: json["Comment"] == null ? null : json["Comment"],
      masterEntityId:
          json["MasterEntityId"] == null ? null : json["MasterEntityId"],
      isActive: json["IsActive"] == 0 ? false : true,
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
      siteId: json["Siteid"] == null ? null : json["Siteid"],
      synchStatus: json["SynchStatus"] == false ? false : true,
      serverSync: json["ServerSync"] == false ? false : true,
      isChanged: json["IsChanged"] == false ? false : true,
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
    data['LocalCommentId'] =
        this.localcommentId == null ? null : localcommentId;
    data['CommentId'] = this.commentId == null ? null : commentId;
    data['MaintCheckListDetailId'] =
        this.maintCheckListDetailId == null ? null : maintCheckListDetailId;
    data['CommentType'] = this.commentType == null ? null : commentType;
    data['Comment'] = this.comment == null ? null : comment;
    data['MasterEntityId'] =
        this.masterEntityId == null ? null : masterEntityId;
    data['IsActive'] = this.isActive == false ? 0 : 1;
    data['CreatedBy'] = this.createdBy == null ? null : createdBy;
    data['CreationDate'] =
        this.creationDate == null ? null : creationDate!.toLocal().toString();
    data['LastUpdatedBy'] = this.lastUpdatedBy == null ? null : lastUpdatedBy;
    data['LastUpdatedDate'] = this.lastUpdatedDate == null
        ? null
        : lastUpdatedDate!.toLocal().toString();
    data['Guid'] = this.guid == null ? null : guid;
    data['SiteId'] = siteId == null ? null : siteId;
    data['SynchStatus'] = this.synchStatus == false ? 0 : 1;
    data['IsChanged'] = this.isChanged == false ? 0 : 1;
    data['ServerSync'] = this.serverSync == false ? 0 : 1;
    data['ServerSyncTime'] = this.serverSyncTime == null
        ? DateTime.now().toString()
        : serverSyncTime!.toLocal().toString();
    data['AppLastUpdatedTime'] = this.appLastUpdatedTime == null
        ? DateTime.now().toString()
        : appLastUpdatedTime!.toLocal().toString();
    data['AppLastUpdatedBy'] =
        this.appLastUpdatedBy == null ? null : appLastUpdatedBy;
    return data;
  }

  void RefreshServerValues(CommentsDTO element) {
    this.commentId = element.commentId;
    this.maintCheckListDetailId = element.maintCheckListDetailId;
    this.commentType = element.commentType;
    this.comment = element.comment;
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
    this.serverSync = element.serverSync;
  }
}

enum CommentsSearchParameter {
  MAINTCHECKLISTDETAILID,
  SITEID,
  LASTUPDATEDDATE,
  ISACTIVE,
  COMMENTID,
  SERVERSYNC
}
