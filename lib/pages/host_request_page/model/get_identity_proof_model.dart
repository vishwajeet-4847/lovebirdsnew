import 'dart:convert';

GetIdentityProofModel getIdentityProofModelFromJson(String str) => GetIdentityProofModel.fromJson(json.decode(str));

String getIdentityProofModelToJson(GetIdentityProofModel data) => json.encode(data.toJson());

class GetIdentityProofModel {
  bool? status;
  String? message;
  List<Type>? data;

  GetIdentityProofModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetIdentityProofModel.fromJson(Map<String, dynamic> json) => GetIdentityProofModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Type>.from(json["data"]!.map((x) => Type.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Type {
  String? id;
  String? title;
  DateTime? createdAt;

  Type({
    this.id,
    this.title,
    this.createdAt,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["_id"],
        title: json["title"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "createdAt": createdAt?.toIso8601String(),
      };
}
