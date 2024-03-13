import 'package:intl/intl.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/lookups/bl/lookup_view_bl.dart';
import 'package:semnox_core/modules/lookups/model/lookup_container_dto.dart';

class MaintainanceLookupsAndRulesBL {
  late ExecutionContextDTO _executionContextDTO;
  static List<LookupsContainerDTO>? _lookupsContainerDTOList = [];
  int? siteId;

  MaintainanceLookupsAndRulesBL(ExecutionContextDTO executionContextDTO) {
    _executionContextDTO = executionContextDTO;
  }

  Future<List<LookupValuesContainerDtoList>?> getservicerequeststatus(
      String? srmenuClicked) async {
    List<LookupValuesContainerDtoList>? lookupcontainer = [];
    if (srmenuClicked == "Open") {
      lookupcontainer.addAll(await srall());
      var lookupList =
          await addstatusbylookupname("MAINTENANCE_OPEN_JOB_STATUS_TRANSITION");
      lookupList.removeWhere((element) => element.lookupValue == "RESOLVED");
      var lookups = await addstatusbylookupname(
          "MAINTENANCE_RESOLVED_JOB_STATUS_TRANSITION");
      lookups.retainWhere((element) => element.lookupValue == 'REOPEN');
      lookupcontainer.addAll(lookups);
      lookupcontainer.addAll(lookupList);
    } else if (srmenuClicked == "Resolved") {
      lookupcontainer.addAll(await srall());
      var lookupList =
          await addstatusbylookupname("MAINTENANCE_OPEN_JOB_STATUS_TRANSITION");
      var lookup =
          lookupList.where((element) => element.lookupValue == "RESOLVED");
      lookupcontainer.addAll(lookup);
      lookupcontainer.addAll(await addstatusbylookupname(
          "MAINTENANCE_RESOLVED_JOB_STATUS_TRANSITION"));
      lookupcontainer.removeWhere((element) => element.lookupValue == 'REOPEN');
    } else if (srmenuClicked == "Draft") {
      // lookupcontainer.addAll(await srall());
      lookupcontainer.addAll(await addstatusbylookupname(
          "MAINTENANCE_DRAFT_JOB_STATUS_TRANSITION"));
    } else {
      lookupcontainer.addAll(await srall());
      lookupcontainer.addAll(await addstatusbylookupname("MAINT_REQUEST_TYPE"));
      lookupcontainer.addAll(await addstatusbylookupname(
          "MAINTENANCE_DRAFT_JOB_STATUS_TRANSITION"));
      lookupcontainer.addAll(await addstatusbylookupname(
          "MAINTENANCE_OPEN_JOB_STATUS_TRANSITION"));
      lookupcontainer.addAll(await addstatusbylookupname(
          "MAINTENANCE_RESOLVED_JOB_STATUS_TRANSITION"));
    }
    return lookupcontainer;
  }

  Future<List<LookupValuesContainerDtoList>> srall() async {
    List<LookupValuesContainerDtoList> maintOpenJobStatusTransitionList = [];
    LookupValuesContainerDtoList lookupContainerDtoList =
        LookupValuesContainerDtoList();
    lookupContainerDtoList.lookupValueId = -1;
    lookupContainerDtoList.lookupName = 'MAINT_ALL';
    lookupContainerDtoList.lookupValue = 'ALL';
    maintOpenJobStatusTransitionList.add(lookupContainerDtoList);
    return maintOpenJobStatusTransitionList;
  }

  Future<List<LookupValuesContainerDtoList>> addstatusbylookupname(
      String lookupName) async {
    _lookupsContainerDTOList =
        await LookupViewListBL(_executionContextDTO).getLookUp();
    Iterable<LookupsContainerDTO>? list =
        _lookupsContainerDTOList?.where((e) => e.lookupName == lookupName);

    List<LookupValuesContainerDtoList>? lookupValuesContainerDtoList = [];
    lookupValuesContainerDtoList =
        await filterLookupValuesContainerDtoList(list!);
    return lookupValuesContainerDtoList;
  }

  Future<List<LookupValuesContainerDtoList>> getJobType() async {
    _lookupsContainerDTOList =
        await LookupViewListBL(_executionContextDTO).getLookUp();
    Iterable<LookupsContainerDTO>? list = _lookupsContainerDTOList
        ?.where((e) => e.lookupName == "MAINT_JOB_TYPE");
    List<LookupValuesContainerDtoList>? lookupValuesContainerDtoList = [];
    lookupValuesContainerDtoList =
        await filterLookupValuesContainerDtoList(list!);
    return lookupValuesContainerDtoList;
  }

  Future<int?> getJobTypeId(String? lookupvalue) async {
    var list = await getJobType();
    var index = list.where((element) => element.lookupValue == lookupvalue);
    if (index.isNotEmpty) {
      return index.first.lookupValueId;
    }
    return null;
  }

  Future<int?> getresolvedId() async {
    var list =
        await addstatusbylookupname("MAINTENANCE_OPEN_JOB_STATUS_TRANSITION");
    var index = list.where((element) => element.lookupValue == "RESOLVED");
    if (index.isNotEmpty) {
      return index.first.lookupValueId;
    }
    return null;
  }

  Future<int?> getserviceOpenStatusId() async {
    var list =
        await addstatusbylookupname("MAINTENANCE_OPEN_JOB_STATUS_TRANSITION");
    var index = list.where((element) => element.lookupValue == "OPEN");
    if (index.isNotEmpty) {
      return index.first.lookupValueId;
    }
    return null;
  }

  Future<int?> getserviceClosedStatusId() async {
    var list = await addstatusbylookupname(
        "MAINTENANCE_RESOLVED_JOB_STATUS_TRANSITION");
    var index = list.where((element) => element.lookupValue == "CLOSED");
    if (index.isNotEmpty) {
      return index.first.lookupValueId;
    }
    return null;
  }

  Future<int?> getTaskClosedStatusId() async {
    var list = await addstatusbylookupname("MAINT_JOB_STATUS");
    var index = list.where((element) => element.lookupValue == "Closed");
    if (index.isNotEmpty) {
      return index.first.lookupValueId;
    }
    return null;
  }

  Future<int?> getimageTypeId(String? lookupvalue) async {
    var list = await getImageType();
    var index = list.where((element) => element.lookupValue == lookupvalue);
    if (index.isNotEmpty) {
      return index.first.lookupValueId;
    }
    return null;
  }

  Future<List<LookupValuesContainerDtoList>> getImageType() async {
    _lookupsContainerDTOList =
        await LookupViewListBL(_executionContextDTO).getLookUp();
    Iterable<LookupsContainerDTO>? list = _lookupsContainerDTOList
        ?.where((e) => e.lookupName == "SERVICE_REQUEST_IMAGE_TYPE");
    List<LookupValuesContainerDtoList>? lookupValuesContainerDtoList = [];
    lookupValuesContainerDtoList =
        await filterLookupValuesContainerDtoList(list!);
    return lookupValuesContainerDtoList;
  }

  Future<List<LookupValuesContainerDtoList>> filterLookupValuesContainerDtoList(
      Iterable<LookupsContainerDTO> list) async {
    List<LookupValuesContainerDtoList>? lookupValuesContainerDtoList1 = [];
    for (var element in list) {
      lookupValuesContainerDtoList1
          .addAll(element.lookupValuesContainerDtoList!);
    }
    return lookupValuesContainerDtoList1;
  }

  Future<List<LookupValuesContainerDtoList>> getOpentab() async {
    _lookupsContainerDTOList =
        await LookupViewListBL(_executionContextDTO).getLookUp();
    var lookupList = await addstatusbylookupname(
        "MAINTENANCE_RESOLVED_JOB_STATUS_TRANSITION");
    var lookup = lookupList.where((element) => element.lookupValue == "REOPEN");
    Iterable<LookupsContainerDTO>? list = _lookupsContainerDTOList?.where(
        (e) => e.lookupName == "MAINTENANCE_OPEN_JOB_STATUS_TRANSITION");
    List<LookupValuesContainerDtoList>? lookupValuesContainerDtoList = [];
    lookupValuesContainerDtoList =
        await filterLookupValuesContainerDtoList(list!);
    lookupValuesContainerDtoList.addAll(lookup);
    return lookupValuesContainerDtoList;
  }

  Future<List<LookupValuesContainerDtoList>> getResolvedtab() async {
    _lookupsContainerDTOList =
        await LookupViewListBL(_executionContextDTO).getLookUp();
    var lookupList =
        await addstatusbylookupname("MAINTENANCE_OPEN_JOB_STATUS_TRANSITION");
    var lookup =
        lookupList.where((element) => element.lookupValue == "RESOLVED");
    Iterable<LookupsContainerDTO>? list = _lookupsContainerDTOList?.where(
        (e) => e.lookupName == "MAINTENANCE_RESOLVED_JOB_STATUS_TRANSITION");
    List<LookupValuesContainerDtoList>? lookupValuesContainerDtoList = [];
    lookupValuesContainerDtoList =
        await filterLookupValuesContainerDtoList(list!);
    lookupValuesContainerDtoList.addAll(lookup);
    return lookupValuesContainerDtoList;
  }

  Future<List<LookupValuesContainerDtoList>> getDrafttab() async {
    _lookupsContainerDTOList =
        await LookupViewListBL(_executionContextDTO).getLookUp();
    Iterable<LookupsContainerDTO>? list = _lookupsContainerDTOList?.where(
        (e) => e.lookupName == "MAINTENANCE_DRAFT_JOB_STATUS_TRANSITION");
    List<LookupValuesContainerDtoList>? lookupValuesContainerDtoList = [];
    lookupValuesContainerDtoList =
        await filterLookupValuesContainerDtoList(list!);
    return lookupValuesContainerDtoList;
  }

  Future<List<LookupValuesContainerDtoList>> getJobStatus() async {
    _lookupsContainerDTOList =
        await LookupViewListBL(_executionContextDTO).getLookUp();
    Iterable<LookupsContainerDTO>? list = _lookupsContainerDTOList
        ?.where((e) => e.lookupName == "MAINT_JOB_STATUS");
    List<LookupValuesContainerDtoList>? lookupValuesContainerDtoList = [];
    lookupValuesContainerDtoList =
        await filterLookupValuesContainerDtoList(list!);
    return lookupValuesContainerDtoList;
  }

  Future<List<LookupValuesContainerDtoList>> getJobPriorityDropdown() async {
    _lookupsContainerDTOList =
        await LookupViewListBL(_executionContextDTO).getLookUp();
    Iterable<LookupsContainerDTO>? list = _lookupsContainerDTOList
        ?.where((e) => e.lookupName == "MAINT_JOB_PRIORITY");
    List<LookupValuesContainerDtoList>? lookupValuesContainerDtoList = [];
    lookupValuesContainerDtoList =
        await filterLookupValuesContainerDtoList(list!);
    lookupValuesContainerDtoList.insertAll(0, await srall());
    return lookupValuesContainerDtoList;
  }

  Future<List<LookupValuesContainerDtoList>> getJobPriority() async {
    _lookupsContainerDTOList =
        await LookupViewListBL(_executionContextDTO).getLookUp();
    Iterable<LookupsContainerDTO>? list = _lookupsContainerDTOList
        ?.where((e) => e.lookupName == "MAINT_JOB_PRIORITY");
    List<LookupValuesContainerDtoList>? lookupValuesContainerDtoList = [];
    lookupValuesContainerDtoList =
        await filterLookupValuesContainerDtoList(list!);
    return lookupValuesContainerDtoList;
  }

  Future<List<LookupValuesContainerDtoList>> getRequestType() async {
    _lookupsContainerDTOList =
        await LookupViewListBL(_executionContextDTO).getLookUp();
    Iterable<LookupsContainerDTO>? list = _lookupsContainerDTOList
        ?.where((e) => e.lookupName == "MAINT_REQUEST_TYPE");
    List<LookupValuesContainerDtoList>? lookupValuesContainerDtoList = [];
    lookupValuesContainerDtoList =
        await filterLookupValuesContainerDtoList(list!);
    return lookupValuesContainerDtoList;
  }

  Future<List<LookupValuesContainerDtoList>> getDraftJobStatus() async {
    _lookupsContainerDTOList =
        await LookupViewListBL(_executionContextDTO).getLookUp();
    Iterable<LookupsContainerDTO>? list = _lookupsContainerDTOList?.where(
        (e) => e.lookupName == "MAINTENANCE_DRAFT_JOB_STATUS_TRANSITION");
    List<LookupValuesContainerDtoList>? lookupValuesContainerDtoList = [];
    lookupValuesContainerDtoList =
        await filterLookupValuesContainerDtoList(list!);
    return lookupValuesContainerDtoList;
  }

  Future<List<LookupValuesContainerDtoList>>
      getAssetTechinicalMappingRoles() async {
    _lookupsContainerDTOList =
        await LookupViewListBL(_executionContextDTO).getLookUp();
    Iterable<LookupsContainerDTO>? list = _lookupsContainerDTOList
        ?.where((e) => e.lookupName == "ASSET_TECHNICIAN_MAPPING_ROLES");
    List<LookupValuesContainerDtoList>? lookupValuesContainerDtoList = [];
    lookupValuesContainerDtoList =
        await filterLookupValuesContainerDtoList(list!);
    return lookupValuesContainerDtoList;
  }

  Future<int?> getJobStatusId(String? menuclick) async {
    var list = await getJobStatus();
    var index = list.where((element) => element.lookupValue == menuclick);
    if (index.isNotEmpty) {
      return index.first.lookupValueId;
    }
    return null;
  }

  // Future<String?> getJobStatusName(int? statusId) async {
  //   var list = await getJobStatus();
  //   var lookupValuesContainerDtoList =
  //       await filterLookupValuesContainerDtoList(list);

  //   var index = lookupValuesContainerDtoList
  //       .where((element) => element.lookupValueId == statusId);

  //   if (index.isNotEmpty) {
  //     return index.first.lookupValue;
  //   }
  //   return null;
  // }

  convertToAgo(String? datetime) {
    // var inputFormat = DateFormat('dd-MM-yyyy hh:mm');
    // var inputDate = inputFormat.parse(datetime);

    DateTime time1 = DateTime.parse(datetime!);
    // print(convertToAgo(time1));
    Duration diff = DateTime.now().difference(time1);

    if (diff.inDays >= 1) {
      return '${diff.inDays} days ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hours ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} mins ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} seconds ago';
    } else {
      return 'just now';
    }
  }

  changeDateAndTimeForCommentsCard(String datetime) {
    var tempDateAndTimeArray = datetime.split(" ");
    var time = tempDateAndTimeArray[1].split(":");
    String hour = time[0];
    String minutes = time[1];
    String timeInMinutesAndSeconds = "$hour:$minutes";
    String date = DateFormat("dd MMM yyyy - HH:mm a").format(
        DateTime.parse("${tempDateAndTimeArray[0]} $timeInMinutesAndSeconds"));
    // String time = DateFormat("hh:mm").parse(tempDateAndTimeArray[1]).toString();
    return "$date  "; // + tempDateAndTimeArray[1];
  }
}
