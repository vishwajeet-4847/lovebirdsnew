// To parse this JSON data, do
//
//     final userBlockHostApiModel = userBlockHostApiModelFromJson(jsonString);

import 'dart:convert';

UserBlockHostApiModel userBlockHostApiModelFromJson(String str) =>
    UserBlockHostApiModel.fromJson(json.decode(str));

String userBlockHostApiModelToJson(UserBlockHostApiModel data) =>
    json.encode(data.toJson());

class UserBlockHostApiModel {
  bool? status;
  String? message;
  bool? isBlocked;

  UserBlockHostApiModel({
    this.status,
    this.message,
    this.isBlocked,
  });

  factory UserBlockHostApiModel.fromJson(Map<String, dynamic> json) =>
      UserBlockHostApiModel(
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
