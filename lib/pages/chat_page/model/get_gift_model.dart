// To parse this JSON data, do
//
//     final getGiftModel = getGiftModelFromJson(jsonString);

import 'dart:convert';

GetGiftModel getGiftModelFromJson(String str) => GetGiftModel.fromJson(json.decode(str));

String getGiftModelToJson(GetGiftModel data) => json.encode(data.toJson());

class GetGiftModel {
  bool? status;
  String? message;
  List<Gifts>? data;

  GetGiftModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetGiftModel.fromJson(Map<String, dynamic> json) => GetGiftModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Gifts>.from(json["data"]!.map((x) => Gifts.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Gifts {
  String? id;
  int? type;
  String? image;
  String? svgaImage;
  num? coin;

  Gifts({
    this.id,
    this.type,
    this.image,
    this.svgaImage,
    this.coin,
  });

  factory Gifts.fromJson(Map<String, dynamic> json) => Gifts(
        id: json["_id"],
        type: json["type"],
        image: json["image"],
        svgaImage: json["svgaImage"],
        coin: json["coin"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "image": image,
        "svgaImage": svgaImage,
        "coin": coin,
      };
}
