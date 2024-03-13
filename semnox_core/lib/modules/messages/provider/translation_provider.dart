import 'package:flutter_modular/flutter_modular.dart';
import 'package:semnox_core/modules/messages/bl/translation_view_bl.dart';
import 'package:semnox_core/modules/messages/model/translation_view_dto.dart';
import '../../execution_context/model/execution_context_dto.dart';

class TranslationProvider {
  static ExecutionContextDTO? _executionContextDTO;
  static final Map<String, String> _translationByKey = {};
  static final Map<int, String> _translationByMessageNo = {};

  TranslationProvider({ExecutionContextDTO? executionContextDTO}) {
    _executionContextDTO = executionContextDTO;
  }

  initialize() async {
    _translationByKey.clear();
    _translationByMessageNo.clear();

    var translationViewDTOList =
        await TranslationViewListBL(_executionContextDTO).getTranslation();
    if (translationViewDTOList != null) {
      _loadMap(translationViewDTOList);
    }
  }

  // void _refreshMaps() async {

  // }

  static getTranslationBykey(key) {
    print('key: $key');
    var temp = _translationByKey[key];
    var tempb = _translationByKey[key] == null ? key : _translationByKey[key];
    print('keytranslated: $temp');
    print('keyFinalTranslation: $tempb');
    return (_translationByKey[key]) == null ? key : _translationByKey[key];
  }

  Future<Map<String, String>> getTranslationByKey() async {
    return _translationByKey;
  }

  Future<String?> getMessageByMessageNo(msgNo) async {
    return (_translationByMessageNo[msgNo]) ?? msgNo;
  }

  void _loadMap(List<TranslationViewDTOList> translationViewDTOList) {
    for (var element in translationViewDTOList) {
      _translationByKey[element.message!] = element.translatedMessage!;
      _translationByMessageNo[element.messageNumber!] =
          element.translatedMessage!;
    }
  }
}
