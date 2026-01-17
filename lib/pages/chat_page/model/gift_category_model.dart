import 'dart:convert';

GiftCategoryModel giftCategoryModelFromJson(String str) =>
    GiftCategoryModel.fromJson(json.decode(str));

String giftCategoryModelToJson(GiftCategoryModel data) =>
    json.encode(data.toJson());

class GiftCategoryModel {
  bool? status;
  String? message;
  List<GiftList>? data;

  GiftCategoryModel({
    this.status,
    this.message,
    this.data,
  });

  factory GiftCategoryModel.fromJson(Map<String, dynamic> json) =>
      GiftCategoryModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<GiftList>.from(
                json["data"]!.map((x) => GiftList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GiftList {
  String? id;
  String? name;

  GiftList({
    this.id,
    this.name,
  });

  factory GiftList.fromJson(Map<String, dynamic> json) => GiftList(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
