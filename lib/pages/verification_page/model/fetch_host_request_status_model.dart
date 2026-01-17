// To parse this JSON data, do
//
//     final fetchHostRequestStatusModel = fetchHostRequestStatusModelFromJson(jsonString);

import 'dart:convert';

FetchHostRequestStatusModel fetchHostRequestStatusModelFromJson(String str) => FetchHostRequestStatusModel.fromJson(json.decode(str));

String fetchHostRequestStatusModelToJson(FetchHostRequestStatusModel data) => json.encode(data.toJson());

class FetchHostRequestStatusModel {
  bool? status;
  String? message;
  num? data;

  FetchHostRequestStatusModel({
    this.status,
    this.message,
    this.data,
  });

  factory FetchHostRequestStatusModel.fromJson(Map<String, dynamic> json) => FetchHostRequestStatusModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
