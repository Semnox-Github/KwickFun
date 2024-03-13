import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:parafait_maintainence/app/parafait_home/view_model/sync_view_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:semnox_core/utils/utils.dart';

class SyncDetailViewmodel extends ChangeNotifier {
  static final provider = ChangeNotifierProvider.autoDispose
      .family<SyncDetailViewmodel, SyncViewmodel?>((ref, params) {
    return SyncDetailViewmodel(params);
  });

  int tabIndex = 0;
  List<String> menulist = ['From Server', 'To Server'];

  static double serversyncCount = 0.0;
  SyncViewmodel? params;

  final BehaviorSubject<SyncData?> _streamController =
      BehaviorSubject<SyncData?>();

  Stream<SyncData?> get stream => _streamController.stream;

  SyncDetailViewmodel(this.params) {
    init();
  }

  init() {
    if (tabIndex == 0) {
      _streamController.sink.add(params?.fromSyncevent);
    } else {
      _streamController.sink.add(params?.toSyncevent);
    }
  }

  void updatetabindex(int value) {
    tabIndex = value;
    init();
  }

  String lastsyncdateTime() {
    // String lastSyncDateTime = LocalStorage().get("lastsyncDatetime").toString();
    String date = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
    var tempDateAndTimeArray = date.split(" ");
    var time = tempDateAndTimeArray[1].split(":");
    String hour = time[0];
    String minutes = time[1];
    String timeInMinutesAndSeconds = "$hour:$minutes";
    String date1 = DateFormat("dd MMM yyyy - HH:mm a").format(
        DateTime.parse("${tempDateAndTimeArray[0]} $timeInMinutesAndSeconds"));
    return date1;
  }
}
