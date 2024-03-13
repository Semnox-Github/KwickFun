class TranslationViewDTOList {
  TranslationViewDTOList(
      {int? messageId,
      int? messageNumber,
      String? message,
      String? translatedMessage}) {
    _messageId = messageId;
    _messageNumber = messageNumber;
    _message = message;
    _translatedMessage = translatedMessage;
  }

  int? _messageId;
  int? _messageNumber;
  String? _message;
  String? _translatedMessage;

  int? get messageId => _messageId;
  int? get messageNumber => _messageNumber;
  String? get message => _message;
  String? get translatedMessage => _translatedMessage;

  factory TranslationViewDTOList.fromJson(Map<String, dynamic> json) =>
      TranslationViewDTOList(
        messageId: json["MessageId"] == null ? null : json["MessageId"],
        messageNumber:
            json["MessageNumber"] == null ? null : json["MessageNumber"],
        message: json["Message"] == null ? null : json["Message"],
        translatedMessage: json["TranslatedMessage"] == null
            ? null
            : json["TranslatedMessage"],
      );

  Map<String, dynamic> toJson() => {
        "MessageId": messageId == null ? null : messageId,
        "MessageNumber": messageNumber == null ? null : messageNumber,
        "Message": message == null ? null : message,
        "TranslatedMessage":
            translatedMessage == null ? null : translatedMessage,
      };

  static List<TranslationViewDTOList>? getTranslationViewDTOList(
      List? dtoList) {
    if (dtoList == null) {
      return null;
    }
    List<TranslationViewDTOList> translationViewDTOList = [];
    translationViewDTOList = List<TranslationViewDTOList>.from(
        dtoList.map((x) => TranslationViewDTOList.fromJson(x)));
    return translationViewDTOList;
  }
}

enum TranslationViewDTOSearchParameter {
  SITEID,
  LANGUAGEID,
  HASH,
  REBUILDCACHE
}
