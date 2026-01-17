// To parse this JSON data, do
//
//     final userDeleteAccountModel = userDeleteAccountModelFromJson(jsonString);

import 'dart:convert';

UserDeleteAccountModel userDeleteAccountModelFromJson(String str) => UserDeleteAccountModel.fromJson(json.decode(str));

String userDeleteAccountModelToJson(UserDeleteAccountModel data) => json.encode(data.toJson());

class UserDeleteAccountModel {
  bool? status;
  String? message;

  UserDeleteAccountModel({
    this.status,
    this.message,
  });

  factory UserDeleteAccountModel.fromJson(Map<String, dynamic> json) => UserDeleteAccountModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
