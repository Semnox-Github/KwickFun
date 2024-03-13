class UserOffline {
  String? loginId;
  String? passwordhash;

  DateTime? lastlogintime;

  UserOffline();

  // UserOffline({
  //   this.loginId,
  //   this.passwordhash,
  //   this.key,
  // });

  UserOffline.fromJson(Map<String, dynamic> json)
      : loginId = json['loginId'],
        passwordhash = json['passwordhash'],
        lastlogintime = json["lastlogintime"] == null
            ? null
            : DateTime.parse(json["lastlogintime"]);

  Map<String, dynamic> toJson() => {
        'loginId': loginId,
        'passwordhash': passwordhash,
        'lastlogintime': lastlogintime!.toIso8601String(),
      };
}
