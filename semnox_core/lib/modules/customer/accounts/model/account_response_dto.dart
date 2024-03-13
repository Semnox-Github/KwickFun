import 'dart:convert';
import 'account_dto.dart';

class CustomerAccountResponseDto {
  CustomerAccountResponseDto({
    List<AccountDto>? data,
    int? currentPageNo,
    int? totalCount,
    String? barCode,
    String? token,
  }) {
    _data = data;
    _currentPageNo = currentPageNo;
    _totalCount = totalCount;
    _barCode = barCode;
    _token = token;
  }

  List<AccountDto>? _data;
  int? _currentPageNo;
  int? _totalCount;
  String? _barCode;
  String? _token;

  List<AccountDto>? get data => _data;
  int? get currentPageNo => _currentPageNo;
  int? get totalCount => _totalCount;
  String? get barCode => _barCode;
  String? get token => _token;

  factory CustomerAccountResponseDto.fromJson(String str) =>
      CustomerAccountResponseDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerAccountResponseDto.fromMap(Map<String, dynamic> json) =>
      CustomerAccountResponseDto(
        data: json["data"] == null
            ? null
            : List<AccountDto>.from(
                json["data"].map((x) => AccountDto.fromMap(x))),
        currentPageNo: json["currentPageNo"],
        totalCount: json["totalCount"],
        barCode: json["barCode"],
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "data": data == null
            ? null
            : List<AccountDto>.from(data!.map((x) => x.toMap())),
        "currentPageNo": currentPageNo,
        "totalCount": totalCount,
        "barCode": barCode,
        "token": token,
      };
}

enum AccountFilterParams {
  isActive,
  buildChildRecords,
  buildActivityHistory,
  buildGamePlayHistory,
  accountNumber,
  customerId,
}