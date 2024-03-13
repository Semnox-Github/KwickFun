class CustomerLoginDTO {
  CustomerLoginDTO(
      {int? customerId,
      String? phoneOrEmail,
      String? password,
      int? otpId,
      String? otp}) {
    _customerId = customerId;
    _phoneOrEmail = phoneOrEmail;
    _password = password;
    _otpId = otpId;
    _otp = otp;
  }
  int? _customerId;
  String? _phoneOrEmail;
  String? _password;
  int? _otpId;
  String? _otp;

  int? get customerId => _customerId;
  String? get phoneOrEmail => _phoneOrEmail;
  String? get password => _password;
  int? get otpId => _otpId;
  String? get otp => _otp;

  factory CustomerLoginDTO.fromJson(Map<String, dynamic> json) =>
      CustomerLoginDTO(
          customerId: json["customerId"],
          phoneOrEmail: json["phoneOrEmail"],
          password: json["password"],
          otpId: json["otpId"],
          otp: json["otp"]);

  Map<String, dynamic> toJson() => {
        "CustomerId": customerId,
        "PhoneOrEmail": phoneOrEmail,
        "Password": password,
        "OtpId": otpId,
        "Otp": otp
      };
}
