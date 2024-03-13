class GenericOtpRequestDTO {
  GenericOtpRequestDTO({String? emailId, String? phone, String? source}) {
    _emailId = emailId;
    _phone = phone;
    _source = source;
  }
  String? _emailId;
  String? _phone;
  String? _source;

  String? get emailId => _emailId;
  String? get phone => _phone;
  String? get source => _source;

  Map<String, dynamic> toJson() =>
      {"EmailId": emailId, "Phone": phone, "Source": source};
}
