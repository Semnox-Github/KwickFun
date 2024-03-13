import 'dart:convert';

class TaskGroupViewSummaryDTO {
  String? taskgroupname;
  int? taskgroupId;
  int? tasktotal;
  int? taskpending;

  TaskGroupViewSummaryDTO(
      {this.taskgroupname, this.taskgroupId, this.tasktotal, this.taskpending});

  factory TaskGroupViewSummaryDTO.fromJson(String str) =>
      TaskGroupViewSummaryDTO.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TaskGroupViewSummaryDTO.fromMap(Map<String, dynamic> json) =>
      TaskGroupViewSummaryDTO(
        taskgroupname:
            json["TaskGroupName"] == null ? null : json["TaskGroupName"],
        taskgroupId: json["TaskGroupId"] == null ? null : json["TaskGroupId"],
        tasktotal: json["TaskTotal"] == null ? null : json["TaskTotal"],
        taskpending: json["TaskPending"] == null ? null : json["TaskPending"],
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TaskGroupName'] = this.taskgroupname == null ? null : taskgroupname;
    data['TaskGroupId'] = this.taskgroupId == null ? null : taskgroupId;
    data['TaskTotal'] = this.tasktotal == null ? null : tasktotal;
    data['TaskPending'] = this.taskpending == null ? null : taskpending;
    return data;
  }

  static Map<String, dynamic> jsonDecode(String data) {
    return json.decode(data);
  }
}

// ASSET_ID,SITE_ID
enum TaskGroupSummaryDTOSearchParameter {
  SITE_ID,
  ISACTIVE,
  STATUS,
  CHKLSTSCHEDULETIME,
  ASSIGNEDUSERID,
  MAINTJOBTYPE
}
