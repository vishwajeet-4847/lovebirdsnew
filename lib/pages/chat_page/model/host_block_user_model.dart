// To parse this JSON data, do
//
//     final hostBlockUserApiModel = hostBlockUserApiModelFromJson(jsonString);

import 'dart:convert';

HostBlockUserApiModel hostBlockUserApiModelFromJson(String str) =>
    HostBlockUserApiModel.fromJson(json.decode(str));

String hostBlockUserApiModelToJson(HostBlockUserApiModel data) =>
    json.encode(data.toJson());

class HostBlockUserApiModel {
  bool? status;
  String? message;
  bool? isBlocked;

  HostBlockUserApiModel({
    this.status,
    this.message,
    this.isBlocked,
  });

  factory HostBlockUserApiModel.fromJson(Map<String, dynamic> json) =>
      HostBlockUserApiModel(
        status: json["status"],
        message: json["message"],
        isBlocked: json["isBlocked"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "isBlocked": isBlocked,
      };
}
