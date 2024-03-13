import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_ride/routes.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/transaction/model/game_play_dto.dart';
import 'package:semnox_core/modules/transaction/provider/game_play_data_provider.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/dataprovider/data_provider.dart';

class GamePlayViewModel extends ChangeNotifier {
  static final provider = ChangeNotifierProvider.autoDispose
      .family<GamePlayViewModel, int>((ref, id) {
    return GamePlayViewModel(
      accountid: id,
    );
  });
  ExecutionContextDTO? executionContext;
  final int accountid;

  late BuildContext context;

  GamePlayViewModel({
    required this.accountid,
  }) {
    initializeDateFormatting();
    fetchGamePlay();
  }

  DataProvider<GamePlayDataProvider> gameplayprovider =
      DataProvider<GamePlayDataProvider>();

  void fetchGamePlay() async {
    try {
      executionContext = await ExecutionContextProvider().getExecutionContext();
      gameplayprovider.handleFuture(
          GamePlayDataProvider(executionContext: executionContext)
              .getGamePlay(accountid));
    } on UnauthorizedException catch (e) {
      // ignore: use_build_context_synchronously
      SemnoxSnackbar.error(context, e.toString());
      await ExecutionContextProvider().clearExecutionContext();
      Modular.to.pushReplacementNamed(AppRoutes.loginPage);
    } on ServerNotReachableException catch (e, s) {
      // ignore: use_build_context_synchronously
      Utils().showCustomDialog(context, e.message, s.toString(), e.statusCode);
    } catch (e) {
      // ignore: use_build_context_synchronously
      SemnoxSnackbar.error(context, e.toString());
    }
  }

  List<GamePlayDto> get gameplayHistory {
    return (gameplayprovider.data?.getgamePlayListDTO() ?? [])
        .toList(growable: false);
  }
}
