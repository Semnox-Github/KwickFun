class CustomerLoginRequestDTO {
  CustomerLoginRequestDTO({String? username, String? password}) {
    _username = username;
    _password = password;
  }
  String? _username;
  String? _password;

  String? get username => _username;
  String? get password => _password;

  Map<String, dynamic> toJson() => {"UserName": username, "Password": password};
}
