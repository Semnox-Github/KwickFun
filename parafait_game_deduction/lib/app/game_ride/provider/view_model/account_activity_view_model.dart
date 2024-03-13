import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_ride/routes.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:semnox_core/modules/customer/accounts/model/account_activity_dto.dart';
import 'package:semnox_core/modules/customer/accounts/provider/account_activity_provider.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/dataprovider/data_provider.dart';

class AccountActivityViewModel extends ChangeNotifier {
  static final provider = ChangeNotifierProvider.autoDispose
      .family<AccountActivityViewModel, int>((ref, accountId) {
    return AccountActivityViewModel(
      accountId: accountId,
    );
  });
  ExecutionContextDTO? executionContext;
  final int accountId;

  late BuildContext context;

  AccountActivityViewModel({
    required this.accountId,
  }) {
    initializeDateFormatting();
    fetchAccountActivity();
  }

  DataProvider<AccountActivityDataProvider> accountactivityProvider =
      DataProvider<AccountActivityDataProvider>();

  void fetchAccountActivity() async {
    try {
      executionContext = await ExecutionContextProvider().getExecutionContext();
      accountactivityProvider.handleFuture(
          AccountActivityDataProvider(executionContextDTO: executionContext)
              .getAccountActivityDTOList(accountId: accountId));
    } on UnauthorizedException catch (e) {
      // ignore: use_build_context_synchronously
      SemnoxSnackbar.error(context, e.toString());
      await ExecutionContextProvider().clearExecutionContext();
      Modular.to.navigate(AppRoutes.loginPage);
    } on ServerNotReachableException catch (e, s) {
      // ignore: use_build_context_synchronously
      Utils().showCustomDialog(context, e.message, s.toString(), e.statusCode);
    } catch (e) {
      // ignore: use_build_context_synchronously
      SemnoxSnackbar.error(context, e.toString());
    }
  }

  List<AccountActivityDto> get activityHistory {
    return (accountactivityProvider.data?.getAccountActivityListDTO() ?? [])
        .toList(growable: false);
  }
}
