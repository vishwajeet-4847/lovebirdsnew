import 'dart:convert';

GetPaymentModel getPaymentModelFromJson(String str) => GetPaymentModel.fromJson(json.decode(str));

String getPaymentModelToJson(GetPaymentModel data) => json.encode(data.toJson());

class GetPaymentModel {
  bool? status;
  String? message;
  List<WithdrawMethods>? data;

  GetPaymentModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetPaymentModel.fromJson(Map<String, dynamic> json) => GetPaymentModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<WithdrawMethods>.from(json["data"]!.map((x) => WithdrawMethods.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class WithdrawMethods {
  String? id;
  String? name;
  String? image;
  List<String>? details;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  WithdrawMethods({
    this.id,
    this.name,
    this.image,
    this.details,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory WithdrawMethods.fromJson(Map<String, dynamic> json) => WithdrawMethods(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        details: json["details"] == null ? [] : List<String>.from(json["details"]!.map((x) => x)),
        isActive: json["isActive"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "details": details == null ? [] : List<dynamic>.from(details!.map((x) => x)),
        "isActive": isActive,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
