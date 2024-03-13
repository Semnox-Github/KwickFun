import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:semnox_core/modules/messages/provider/translation_provider.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/widgets/semnox_widget/network_configuration_widget.dart/view_model/network_configuration_form_view_model.dart';
import 'package:share_extend/share_extend.dart';

class Utils {
  void showCustomDialog(BuildContext context, String error, String stacktrace,
      [int? statusCode]) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SemnoxText(
                            text: "Error StatusCode : $statusCode",
                          ),
                          SemnoxText(
                            text: "Exception : $error",
                          ),
                          SemnoxText(
                            text: "StackTrace : $stacktrace",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SemnoxFlatButton(
                    child: SemnoxText.button(
                      text: TranslationProvider.getTranslationBykey(
                              Messages.share)
                          .toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      var path = await _write(
                          "Error StatusCode : ${statusCode.toString()} /n Exception : ${error.toString()} /n StackTrace : ${stacktrace.toString()}");
                      _shareFile(path);
                      // await _write(error.toString());
                      // // ignore: use_build_context_synchronously
                      // Navigator.of(context).pop();
                      // // ignore: use_build_context_synchronously
                      // SemnoxSnackbar.success("Download Success", context,
                      //     title: "Status");
                    },
                  ),
                ]),
          ),
        );
      },
    );
  }

  Future<bool?> operationMatrix(int? menuclick) async {
    final List<OperationMatrix> operationMatrix = [];
    if (operationMatrix.isNotEmpty) {
      var operationmatrixlist = operationMatrix
          .where((element) => element.status == menuclick)
          .toList();
      var contain =
          operationmatrixlist.where((element) => element.status == "N");
      if (contain.isEmpty) {
        return false;
      }
    } else {
      return true;
    }
  }

  void showCustomserverDialog(
    BuildContext context,
    List<ServerReachablewithException?>? serverReachablewithException,
  ) async {
    bool? status = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: serverReachablewithException?.length,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              status =
                                  serverReachablewithException![index]!.status;
                            } else if (index == 1) {
                              status = serverReachablewithException?[0]
                                          ?.status ==
                                      true
                                  ? serverReachablewithException![index]!.status
                                  : false;
                            } else if (index == 2) {
                              status = serverReachablewithException?[0]
                                              ?.status ==
                                          true &&
                                      serverReachablewithException?[1]
                                              ?.status ==
                                          true
                                  ? serverReachablewithException![index]!.status
                                  : false;
                            }
                            return ExpansionTile(
                              title: AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SemnoxText.subtitle(
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            text: serverReachablewithException![
                                                    index]!
                                                .entitytype!),
                                      ),
                                      status == true
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            )
                                          : const Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                    ],
                                  )),
                              children: [
                                status == false
                                    ? Container(
                                        width: 400,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SemnoxText(
                                                text:
                                                    "Error StatusCode : ${serverReachablewithException[index]!.statusCode}",
                                              ),
                                              SemnoxText(
                                                text:
                                                    "Exception : ${serverReachablewithException[index]!.exception}",
                                              ),
                                              SemnoxText(
                                                text:
                                                    "StackTrace : ${serverReachablewithException[index]!.stackTrace}",
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: SemnoxFlatButton(
                                                  child: SemnoxText.button(
                                                    text: TranslationProvider
                                                            .getTranslationBykey(
                                                                Messages.share)
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () async {
                                                    var path = await _write(
                                                        "Error StatusCode : ${serverReachablewithException[index]!.statusCode.toString()} /n Exception : ${serverReachablewithException[index]!.exception} /n StackTrace : ${serverReachablewithException[index]!.stackTrace}");
                                                    _shareFile(path);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            );
                          }),
                    ),
                  ),
                ]),
          ),
        );
      },
    );
  }

  _write(String text) async {
    //  final Directory? directory = await getExternalStorageDirectory();
    Directory? directory;
    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = await getExternalStorageDirectory();
    }
    final File file = File(
        '${directory?.path}/game_deduction_${DateTime.now().toString()}.txt');
    await file.writeAsString(text);
    return '${directory?.path}/game_deduction_${DateTime.now().toString()}.txt';
  }

  _shareFile(path) async {
    //share file
    File testFile = File(path);
    if (!await testFile.exists()) {
      await testFile.create(recursive: true);
      testFile.writeAsStringSync("test for share documents file");
    }
    ShareExtend.share(testFile.path, "file");
  }

  Future<bool?> showSemnoxDialog(BuildContext context, String message) async {
    return await showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop(true);
        });
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 100,
            margin: const EdgeInsets.only(bottom: 30, left: 12, right: 12),
            decoration: BoxDecoration(
              color: SemnoxConstantColor.alertbottom(context),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SemnoxText.bodyMed1(
                      text: message.toString(),
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                // SemnoxFlatButton(
                //   child: SemnoxText.button(
                //     text: TranslationProvider.getTranslationBykey(Messages.ok)
                //         .toUpperCase(),
                //     style: const TextStyle(color: Colors.white),
                //   ),
                //   onPressed: () async {
                //     Navigator.of(context).pop(true);
                //   },
                // ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
  }

  Future<void> showSemnoxSupportDialog(
      BuildContext context, String supportTeamNo) async {
    await SemnoxPopUp(
      title: const SemnoxPopupTitle(
        title: "Support",
        enableClose: true,
      ),
      content: Container(
        decoration: BoxDecoration(
            color: SemnoxConstantColor.cardForeground(context),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            )),
        // height: 300.mapToIdealHeight(context),
        child: Container(
          color: SemnoxConstantColor.disabledButtonColor(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/support.png"),
                  const SizedBox(height: 20),
                  SemnoxText(
                    text: Messages.contactsupport,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SemnoxText(
                    text: supportTeamNo, //"1800 - 300 - 400 - 200",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    ).show(context);
  }

  Future<void> showExitDialog(BuildContext context) async {
    await SemnoxPopUp(
      title: const SemnoxPopupTitle(
        title: Messages.exitApp,
        enableClose: false,
      ),
      action: SemnoxPopUpTwoButtons(
        outlineButtonText:
            TranslationProvider.getTranslationBykey(Messages.cancelButton)
                .toUpperCase(),
        filledButtonText:
            TranslationProvider.getTranslationBykey(Messages.ok).toUpperCase(),
        onFilledButtonPressed: () {
          Future.delayed(const Duration(milliseconds: 1000), () {
            // SystemNavigator.pop();
            Modular.to.pop(context);
            MoveToBackground.moveTaskToBack();
          });
        },
        onOutlineButtonPressed: () {
          Navigator.pop(context);
        },
      ),
    ).show(context);
  }

  Future<void> showNotManageralert(BuildContext context) async {
    await SemnoxPopUp(
      title: const SemnoxPopupTitle(
        title: Messages.alert,
        enableClose: false,
      ),
      content: Container(
        decoration: BoxDecoration(
            color: SemnoxConstantColor.cardForeground(context),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            )),
        padding: const EdgeInsets.all(15), // Add padding here
        child: Row(
          // Now Expanded is directly inside a Flex widget (Column)
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SemnoxText(
                    text: Messages.notMangerAlert,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
      action: SemnoxpopupSingleButton(
        label:
            TranslationProvider.getTranslationBykey(Messages.ok).toUpperCase(),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ).show(context);
  }

  Future<bool?> showserveraddressChanged(
      BuildContext context, String message) async {
    await SemnoxPopUp(
      title: SemnoxPopupTitle(
        title: message,
        enableClose: false,
      ),
      action: SemnoxPopUpTwoButtons(
        outlineButtonText:
            TranslationProvider.getTranslationBykey(Messages.cancelButton)
                .toUpperCase(),
        filledButtonText:
            TranslationProvider.getTranslationBykey(Messages.ok).toUpperCase(),
        onFilledButtonPressed: () async {
          Navigator.pop(context, true);
        },
        onOutlineButtonPressed: () {
          Navigator.pop(context, false);
        },
      ),
    ).show(context);
    return false;
  }

  Future<bool?> showWarning(
          BuildContext context, String message, String title) async =>
      showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: SemnoxText.subtitle(text: title),
          content: SemnoxText.subtitle(text: message),
          actions: [
            SemnoxPopUpTwoButtons(
              outlineButtonText:
                  TranslationProvider.getTranslationBykey(Messages.cancelButton)
                      .toUpperCase(),
              filledButtonText:
                  TranslationProvider.getTranslationBykey(Messages.ok)
                      .toUpperCase(),
              onFilledButtonPressed: () async {
                Navigator.pop(context, true);
              },
              onOutlineButtonPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        ),
      );
}

class UploadandDownload {
  final BehaviorSubject<SyncData> _fromserverstreamController =
      BehaviorSubject<SyncData>();
  Stream<SyncData> get fromserverstream =>
      _fromserverstreamController.stream.asBroadcastStream();

  final BehaviorSubject<SyncData> _toserverstreamController =
      BehaviorSubject<SyncData>();
  Stream<SyncData> get toserverstream =>
      _toserverstreamController.stream.asBroadcastStream();

  Future<void> fromServer(SyncData? syncevent) async {
    if (!_fromserverstreamController.isClosed) {
      _fromserverstreamController.sink.add(syncevent!);
    }
  }

  Future<void> toServer(SyncData? syncevent) async {
    if (!_toserverstreamController.isClosed) {
      _toserverstreamController.sink.add(syncevent!);
    }
  }

  void dispose() async {
    await _fromserverstreamController.close();
    await _toserverstreamController.close();
  }
}

class SyncData {
  double? _percent;
  List<SyncDetails>? _syncdetails;

  SyncData({double? percent, List<SyncDetails>? syncdetails}) {
    _percent = percent;
    _syncdetails = syncdetails;
  }

  double? get percent => _percent;
  List<SyncDetails>? get syncdetails => _syncdetails;

  factory SyncData.fromMap(Map<String, dynamic> json) => SyncData(
        percent: json["Percent"],
        syncdetails: List<SyncDetails>.from(
            json["Syncdetails"].map((x) => SyncDetails.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Percent": percent,
        "Syncdetails": List<dynamic>.from(_syncdetails!.map((x) => x.toMap())),
      };

  set percent(double? percent) {
    _percent = _percent! + percent!;
  }

  set addsyncdetails(List<SyncDetails>? syncdetails) {
    _syncdetails?.addAll(syncdetails!);
  }
}

class SyncDetails {
  String? _type;
  int? _insertedcount;
  int? _totalcount;
  String? _syncstatus;

  SyncDetails(
      {String? type, int? insertedcount, int? totalcount, String? syncstatus}) {
    _type = type;
    _insertedcount = insertedcount;
    _totalcount = totalcount;
    _syncstatus = syncstatus;
  }

  String? get type => _type;
  int? get insertcount => _insertedcount;
  int? get totalcount => _totalcount;
  String? get syncstatus => _syncstatus;

  factory SyncDetails.fromMap(Map<String, dynamic> json) => SyncDetails(
        type: json["Type"],
        insertedcount: json["Insertedcount"],
        totalcount: json["Totalcount"],
        syncstatus: json["Syncstatus"],
      );

  Map<String, dynamic> toMap() => {
        "Type": type,
        "Insertedcount": insertcount,
        "Totalcount": totalcount,
        "Syncstatus": syncstatus,
      };
}

class OperationMatrix {
  int? _statusId;
  String? _status;
  String? _permission;
  String? _operation;

  OperationMatrix(
      {int? statusId, String? status, String? permission, String? operation}) {
    _statusId = statusId;
    _status = status;
    _permission = permission;
    _operation = operation;
  }

  int? get statusId => _statusId;
  String? get status => _status;
  String? get permission => _permission;
  String? get operation => _operation;

  factory OperationMatrix.fromMap(Map<String, dynamic> json) => OperationMatrix(
        statusId: json["StatusId"],
        status: json["Status"],
        permission: json["Permission"],
        operation: json["Operation"],
      );

  Map<String, dynamic> toMap() => {
        "StatusId": statusId,
        "Status": statusId,
        "Permission": permission,
        "Operation": operation
      };
}
