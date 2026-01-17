// To parse this JSON data, do
//
//     final fetchCoinHistoryModel = fetchCoinHistoryModelFromJson(jsonString);

import 'dart:convert';

FetchCoinHistoryModel fetchCoinHistoryModelFromJson(String str) => FetchCoinHistoryModel.fromJson(json.decode(str));

String fetchCoinHistoryModelToJson(FetchCoinHistoryModel data) => json.encode(data.toJson());

class FetchCoinHistoryModel {
  bool? status;
  String? message;
  int? userCoin;
  List<Data>? data;

  FetchCoinHistoryModel({
    this.status,
    this.message,
    this.userCoin,
    this.data,
  });

  factory FetchCoinHistoryModel.fromJson(Map<String, dynamic> json) => FetchCoinHistoryModel(
        status: json["status"],
        message: json["message"],
        userCoin: json["userCoin"],
        data: json["data"] == null ? [] : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "userCoin": userCoin,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Data {
  String? id;
  String? uniqueId;
  int? type;
  int? userCoin;
  int? payoutStatus;
  DateTime? createdAt;
  String? typeDescription;
  String? receiverName;
  bool? isIncome;

  Data({
    this.id,
    this.uniqueId,
    this.type,
    this.userCoin,
    this.payoutStatus,
    this.createdAt,
    this.typeDescription,
    this.receiverName,
    this.isIncome,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        uniqueId: json["uniqueId"],
        type: json["type"],
        userCoin: json["userCoin"],
        payoutStatus: json["payoutStatus"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        typeDescription: json["typeDescription"],
        receiverName: json["receiverName"],
        isIncome: json["isIncome"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uniqueId": uniqueId,
        "type": type,
        "userCoin": userCoin,
        "payoutStatus": payoutStatus,
        "createdAt": createdAt?.toIso8601String(),
        "typeDescription": typeDescription,
        "receiverName": receiverName,
        "isIncome": isIncome,
      };
}
