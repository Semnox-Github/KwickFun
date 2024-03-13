import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/utils/dataprovider/micro_state_provider.dart';

class HomeScreenViewModel extends ChangeNotifier {
  static final provider =
      ChangeNotifierProvider.autoDispose<HomeScreenViewModel>((ref) {
    return HomeScreenViewModel(ref);
  });

  final Ref reference;

  HomeScreenViewModel(this.reference) {
    initializeDateFormatting();
    startLoading();
  }

  MicroStateProvider<String> message = MicroStateProvider<String>(initial: "");
  Future<void> startLoading() async {
    var executionContext =
        await ExecutionContextProvider().getExecutionContext();

    // if (executionContext?.inWebMode == false) {
    //   SyncprocessBL syncprocessBL = SyncprocessBL(executionContext!);
    //   await syncprocessBL.sync();
    // }

    updateMessage(executionContext!.loginId!);
  }

  void updateMessage(String newmessage) {
    message.updateData(newmessage);
  }
}

ValueNotifier<int> taskgroupsummaryloadstatus = ValueNotifier<int>(0);
