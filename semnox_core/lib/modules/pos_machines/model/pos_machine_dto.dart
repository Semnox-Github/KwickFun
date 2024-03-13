import 'dart:convert';

class PosMachineDTO {
  int? _posMachineId;
  String? _posName;
  int? _posTypeId;
  String? _attribute1;
  int? _inventoryLocationId;
  String? _guid;
  List<PosProductExclusionsContainerDTO>? _posProductExclusionsContainerDTO;
  List<PosPaymentModeInclusionContainerDTO>?
      _posPaymentModeInclusionContainerDTO;
  List<ProductDisplayGroupFormatContainerDTO>?
      _productDisplayGroupFormatContainerDTO;
  List<PosPrinterContainerDTO>? _posPrinterContainerDTO;
  List<int>? _includedProductId;
  List<int>? _productMenuId;
  List<int>? _facilityId;
  List<int>? _excludedProductMenuPanelId;
  List<PosCashdrawerContainerDTO>? _posCashdrawerContainerDTO;

  PosMachineDTO(
      {int? posMachineId,
      String? posName,
      int? posTypeId,
      String? attribute1,
      int? inventoryLocationId,
      String? guid,
      List<PosProductExclusionsContainerDTO>? posProductExclusionsContainerDTO,
      List<PosPaymentModeInclusionContainerDTO>?
          posPaymentModeInclusionContainerDTO,
      List<ProductDisplayGroupFormatContainerDTO>?
          productDisplayGroupFormatContainerDTO,
      List<PosPrinterContainerDTO>? posPrinterContainerDTO,
      List<int>? includedProductId,
      List<int>? productMenuId,
      List<int>? facilityId,
      List<int>? excludedProductMenuPanelId,
      List<PosCashdrawerContainerDTO>? posCashdrawerContainerDTO}) {
    _posMachineId = posMachineId;
    _posName = posName;
    _posTypeId = posTypeId;
    _attribute1 = attribute1;
    _inventoryLocationId = inventoryLocationId;
    _guid = guid;
    _posProductExclusionsContainerDTO = posProductExclusionsContainerDTO;
    _posPaymentModeInclusionContainerDTO = posPaymentModeInclusionContainerDTO;
    _productDisplayGroupFormatContainerDTO =
        productDisplayGroupFormatContainerDTO;
    _posPrinterContainerDTO = posPrinterContainerDTO;
    _includedProductId = includedProductId;
    _productMenuId = productMenuId;
    _facilityId = facilityId;
    _excludedProductMenuPanelId = excludedProductMenuPanelId;
    _posCashdrawerContainerDTO = posCashdrawerContainerDTO;
  }

  int? get posMachineId => _posMachineId;
  String? get posName => _posName;
  int? get posTypeId => _posTypeId;
  String? get attribute1 => _attribute1;
  int? get inventoryLocationId => _inventoryLocationId;
  String? get guid => _guid;
  List<PosProductExclusionsContainerDTO>?
      get posProductExclusionsContainerDTO => _posProductExclusionsContainerDTO;
  List<PosPaymentModeInclusionContainerDTO>?
      get posPaymentModeInclusionContainerDTO =>
          _posPaymentModeInclusionContainerDTO;
  List<ProductDisplayGroupFormatContainerDTO>?
      get productDisplayGroupFormatContainerDTO =>
          _productDisplayGroupFormatContainerDTO;
  List<PosPrinterContainerDTO>? get posPrinterContainerDTO =>
      _posPrinterContainerDTO;
  List<int>? get includedProductId => _includedProductId;
  List<int>? get productMenuId => _productMenuId;
  List<int>? get facilityId => _facilityId;
  List<int>? get excludedProductMenuPanelId => _excludedProductMenuPanelId;
  List<PosCashdrawerContainerDTO>? get posCashdrawerContainerDTO =>
      _posCashdrawerContainerDTO;

  factory PosMachineDTO.fromJson(String str) =>
      PosMachineDTO.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PosMachineDTO.fromMap(Map<String, dynamic> json) => PosMachineDTO(
        posMachineId: json["POSMachineId"],
        posName: json["POSName"],
        posTypeId: json["POSTypeId"],
        attribute1: json["Attribute1"],
        inventoryLocationId: json["InventoryLocationId"],
        guid: json["Guid"],
        posProductExclusionsContainerDTO:
            json["POSProductExclusionsContainerDTOList"] == null
                ? []
                : List<PosProductExclusionsContainerDTO>.from(
                    json["POSProductExclusionsContainerDTOList"].map(
                        (x) => PosProductExclusionsContainerDTO.fromMap(x))),
        posPaymentModeInclusionContainerDTO:
            json["POSPaymentModeInclusionContainerDTOList"] == null
                ? []
                : List<PosPaymentModeInclusionContainerDTO>.from(
                    json["POSPaymentModeInclusionContainerDTOList"].map(
                        (x) => PosPaymentModeInclusionContainerDTO.fromMap(x))),
        productDisplayGroupFormatContainerDTO:
            json["ProductDisplayGroupFormatContainerDTOList"] == null
                ? []
                : List<ProductDisplayGroupFormatContainerDTO>.from(
                    json["ProductDisplayGroupFormatContainerDTOList"].map((x) =>
                        ProductDisplayGroupFormatContainerDTO.fromMap(x))),
        posPrinterContainerDTO: json["POSPrinterContainerDTOList"] == null
            ? []
            : List<PosPrinterContainerDTO>.from(
                json["POSPrinterContainerDTOList"]
                    .map((x) => PosPrinterContainerDTO.fromMap(x))),
        includedProductId: json["IncludedProductIdList"] == null
            ? []
            : List<int>.from(json["IncludedProductIdList"].map((x) => x)),
        productMenuId: json["ProductMenuIdList"] == null
            ? []
            : List<int>.from(json["ProductMenuIdList"].map((x) => x)),
        facilityId: json["FacilityIdList"] == null
            ? []
            : List<int>.from(json["FacilityIdList"].map((x) => x)),
        excludedProductMenuPanelId:
            json["ExcludedProductMenuPanelIdList"] == null
                ? []
                : List<int>.from(
                    json["ExcludedProductMenuPanelIdList"].map((x) => x)),
        posCashdrawerContainerDTO: json["POSCashdrawerContainerDTOList"] == null
            ? []
            : List<PosCashdrawerContainerDTO>.from(
                json["POSCashdrawerContainerDTOList"]
                    .map((x) => PosCashdrawerContainerDTO.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "POSMachineId": posMachineId,
        "POSName": posName,
        "POSTypeId": posTypeId,
        "Attribute1": attribute1,
        "InventoryLocationId": inventoryLocationId,
        "Guid": guid,
        "POSProductExclusionsContainerDTOList":
            posProductExclusionsContainerDTO == null
                ? []
                : List<dynamic>.from(
                    posProductExclusionsContainerDTO!.map((x) => x.toMap())),
        "POSPaymentModeInclusionContainerDTOList":
            posPaymentModeInclusionContainerDTO == null
                ? []
                : List<dynamic>.from(
                    posPaymentModeInclusionContainerDTO!.map((x) => x.toMap())),
        "ProductDisplayGroupFormatContainerDTOList":
            productDisplayGroupFormatContainerDTO == null
                ? []
                : List<dynamic>.from(productDisplayGroupFormatContainerDTO!
                    .map((x) => x.toMap())),
        "POSPrinterContainerDTOList": posPrinterContainerDTO == null
            ? []
            : List<dynamic>.from(posPrinterContainerDTO!.map((x) => x.toMap())),
        "IncludedProductIdList": includedProductId == null
            ? []
            : List<dynamic>.from(includedProductId!.map((x) => x)),
        "ProductMenuIdList": productMenuId == null
            ? []
            : List<dynamic>.from(productMenuId!.map((x) => x)),
        "FacilityIdList": facilityId == null
            ? []
            : List<dynamic>.from(facilityId!.map((x) => x)),
        "ExcludedProductMenuPanelIdList": excludedProductMenuPanelId == null
            ? []
            : List<dynamic>.from(excludedProductMenuPanelId!.map((x) => x)),
        "POSCashdrawerContainerDTOList": posCashdrawerContainerDTO == null
            ? []
            : List<dynamic>.from(
                posCashdrawerContainerDTO!.map((x) => x.toMap())),
      };

  static List<PosMachineDTO>? getPosMachineDTOList(List<dynamic>? dtoList) {
    if (dtoList == null) {
      return null;
    }
    List<PosMachineDTO> posMachineDTO = [];
    posMachineDTO =
        List<PosMachineDTO>.from(dtoList.map((x) => PosMachineDTO.fromMap(x)));
    return posMachineDTO;
  }
}

class PosCashdrawerContainerDTO {
  PosCashdrawerContainerDTO({
    required this.posCashdrawerId,
    required this.posMachineId,
    required this.cashdrawerId,
    required this.isActive,
  });

  final int? posCashdrawerId;
  final int? posMachineId;
  final int? cashdrawerId;
  final bool? isActive;

  factory PosCashdrawerContainerDTO.fromJson(String str) =>
      PosCashdrawerContainerDTO.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PosCashdrawerContainerDTO.fromMap(Map<String, dynamic> json) =>
      PosCashdrawerContainerDTO(
        posCashdrawerId: json["POSCashdrawerId"],
        posMachineId: json["POSMachineId"],
        cashdrawerId: json["CashdrawerId"],
        isActive: json["IsActive"],
      );

  Map<String, dynamic> toMap() => {
        "POSCashdrawerId": posCashdrawerId,
        "POSMachineId": posMachineId,
        "CashdrawerId": cashdrawerId,
        "IsActive": isActive,
      };
}

class PosPaymentModeInclusionContainerDTO {
  PosPaymentModeInclusionContainerDTO({
    required this.posPaymentModeInclusionId,
    required this.posMachineId,
    required this.paymentModeId,
    required this.friendlyName,
  });

  final int? posPaymentModeInclusionId;
  final int? posMachineId;
  final int? paymentModeId;
  final String? friendlyName;

  factory PosPaymentModeInclusionContainerDTO.fromJson(String str) =>
      PosPaymentModeInclusionContainerDTO.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PosPaymentModeInclusionContainerDTO.fromMap(
          Map<String, dynamic> json) =>
      PosPaymentModeInclusionContainerDTO(
        posPaymentModeInclusionId: json["POSPaymentModeInclusionId"],
        posMachineId: json["POSMachineId"],
        paymentModeId: json["PaymentModeId"],
        friendlyName: json["FriendlyName"],
      );

  Map<String, dynamic> toMap() => {
        "POSPaymentModeInclusionId": posPaymentModeInclusionId,
        "POSMachineId": posMachineId,
        "PaymentModeId": paymentModeId,
        "FriendlyName": friendlyName,
      };
}

class PosPrinterContainerDTO {
  PosPrinterContainerDTO({
    required this.posPrinterId,
    required this.printerId,
    required this.secondaryPrinterId,
    required this.orderTypeGroupId,
    required this.posMachineId,
    required this.posTypeId,
    required this.printTemplateId,
    required this.printerTypeId,
    required this.printerName,
    required this.posPrinterOverrideRulesContainerDtoList,
  });

  final int? posPrinterId;
  final int? printerId;
  final int? secondaryPrinterId;
  final int? orderTypeGroupId;
  final int? posMachineId;
  final int? posTypeId;
  final int? printTemplateId;
  final int? printerTypeId;
  final String? printerName;
  final List<dynamic>? posPrinterOverrideRulesContainerDtoList;

  factory PosPrinterContainerDTO.fromJson(String str) =>
      PosPrinterContainerDTO.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PosPrinterContainerDTO.fromMap(Map<String, dynamic> json) =>
      PosPrinterContainerDTO(
        posPrinterId: json["POSPrinterId"],
        printerId: json["PrinterId"],
        secondaryPrinterId: json["SecondaryPrinterId"],
        orderTypeGroupId: json["OrderTypeGroupId"],
        posMachineId: json["POSMachineId"],
        posTypeId: json["POSTypeId"],
        printTemplateId: json["PrintTemplateId"],
        printerTypeId: json["PrinterTypeId"],
        printerName: json["PrinterName"],
        posPrinterOverrideRulesContainerDtoList:
            json["POSPrinterOverrideRulesContainerDTOList"] == null
                ? []
                : List<dynamic>.from(
                    json["POSPrinterOverrideRulesContainerDTOList"]
                        .map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "POSPrinterId": posPrinterId,
        "PrinterId": printerId,
        "SecondaryPrinterId": secondaryPrinterId,
        "OrderTypeGroupId": orderTypeGroupId,
        "POSMachineId": posMachineId,
        "POSTypeId": posTypeId,
        "PrintTemplateId": printTemplateId,
        "PrinterTypeId": printerTypeId,
        "PrinterName": printerName,
        "POSPrinterOverrideRulesContainerDTOList":
            posPrinterOverrideRulesContainerDtoList == null
                ? []
                : List<dynamic>.from(
                    posPrinterOverrideRulesContainerDtoList?.map((x) => x) ??
                        []),
      };
}

class PosProductExclusionsContainerDTO {
  PosProductExclusionsContainerDTO({
    required this.exclusionId,
    required this.posMachineId,
    required this.posTypeId,
    required this.productDisplayGroupFormatId,
    required this.productGroup,
  });

  final int? exclusionId;
  final int? posMachineId;
  final int? posTypeId;
  final int? productDisplayGroupFormatId;
  final String? productGroup;

  factory PosProductExclusionsContainerDTO.fromJson(String str) =>
      PosProductExclusionsContainerDTO.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PosProductExclusionsContainerDTO.fromMap(Map<String, dynamic> json) =>
      PosProductExclusionsContainerDTO(
        exclusionId: json["ExclusionId"],
        posMachineId: json["PosMachineId"],
        posTypeId: json["PosTypeId"],
        productDisplayGroupFormatId: json["ProductDisplayGroupFormatId"],
        productGroup: json["ProductGroup"],
      );

  Map<String, dynamic> toMap() => {
        "ExclusionId": exclusionId,
        "PosMachineId": posMachineId,
        "PosTypeId": posTypeId,
        "ProductDisplayGroupFormatId": productDisplayGroupFormatId,
        "ProductGroup": productGroup,
      };
}

class ProductDisplayGroupFormatContainerDTO {
  ProductDisplayGroupFormatContainerDTO({
    required this.id,
    required this.displayGroup,
    required this.buttonColor,
    required this.textColor,
    required this.font,
    required this.description,
    required this.externalSourceReference,
    required this.sortOrder,
    required this.imageUrl,
    required this.productIdList,
    required this.productsDisplayGroupContainerDtoList,
  });

  final int? id;
  final String? displayGroup;
  final String? buttonColor;
  final String? textColor;
  final String? font;
  final String? description;
  final String? externalSourceReference;
  final int? sortOrder;
  final String? imageUrl;
  final dynamic? productIdList;
  final List<dynamic>? productsDisplayGroupContainerDtoList;

  factory ProductDisplayGroupFormatContainerDTO.fromJson(String str) =>
      ProductDisplayGroupFormatContainerDTO.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductDisplayGroupFormatContainerDTO.fromMap(
          Map<String, dynamic> json) =>
      ProductDisplayGroupFormatContainerDTO(
        id: json["Id"],
        displayGroup: json["DisplayGroup"],
        buttonColor: json["ButtonColor"],
        textColor: json["TextColor"],
        font: json["Font"],
        description: json["Description"],
        externalSourceReference: json["ExternalSourceReference"],
        sortOrder: json["SortOrder"],
        imageUrl: json["ImageUrl"],
        productIdList: json["ProductIdList"],
        productsDisplayGroupContainerDtoList:
            json["ProductsDisplayGroupContainerDTOList"] == null
                ? []
                : List<dynamic>.from(
                    json["ProductsDisplayGroupContainerDTOList"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "Id": id,
        "DisplayGroup": displayGroup,
        "ButtonColor": buttonColor,
        "TextColor": textColor,
        "Font": font,
        "Description": description,
        "ExternalSourceReference": externalSourceReference,
        "SortOrder": sortOrder,
        "ImageUrl": imageUrl,
        "ProductIdList": productIdList,
        "ProductsDisplayGroupContainerDTOList":
            productsDisplayGroupContainerDtoList == null
                ? []
                : List<dynamic>.from(
                    productsDisplayGroupContainerDtoList!.map((x) => x)),
      };
}

enum PosMachineDTOSearchParameter {
  posMachineId,
  posTypeId,
  buildChildRecords,
  isActive,
  posMachineName,
  siteId,
  hash,
  rebuildCache
}
