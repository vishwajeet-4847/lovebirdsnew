// To parse this JSON data, do
//
//     final checkUserModel = checkUserModelFromJson(jsonString);

import 'dart:convert';

CheckUserModel checkUserModelFromJson(String str) =>
    CheckUserModel.fromJson(json.decode(str));

String checkUserModelToJson(CheckUserModel data) => json.encode(data.toJson());

class CheckUserModel {
  bool? status;
  String? message;
  bool? isLogin;

  CheckUserModel({
    this.status,
    this.message,
    this.isLogin,
  });

  factory CheckUserModel.fromJson(Map<String, dynamic> json) => CheckUserModel(
        status: json["status"],
        message: json["message"],
        isLogin: json["isLogin"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "isLogin": isLogin,
      };
}
