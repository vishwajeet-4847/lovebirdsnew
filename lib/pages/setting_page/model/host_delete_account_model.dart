// To parse this JSON data, do
//
//     final hostDeleteAccountModel = hostDeleteAccountModelFromJson(jsonString);

import 'dart:convert';

HostDeleteAccountModel hostDeleteAccountModelFromJson(String str) => HostDeleteAccountModel.fromJson(json.decode(str));

String hostDeleteAccountModelToJson(HostDeleteAccountModel data) => json.encode(data.toJson());

class HostDeleteAccountModel {
  bool? status;
  String? message;

  HostDeleteAccountModel({
    this.status,
    this.message,
  });

  factory HostDeleteAccountModel.fromJson(Map<String, dynamic> json) => HostDeleteAccountModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
