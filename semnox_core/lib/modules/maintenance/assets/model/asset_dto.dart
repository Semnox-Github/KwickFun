import 'dart:convert';

class GenericAssetDTO {
  int? Id;
  int? assetId;
  String? name;
  String? description;
  int? machineid;
  int? assetTypeId;
  String? location;
  String? assetStatus;
  String? uRN;
  DateTime? purchaseDate;
  DateTime? saleDate;
  DateTime? scrapDate;
  int? assetTaxTypeId;
  double? purchaseValue;
  double? saleValue;
  double? scrapValue;
  int? masterEntityId;
  bool? isActive;
  String? createdBy;
  DateTime? creationDate;
  String? lastUpdatedBy;
  DateTime? lastUpdatedDate;
  String? guid;
  int? siteid;
  bool? synchStatus;
  bool? isChanged;

  bool? serverSync;
  DateTime? serverSyncTime;
  DateTime? appLastUpdatedTime;
  String? appLastUpdatedBy;

  GenericAssetDTO(
      {this.Id,
      this.assetId,
      this.name,
      this.description,
      this.machineid,
      this.assetTypeId,
      this.location,
      this.assetStatus,
      this.uRN,
      this.purchaseDate,
      this.saleDate,
      this.scrapDate,
      this.assetTaxTypeId,
      this.purchaseValue,
      this.saleValue,
      this.scrapValue,
      this.masterEntityId,
      this.isActive,
      this.createdBy,
      this.creationDate,
      this.lastUpdatedBy,
      this.lastUpdatedDate,
      this.guid,
      this.siteid,
      this.synchStatus,
      this.isChanged,
      this.serverSync,
      this.serverSyncTime,
      this.appLastUpdatedTime,
      this.appLastUpdatedBy});

  factory GenericAssetDTO.fromJson(String str) =>
      GenericAssetDTO.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GenericAssetDTO.fromMap(Map<String, dynamic> json) => GenericAssetDTO(
      Id: json["_Id"] == null ? null : json["_Id"],
      assetId: json["AssetId"] == null ? null : json["AssetId"],
      name: json["Name"] == null ? null : json["Name"],
      description: json["Description"] == null ? null : json["Description"],
      machineid: json["Machineid"] == null ? null : json["Machineid"],
      assetTypeId: json["AssetTypeId"] == null ? null : json["AssetTypeId"],
      location: json["Location"] == null ? null : json["Location"],
      assetStatus: json["AssetStatus"] == null ? null : json["AssetStatus"],
      uRN: json["URN"] == null ? null : json["URN"],
      purchaseDate: json["PurchaseDate"] == null
          ? null
          : json["PurchaseDate"] == ''
              ? null
              : DateTime.parse(json["PurchaseDate"]),
      saleDate: json["SaleDate"] == null
          ? null
          : json["SaleDate"] == ''
              ? null
              : DateTime.parse(json["SaleDate"]),
      scrapDate: json["ScrapDate"] == null
          ? null
          : json["ScrapDate"] == ''
              ? null
              : DateTime.parse(json["ScrapDate"]),
      assetTaxTypeId:
          json["AssetTaxTypeId"] == null ? null : json["AssetTaxTypeId"],
      purchaseValue:
          json["PurchaseValue"] == null ? null : json["PurchaseValue"],
      saleValue: json["SaleValue"] == null ? null : json["SaleValue"],
      scrapValue: json["ScrapValue"] == null ? null : json["ScrapValue"],
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
      siteid: json["Siteid"] == null ? null : json["Siteid"],
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
    data['AssetId'] = this.assetId == null ? null : assetId;
    data['Name'] = this.name == null ? null : name;
    data['Description'] = this.description == null ? null : description;
    data['Machineid'] = this.machineid == null ? null : machineid;
    data['AssetTypeId'] = this.assetTypeId == null ? null : assetTypeId;
    data['Location'] = this.location == null ? null : location;
    data['AssetStatus'] = this.assetStatus == null ? null : assetStatus;
    data['URN'] = this.uRN == null ? null : uRN;
    data['PurchaseDate'] =
        this.purchaseDate == null ? null : purchaseDate!.toIso8601String();
    data['SaleDate'] =
        this.saleDate == null ? null : saleDate!.toIso8601String();
    data['ScrapDate'] =
        this.scrapDate == null ? null : scrapDate!.toIso8601String();
    data['AssetTaxTypeId'] =
        this.assetTaxTypeId == null ? null : assetTaxTypeId;
    data['PurchaseValue'] = this.purchaseValue == null ? null : purchaseValue;
    data['SaleValue'] = this.saleValue == null ? null : saleValue;
    data['ScrapValue'] = this.scrapValue == null ? null : scrapValue;
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
    data['Siteid'] = this.siteid == null ? null : siteid;
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

  static Map<String, dynamic> jsonDecode(String data) {
    return json.decode(data);
  }

  void RefreshServerValues(GenericAssetDTO element) {
    this.assetId = element.assetId;
    this.name = element.name;
    this.description = element.description;
    this.machineid = element.machineid;
    this.assetTypeId = element.assetTypeId;
    this.location = element.location;
    this.assetStatus = element.assetStatus;
    this.uRN = element.uRN;
    this.purchaseDate = element.purchaseDate;
    this.saleDate = element.saleDate;
    this.scrapDate = element.scrapDate;
    this.assetTaxTypeId = element.assetTaxTypeId;
    this.purchaseValue = element.purchaseValue;
    this.saleValue = element.saleValue;
    this.scrapValue = element.scrapValue;
    this.masterEntityId = element.masterEntityId;
    this.isActive = element.isActive;
    this.createdBy = element.createdBy;
    this.creationDate = element.creationDate;
    this.lastUpdatedBy = element.lastUpdatedBy;
    this.lastUpdatedDate = element.lastUpdatedDate;
    this.guid = element.guid;
    this.siteid = element.siteid;
    this.synchStatus = element.synchStatus;
    this.isChanged = element.isChanged;
  }
}

// ASSET_ID,SITE_ID
enum AssetsGenericDTOSearchParameter {
  ISACTIVE,
  ASSETTYPE,
  FIRSTNAME,
  URN,
  ASSETSTATUS,
  LOCATION,
  BUILDASSETDETAILED,
  BUILDASSETLIMITED,
  SITEID,
}
