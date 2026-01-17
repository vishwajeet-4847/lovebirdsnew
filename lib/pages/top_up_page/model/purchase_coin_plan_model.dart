import 'dart:convert';

PurchaseCoinPlanModel purchaseCoinPlanModelFromJson(String str) => PurchaseCoinPlanModel.fromJson(json.decode(str));

String purchaseCoinPlanModelToJson(PurchaseCoinPlanModel data) => json.encode(data.toJson());

class PurchaseCoinPlanModel {
  bool? status;
  String? message;
  int? totalCoins;

  PurchaseCoinPlanModel({
    this.status,
    this.message,
    this.totalCoins,
  });

  factory PurchaseCoinPlanModel.fromJson(Map<String, dynamic> json) => PurchaseCoinPlanModel(
        status: json["status"],
        message: json["message"],
        totalCoins: json["totalCoins"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "totalCoins": totalCoins,
      };
}
