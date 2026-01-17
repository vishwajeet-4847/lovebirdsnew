import 'dart:convert';

GetVipPlanModel getVipPlanModelFromJson(String str) => GetVipPlanModel.fromJson(json.decode(str));

String getVipPlanModelToJson(GetVipPlanModel data) => json.encode(data.toJson());

class GetVipPlanModel {
  bool? status;
  String? message;
  List<VipPlan>? data;

  GetVipPlanModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetVipPlanModel.fromJson(Map<String, dynamic> json) => GetVipPlanModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<VipPlan>.from(json["data"]!.map((x) => VipPlan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class VipPlan {
  String? id;
  num? validity;
  String? validityType;
  num? coin;
  num? price;
  String? productId;

  VipPlan({
    this.id,
    this.validity,
    this.validityType,
    this.coin,
    this.price,
    this.productId,
  });

  factory VipPlan.fromJson(Map<String, dynamic> json) => VipPlan(
        id: json["_id"],
        validity: json["validity"],
        validityType: json["validityType"],
        coin: json["coin"],
        price: json["price"],
        productId: json["productId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "validity": validity,
        "validityType": validityType,
        "coin": coin,
        "price": price,
        "productId": productId,
      };
}
