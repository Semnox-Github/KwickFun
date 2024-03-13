import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/maintainence_service_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/repositories/dbhandler/purge_dbhandler.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';

class PurgeViewmodel extends ChangeNotifier {
  static final provider =
      ChangeNotifierProvider.autoDispose<PurgeViewmodel>((ref) {
    return PurgeViewmodel();
  });

  PurgeViewmodel();

  ExecutionContextDTO? _executionContextDTO;
  late BuildContext? context;

  void purgeJobDetails() async {
    _executionContextDTO =
        await ExecutionContextProvider().getExecutionContext();

    Map<CheckListDetailSearchParameter, dynamic> checkListDetailssearchParams =
        {
      CheckListDetailSearchParameter.SITEID: _executionContextDTO?.siteId,
      CheckListDetailSearchParameter.SERVERSYNC: 1,
    };

    int result = await PurgeDbHandler(_executionContextDTO!)
        .purgeJobDetails(checkListDetailssearchParams);
    if (result != -1) {
      SemnoxSnackbar.success("Purge job Successful", context!,
          title: Messages.purgeJobSuccess);
    } else {
      SemnoxSnackbar.error(context!, Messages.canNotPurge);
    }
  }
  // void purgeAssets() async {
  //   _executionContextDTO =
  //       await ExecutionContextProvider().getExecutionContext();
  //   PurgeDbHandler(_executionContextDTO!).purgeAssets();
  // }

  // void purgeall() async {
  //   _executionContextDTO =
  //       await ExecutionContextProvider().getExecutionContext();
  //   PurgeDbHandler(_executionContextDTO!).purgeAll();
  // }
}
