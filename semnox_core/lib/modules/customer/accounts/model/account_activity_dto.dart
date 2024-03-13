// To parse this JSON data, do
//
//     final accountActivityDto = accountActivityDtoFromMap(jsonString);

import 'dart:convert';

class AccountActivityDto {
  AccountActivityDto({
    this.accountId,
    this.date,
    this.product,
    this.amount,
    this.credits,
    this.courtesy,
    this.bonus,
    this.time,
    this.tokens,
    this.tickets,
    this.loyaltyPoints,
    this.virtualPoints,
    this.site,
    this.pos,
    this.userName,
    this.quantity,
    this.price,
    this.refId,
    this.rowNumber,
    this.activityType,
    this.status,
    this.playCredits,
    this.counterItems,
  });

  final num? accountId;
  final String? date;
  final String? product;
  final num? amount;
  final num? credits;
  final num? courtesy;
  final num? bonus;
  final num? time;
  final dynamic tokens;
  final num? tickets;
  final num? loyaltyPoints;
  final num? virtualPoints;
  final String? site;
  final String? pos;
  final String? userName;
  final num? quantity;
  final num? price;
  final num? refId;
  final num? rowNumber;
  final String? activityType;
  final String? status;
  final dynamic playCredits;
  final dynamic counterItems;

  factory AccountActivityDto.fromJson(String str) =>
      AccountActivityDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AccountActivityDto.fromMap(Map<String, dynamic> json) =>
      AccountActivityDto(
        accountId: json["AccountId"] == null ? null : json["AccountId"],
        date: json["Date"] == null ? null : json["Date"],
        product: json["Product"] == null ? null : json["Product"],
        amount: json["Amount"] == null ? null : json["Amount"],
        credits: json["Credits"] == null ? null : json["Credits"],
        courtesy: json["Courtesy"] == null ? null : json["Courtesy"],
        bonus: json["Bonus"] == null ? null : json["Bonus"],
        time: json["Time"] == null ? null : json["Time"],
        tokens: json["Tokens"],
        tickets: json["Tickets"] == null ? null : json["Tickets"],
        loyaltyPoints:
            json["LoyaltyPoints"] == null ? null : json["LoyaltyPoints"],
        virtualPoints:
            json["VirtualPoints"] == null ? null : json["VirtualPoints"],
        site: json["Site"] == null ? null : json["Site"],
        pos: json["POS"] == null ? null : json["POS"],
        userName: json["UserName"] == null ? null : json["UserName"],
        quantity: json["Quantity"] == null ? null : json["Quantity"],
        price: json["Price"] == null ? null : json["Price"],
        refId: json["RefId"] == null ? null : json["RefId"],
        rowNumber: json["RowNumber"] == null ? null : json["RowNumber"],
        activityType:
            json["ActivityType"] == null ? null : json["ActivityType"],
        status: json["Status"] == null ? null : json["Status"],
        playCredits: json["PlayCredits"],
        counterItems: json["CounterItems"],
      );

  Map<String, dynamic> toMap() => {
        "AccountId": accountId == null ? null : accountId,
        "Date": date == null ? null : date,
        "Product": product == null ? null : product,
        "Amount": amount == null ? null : amount,
        "Credits": credits == null ? null : credits,
        "Courtesy": courtesy == null ? null : courtesy,
        "Bonus": bonus == null ? null : bonus,
        "Time": time == null ? null : time,
        "Tokens": tokens,
        "Tickets": tickets == null ? null : tickets,
        "LoyaltyPoints": loyaltyPoints == null ? null : loyaltyPoints,
        "VirtualPoints": virtualPoints == null ? null : virtualPoints,
        "Site": site == null ? null : site,
        "POS": pos == null ? null : pos,
        "UserName": userName == null ? null : userName,
        "Quantity": quantity == null ? null : quantity,
        "Price": price == null ? null : price,
        "RefId": refId == null ? null : refId,
        "RowNumber": rowNumber == null ? null : rowNumber,
        "ActivityType": activityType == null ? null : activityType,
        "Status": status == null ? null : status,
        "PlayCredits": playCredits,
        "CounterItems": counterItems,
      };
}
