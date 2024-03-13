import 'dart:convert';

class ImageDTO {
  int? localImageId;
  int? imageId;
  int? maintCheckListDetailId;
  int? imageType;
  String? imageFileName;
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
  // String? imagePath;
  bool? serverSync;
  bool? fileupload;
  DateTime? serverSyncTime;
  DateTime? appLastUpdatedTime;
  String? appLastUpdatedBy;

  ImageDTO({
    this.localImageId,
    this.imageId,
    this.maintCheckListDetailId,
    this.imageType,
    this.imageFileName,
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
    // this.imagePath,
    this.serverSync,
    this.fileupload,
    this.serverSyncTime,
    this.appLastUpdatedTime,
    this.appLastUpdatedBy,
  });

  factory ImageDTO.fromJson(String str) => ImageDTO.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ImageDTO.fromMap(Map<String, dynamic> json) => ImageDTO(
      localImageId: json["LocalImageId"] == null ? null : json["LocalImageId"],
      imageId: json["ImageId"] == null ? null : json["ImageId"],
      maintCheckListDetailId: json["MaintCheckListDetailId"] == null
          ? null
          : json["MaintCheckListDetailId"],
      imageType: json["ImageType"] == null ? null : json["ImageType"],
      imageFileName:
          json["ImageFileName"] == null ? null : json["ImageFileName"],
      // imagePath: json['ImagePath'] == null ? null : json["ImagePath"],
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
      fileupload: json["FileUpload"] == false ? false : true,
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
    data['LocalImageId'] = this.localImageId == null ? null : localImageId;
    data['ImageId'] = this.imageId == null ? null : imageId;
    data['MaintCheckListDetailId'] =
        this.maintCheckListDetailId == null ? null : maintCheckListDetailId;
    data['ImageType'] = this.imageType == null ? null : imageType;
    data['ImageFileName'] = this.imageFileName == null ? null : imageFileName;
    // data['ImagePath'] = this.imagePath == null ? null : imagePath;
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
    data['FileUpload'] = this.fileupload == false ? 0 : 1;
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

  void RefreshServerValues(ImageDTO imageDTO) {
    this.imageId = imageDTO.imageId;
    this.maintCheckListDetailId = imageDTO.maintCheckListDetailId;
    this.imageType = imageDTO.imageType;
    this.imageFileName = imageDTO.imageFileName;
    this.masterEntityId = imageDTO.masterEntityId;
    this.isActive = imageDTO.isActive;
    this.createdBy = imageDTO.createdBy;
    this.creationDate = imageDTO.creationDate;
    this.lastUpdatedBy = imageDTO.lastUpdatedBy;
    this.lastUpdatedDate = imageDTO.lastUpdatedDate;
    this.guid = imageDTO.guid;
    this.siteId = imageDTO.siteId;
    this.synchStatus = imageDTO.synchStatus;
    this.isChanged = imageDTO.isChanged;
    // this.imagePath = imageDTO.imagePath;
    this.serverSync = imageDTO.serverSync;
    this.fileupload = imageDTO.fileupload;
  }
}

enum ImageSearchParameter {
  MAINTCHECKLISTDETAILID,
  SITEID,
  IMAGETYPE,
  LASTUPDATEDDATE,
  ISACTIVE,
  IMAGEID,
  SERVERSYNC
}
