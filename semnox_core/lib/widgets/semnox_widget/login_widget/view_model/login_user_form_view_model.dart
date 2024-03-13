import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/streams.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/languages/bl/language_view_bl.dart';
import 'package:semnox_core/modules/languages/model/language_container_dto.dart';
import 'package:semnox_core/modules/sites/bl/site_view_bl.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/dataprovider/data_provider.dart';
import 'package:semnox_core/utils/dataprovider/data_state.dart';
import 'package:semnox_core/widgets/input_fields/nfc_reader/nfc_reader.dart';

class UserData {
  String? loginId;
  String? password;
  String? cardNumber;
  SiteViewDTO? site;
  LanguageContainerDto? languageDto;
  DataProvider<bool> buttonState;
  UserData(this.loginId, this.password, this.cardNumber, this.site,
      this.languageDto, this.buttonState);
}

class LoginUserViewModel extends ChangeNotifier {
  static const initialLang = 'en-US';
  static final provider =
      ChangeNotifierProvider.autoDispose<LoginUserViewModel>((ref) {
    return LoginUserViewModel();
  });
  LoginUserViewModel() {
    userNameField.setInitialValue(""); //semnox
    passwordField.setInitialValue(""); //semnoX!1
    _init();
  }
  final formKey = GlobalKey<FormState>();
  ExecutionContextDTO? executionContext;
  List<SiteViewDTO>? sitelist;
  List<LanguageContainerDto>? languageDto;
  final DataProvider<bool> buttonState = DataProvider<bool>(initial: false);
  ValueStream<DataState<bool>> get buttonStates => buttonState.dataStream;

  SemnoxTextFieldProperties userNameField =
      SemnoxTextFieldProperties(label: "UserName", validators: [
    (value) {
      if (value?.isEmpty ?? true) return "UserName is required";
      return null;
    }
  ]);
  SemnoxTextFieldProperties cardNoField =
      SemnoxTextFieldProperties(label: "Card Number");

  SemnoxTextFieldProperties passwordField = SemnoxTextFieldProperties(
      label: "Password",
      isObscured: true,
      validators: [
        (value) {
          if (value?.isEmpty ?? true) return "Password is required";
          return null;
        }
      ]);
  SemnoxDropdownProperties<SiteViewDTO> siteField =
      SemnoxDropdownProperties<SiteViewDTO>(items: []);
  SemnoxDropdownProperties<LanguageContainerDto> languageField =
      SemnoxDropdownProperties<LanguageContainerDto>(items: []);

  DataProvider<String?> dataProvider = DataProvider(initial: "");
  BuildContext? context;
  final DataProvider<bool> stateupdate = DataProvider<bool>(initial: false);
  ValueStream<DataState<bool>> get loadstates => stateupdate.dataStream;
  SemnoxNFCReaderProperties cardReader =
      SemnoxNFCReaderProperties(canReadBarcode: true);
  late StreamSubscription<String> _subscription;
  void _init() async {
    stateupdate.startLoading();
    executionContext = await ExecutionContextProvider().getExecutionContext();
    sitelist = await SitesViewListBL(executionContext).getSites();
    languageDto = await LanguageViewListBL(executionContext).getLanguages();
    siteField = SemnoxDropdownProperties<SiteViewDTO>(
        label: "Site",
        items: sitelist!
            .map((e) => DropdownMenuItem<SiteViewDTO>(
                value: e, child: SemnoxText(text: "${e.siteName}")))
            .toList(),
        enabled: true,
        validators: [
          (data) {
            if (data == null) {
              return "Select Any Site";
            }
            return null;
          }
        ]);
    if (sitelist!.isNotEmpty) {
      final initial = sitelist!.firstWhereOrNull(
          (element) => executionContext?.siteId == element.siteId);
      siteField.setInitialValue(initial ?? sitelist!.first);
    }
    var languageList = languageDto;
    languageField = SemnoxDropdownProperties<LanguageContainerDto>(
        label: "Language",
        items: languageList!
            .map((e) => DropdownMenuItem<LanguageContainerDto>(
                value: e, child: SemnoxText(text: "${e.languageName}")))
            .toList(),
        validators: [
          (data) {
            if (data == null) {
              return "Select Any Language";
            }
            return null;
          }
        ]);
    if (languageList.isNotEmpty) {
      final initial = languageList
          //firstWhereOrNull(element) => executionContext?.languageId == element.languageId);  //previous code
          .firstWhereOrNull((element) => initialLang == element.languageCode);
      languageField.setInitialValue(initial ?? languageList.first);
    }
    _subscription = cardReader.valueChangeStream.listen(_onCardRead);
    // print('About to start listening...');
    // try {
    DateTime now = DateTime.now();

    print('inside Login DateTime1: $now');
    cardReader.startListening();
    // } catch (e) {
    //   print('Failed to start listening: $e');
    // }
    // print('Finished starting to listen...');
    stateupdate.updateData(true);
    notifyListeners();
  }

  _onCardRead(String cardNumber) {
    cardNoField.setInitialValue(cardNumber);
  }

  @override
  void dispose() {
    _subscription.cancel();
    cardReader.stop();
    print('Stopping...');
    DateTime now = DateTime.now();
    print('inside login DateTime dsipose: $now');
    super.dispose();
  }
}
