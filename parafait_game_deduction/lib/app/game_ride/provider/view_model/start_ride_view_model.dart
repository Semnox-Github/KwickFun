import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_ride/app/game_ride/provider/selected_game_machines.dart';
import 'package:game_ride/routes.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:semnox_core/modules/customer/accounts/model/account_summary_dto.dart';
import 'package:semnox_core/modules/customer/accounts/provider/account_data_provider.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/game/model/games_dto.dart';
import 'package:semnox_core/modules/game/model/model.dart';
import 'package:semnox_core/modules/game/provider/game_data_provider.dart';
import 'package:semnox_core/modules/hr/provider/userrole_data_provider.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/dataprovider/data_provider.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/widgets/input_fields/nfc_reader/nfc_reader.dart';
import '../../routes/module.dart';
import '../../view/pages/semnox_ride_entry_screen.dart';
import '../../view/widgets/account_balance_preview.dart';
import '../../view/widgets/post_gameplay_result.dart';
import 'package:semnox_core/modules/game/model/game_profile_dto.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class StartRideViewModel extends ChangeNotifier {
  static final provider =
      ChangeNotifierProvider.autoDispose<StartRideViewModel>((ref) {
    return StartRideViewModel(
        ref.watch(SelectedGameMachinesNotifier.provider).machines);
  });

  final List<GameMachine>? gameMachines;
  ExecutionContextDTO? executionContext;
  StartRideViewModel(this.gameMachines) {
    _init();
  }

  late BuildContext context;
  bool get canStartRide => gameMachines!.isNotEmpty;
  DataProvider<String?> dataProvider = DataProvider(initial: "");
  List<GameMachine>? get availableMachines => gameMachines;
  UserRoleDataProvider? userRoleDataProvider;
  GameDataProvider? _activeMachine;
  var managerApprovalCheck = UserRoleDataProvider.getuserroleDTO();
  GamesDTO? _gamesDTO;
  GameProfileDTO? _gameProfileDTO;
  String? get userId => executionContext?.userId;
  GameMachine? get gameMachine => _activeMachine?.gameMachine;
  SemnoxNFCReaderProperties cardReader =
      SemnoxNFCReaderProperties(canReadBarcode: true);

  late SemnoxTextFieldProperties textFieldProperties =
      SemnoxTextFieldProperties();
  late StreamSubscription<String> _subscription;

  num? _playCredits = 0.00;
  num? _vipPlayCredits = 0.00;
  num? get playCredits => _playCredits;
  num? get vipPlayCredits => _vipPlayCredits;

  _init() async {
    executionContext = await ExecutionContextProvider().getExecutionContext();
    if (canStartRide) {
      try {
        _activeMachine =
            GameDataProvider.machine(executionContext!, gameMachines?.first);
        _gamesDTO = await _activeMachine?.getGamesbyId();
        if (_gamesDTO?.vipPlayCredits == null ||
            _gamesDTO?.playCredits == null) {
          if (_gamesDTO?.gameProfileId != null) {
            _gameProfileDTO = await _activeMachine
                ?.getGamesProfilebyId(_gamesDTO?.gameProfileId);
          }
        }
        _vipPlayCredits =
            _gamesDTO?.vipPlayCredits ?? _gameProfileDTO?.vipPlayCredits;
        _playCredits = _gamesDTO?.playCredits ?? _gameProfileDTO?.playCredits;
      } on SocketException catch (e, s) {
        // ignore: use_build_context_synchronously
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.none) {
          SemnoxSnackbar.error(context, Messages.checkInternetConnection);
        } else {
          Utils().showCustomDialog(context, e.message, s.toString());
        }
      } on UnauthorizedException catch (e) {
        // ignore: use_build_context_synchronously
        SemnoxSnackbar.error(context, e.toString());
        await ExecutionContextProvider().clearExecutionContext();
        Modular.to.pushReplacementNamed(AppRoutes.loginPage);
      } on ServerNotReachableException catch (e, s) {
        // ignore: use_build_context_synchronously
        Utils()
            .showCustomDialog(context, e.message, s.toString(), e.statusCode);
      } catch (e) {
        // ignore: use_build_context_synchronously
        SemnoxSnackbar.error(context, e.toString());
      }
    }
    _subscription = cardReader.valueChangeStream.listen(_onCardRead);
    DateTime now = DateTime.now();
    print('gameScreen1 NFC start: $now');
    cardReader.startListening();
    notifyListeners();
  }

  _onCardRead(String cardNumber) {
    if (dataProvider.isLoading || cardNumber.isEmpty) return;
    if (_isScanningForBalance) {
      _fetchBalanceForCardNo(cardNumber);
    } else {
      enter();
    }
  }

  Future<void> changeMachine(GameMachine machine) async {
    try {
      _activeMachine = GameDataProvider.machine(executionContext!, machine);
      _gamesDTO = await _activeMachine?.getGamesbyId();
      if (_gamesDTO?.vipPlayCredits == null || _gamesDTO?.playCredits == null) {
        if (_gamesDTO?.gameProfileId != null) {
          _gameProfileDTO = await _activeMachine
              ?.getGamesProfilebyId(_gamesDTO?.gameProfileId);
        }
      }
      _vipPlayCredits =
          _gamesDTO?.vipPlayCredits ?? _gameProfileDTO?.vipPlayCredits;
      _playCredits = _gamesDTO?.playCredits ?? _gameProfileDTO?.playCredits;
      clear();
      notifyListeners();
    } on SocketException catch (e, s) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        // ignore: use_build_context_synchronously
        SemnoxSnackbar.error(context, Messages.checkInternetConnection);
      } else {
        // ignore: use_build_context_synchronously
        Utils().showCustomDialog(context, e.message, s.toString());
      }
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

  void clear() {
    _gamePlayResult = null;
    cardReader.setInitialValue("");
    notifyListeners();
  }

  GamePlayResult? _gamePlayResult;

  GamePlayResult? get gamePlayResult => _gamePlayResult;

  Future<void> enter() async {
    if (cardReader.value.isEmpty || _isScanningForBalance) return;
    var value = cardReader.value; //

    if (gamePlayResult?.cardNo == value) {
      bool? shouldPost = await SemnoxPopUp(
        title: SemnoxPopupTitle(title: Messages.playagain),
        content: SemnoxText(text: Messages.tappedsamecard),
        action: SemnoxPopUpTwoButtons(
          filledButtonText: Messages.playagain,
          outlineButtonText: Messages.dontplay,
          onFilledButtonPressed: () {
            Navigator.pop(context, true);
          },
          onOutlineButtonPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ).show(context);
      if (shouldPost != true) {
        cardReader.setInitialValue("");
        return;
      }
    }
    _gamePlayResult = null;
    notifyListeners();
    dataProvider.startLoading();
    try {
      await _activeMachine?.postGamePlay(value);
      _gamesDTO = await _activeMachine?.getGamesbyId();
      if (_gamesDTO?.vipPlayCredits == null || _gamesDTO?.playCredits == null) {
        if (_gamesDTO?.gameProfileId != null) {
          _gameProfileDTO = await _activeMachine
              ?.getGamesProfilebyId(_gamesDTO?.gameProfileId);
        }
      }
      _vipPlayCredits =
          _gamesDTO?.vipPlayCredits ?? _gameProfileDTO?.vipPlayCredits;
      _playCredits = _gamesDTO?.playCredits ?? _gameProfileDTO?.playCredits;
      final account = await AccountDataProvider.fromCardNo(
        executionContext!,
        value,
        buildActivityHistory: true,
        buildChildRecords: true,
        buildGamePlayHistory: true,
      );
      _gamePlayResult =
          GamePlayResult.success(account.getAccountSummaryDto(), value);
    } on SocketException catch (e, s) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        // ignore: use_build_context_synchronously
        SemnoxSnackbar.error(context, Messages.checkInternetConnection);
      } else {
        // ignore: use_build_context_synchronously
        Utils().showCustomDialog(context, e.message, s.toString());
      }
    } on UnauthorizedException catch (e) {
      // ignore: use_build_context_synchronously
      SemnoxSnackbar.error(context, e.toString());
      await ExecutionContextProvider().clearExecutionContext();
      Modular.to.pushReplacementNamed(AppRoutes.loginPage);
    } on ServerNotReachableException catch (error) {
      // ignore: use_build_context_synchronously
      Utils().showCustomDialog(
          context, error.message, error.stacktrace, error.statusCode);
    } on BadRequestException catch (e) {
      _gamePlayResult = GamePlayResult.failed("$e", value);
    } catch (e) {
      // ignore: use_build_context_synchronously
      SemnoxSnackbar.error(context, e.toString());
    }
    cardReader.setInitialValue("");
    // clear();
    dataProvider.updateData("");
    notifyListeners();
  }

  Future<void> navigateToBalance(String path,
      {String? cardNo, AccountSummaryViewDTO? accountDto}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // ignore: use_build_context_synchronously
      SemnoxSnackbar.error(context, Messages.checkInternetConnection);
    } else {
      await Modular.to.pushNamed(
          "./$path?${GameModule.cardNoKey}=${cardNo ?? cardReader.value}",
          arguments: accountDto);
      DateTime now = DateTime.now();
      print('gameScreen2 NFC start: $now');
      cardReader.startListening();
    }
  }

  bool _isScanningForBalance = false;
  final DataProvider<AccountDataProvider> balanceNotifier = DataProvider();

  void _fetchBalanceForCardNo(String cardNo) {
    balanceNotifier
        .handleFuture(AccountDataProvider.fromCardNo(
      executionContext!,
      cardNo,
      buildActivityHistory: true,
      buildChildRecords: true,
      buildGamePlayHistory: true,
    ))
        .then((value) {
      print("sucess");
      cardReader.setInitialValue("");
    });
  }

  Future<void> checkBalance(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // ignore: use_build_context_synchronously
      SemnoxSnackbar.error(context, Messages.checkInternetConnection);
    } else {
      _isScanningForBalance = true;
      final cardNo = _gamePlayResult?.cardNo ??
          await CardReaderDialog(
                  cardReader: cardReader,
                  autoCloseOnTap: true,
                  textread: textFieldProperties)
              .show(context);
      // cardReader.setInitialValue("");
      textFieldProperties.setInitialValue("");
      if (cardNo == null || cardNo.isEmpty) {
        _isScanningForBalance = false;
        DateTime now = DateTime.now();
        print('gameScreen3 NFC start: $now');
        cardReader.startListening();
        return;
      }
      // cardReader.stop();
      // showDialog(
      //     context: context,
      //     builder: (context) => Center(
      //           child: SemnoxCircleLoader(),
      //         ));

      try {
        _fetchBalanceForCardNo(cardNo);
        // final repo = await AccountsBL.fromCardNo(
        //   executionContext,
        //   cardNo,
        //   buildActivityHistory: false,
        //   buildChildrecords: true,
        //   buildGameplayHistory: false,
        // );
        // Navigator.pop(context);
        await showModalBottomSheet(
            context: context,
            isScrollControlled: false,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.mapToIdealWidth(context)),
              topRight: Radius.circular(30.mapToIdealWidth(context)),
            )),
            builder: (context) =>
                AccountBalancePreview(notifier: balanceNotifier));
        DateTime now = DateTime.now();
        print('gameScreen4 NFC start: $now');
        cardReader.startListening();
      } catch (e) {
        // Navigator.pop(context);
        // await SemnoxPopUp(
        //   title: SemnoxPopupTitle(title: "Failed."),
        //   content: SemnoxText.bodyReg2(text: "$e"),
        //   action: SemnoxpopupSingleButton(
        //     label: "Close",
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ).show(context);
        // cardReader.startListning();
      }
      _isScanningForBalance = false;
      DateTime now = DateTime.now();
      print('gameScreen5 NFC start: $now');
      cardReader.startListening();
    }
  }

  Future<void> checkusermanagerAccess(String route, Function callback) async {
    var userroleDTO = UserRoleDataProvider.getuserroleDTO();
    if (userroleDTO.isNotEmpty) {
      var abc = userroleDTO.first.manager;
      print('ManagerAccess:$abc');
      if (userroleDTO.first.manager == true) {
        print('userroleDTO.first.managerFlag2 == "Y"');
        Modular.to.pushNamed(route);
      } else {
        callback();
      }
    } else {
      // print('userroleDTO.isEmpty');
      callback();
    }
  }

  // Future<void> checkuserSettingAccess() async {
  //   var userroleDTO =
  //       UserRoleDataProvider.getuserroleDTO(executionContext?.roleId);
  //   if (userroleDTO != null) {
  //     if (userroleDTO.managerFlag == "Y") {
  //       // String datetime =
  //       //     '${DateTime.now().toUtc().toIso8601String().split('.')[0]}Z';
  //       // String hashcode = await generateHashCode(generatedTime: datetime);
  //       // print(hashcode);
  //       Modular.to.pushReplacementNamed("${AppRoutes.settings}/");
  //     } else {
  //       Utils().showSemnoxDialog(context, "User doesn't have manager Access");
  //     }
  //   } else {
  //     Utils().showSemnoxDialog(context, "userroleDTO is null or empty");
  //   }
  // }

  // Future<String> generateHashCode({
  //   String? generatedTime,
  //   String? appId = 'com.semnox.smartfunrevamp',
  //   String? securityCode = '704I5M76',
  // }) async {
  //   String mString = '$appId$securityCode$generatedTime';
  //   final encodedWord = utf8.encode(mString);
  //   // final hashDigest = await Sha1().hash(encodedWord);
  //   final hashDigest = sha1.convert(encodedWord);
  //   final hmachDigest = base64.encode(hashDigest.bytes);
  //   return hmachDigest;
  // }

  @override
  void dispose() {
    // DateTime now = DateTime.now();
    // print('dispose NFC in gameScreen: $now');
    _subscription.cancel();
    // cardReader.stop();
    super.dispose();
  }

  navigatetoLogin() async {
    await ExecutionContextProvider().updateSession(
        isSystemUserLogined: true, isSiteLogined: true, isUserLogined: false);
    Modular.to.navigate(AppRoutes.loginPage);
  }

  void shownoInternetConnection(BuildContext context) {
    SemnoxSnackbar.error(context, Messages.checkInternetConnection);
  }
}
