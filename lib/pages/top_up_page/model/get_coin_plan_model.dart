import 'dart:convert';

GetCoinPlanModel getCoinPlanModelFromJson(String str) => GetCoinPlanModel.fromJson(json.decode(str));

String getCoinPlanModelToJson(GetCoinPlanModel data) => json.encode(data.toJson());

class GetCoinPlanModel {
  bool? status;
  String? message;
  List<CoinPlan>? data;

  GetCoinPlanModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetCoinPlanModel.fromJson(Map<String, dynamic> json) => GetCoinPlanModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<CoinPlan>.from(json["data"]!.map((x) => CoinPlan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CoinPlan {
  String? id;
  num? coins;
  num? bonusCoins;
  num? price;
  String? iconUrl;
  String? productId;
  bool? isFeatured;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  CoinPlan({
    this.id,
    this.coins,
    this.bonusCoins,
    this.price,
    this.iconUrl,
    this.productId,
    this.isFeatured,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory CoinPlan.fromJson(Map<String, dynamic> json) => CoinPlan(
        id: json["_id"],
        coins: json["coins"],
        bonusCoins: json["bonusCoins"],
        price: json["price"],
        iconUrl: json["iconUrl"],
        productId: json["productId"],
        isFeatured: json["isFeatured"],
        isActive: json["isActive"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "coins": coins,
        "bonusCoins": bonusCoins,
        "price": price,
        "iconUrl": iconUrl,
        "productId": productId,
        "isFeatured": isFeatured,
        "isActive": isActive,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
