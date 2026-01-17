// To parse this JSON data, do
//
//     final fetchHostCoinHistoryModel = fetchHostCoinHistoryModelFromJson(jsonString);

import 'dart:convert';

FetchHostCoinHistoryModel fetchHostCoinHistoryModelFromJson(String str) => FetchHostCoinHistoryModel.fromJson(json.decode(str));

String fetchHostCoinHistoryModelToJson(FetchHostCoinHistoryModel data) => json.encode(data.toJson());

class FetchHostCoinHistoryModel {
  bool? status;
  String? message;
  num? hostCoin;
  List<HostCoinHistory>? data;

  FetchHostCoinHistoryModel({
    this.status,
    this.message,
    this.hostCoin,
    this.data,
  });

  factory FetchHostCoinHistoryModel.fromJson(Map<String, dynamic> json) => FetchHostCoinHistoryModel(
        status: json["status"],
        message: json["message"],
        hostCoin: json["hostCoin"]?.toDouble(),
        data: json["data"] == null ? [] : List<HostCoinHistory>.from(json["data"]!.map((x) => HostCoinHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "hostCoin": hostCoin,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class HostCoinHistory {
  String? id;
  String? uniqueId;
  int? type;
  double? hostCoin;
  int? payoutStatus;
  DateTime? createdAt;
  String? typeDescription;
  String? senderName;

  HostCoinHistory({
    this.id,
    this.uniqueId,
    this.type,
    this.hostCoin,
    this.payoutStatus,
    this.createdAt,
    this.typeDescription,
    this.senderName,
  });

  factory HostCoinHistory.fromJson(Map<String, dynamic> json) => HostCoinHistory(
        id: json["_id"],
        uniqueId: json["uniqueId"],
        type: json["type"],
        hostCoin: json["hostCoin"]?.toDouble(),
        payoutStatus: json["payoutStatus"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        typeDescription: json["typeDescription"],
        senderName: json["senderName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uniqueId": uniqueId,
        "type": type,
        "hostCoin": hostCoin,
        "payoutStatus": payoutStatus,
        "createdAt": createdAt?.toIso8601String(),
        "typeDescription": typeDescription,
        "senderName": senderName,
      };
}
