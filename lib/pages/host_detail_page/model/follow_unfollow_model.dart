// To parse this JSON data, do
//
//     final followFollowingModel = followFollowingModelFromJson(jsonString);

import 'dart:convert';

FollowFollowingModel followFollowingModelFromJson(String str) => FollowFollowingModel.fromJson(json.decode(str));

String followFollowingModelToJson(FollowFollowingModel data) => json.encode(data.toJson());

class FollowFollowingModel {
  bool? status;
  String? message;
  bool? isFollow;

  FollowFollowingModel({
    this.status,
    this.message,
    this.isFollow,
  });

  factory FollowFollowingModel.fromJson(Map<String, dynamic> json) => FollowFollowingModel(
        status: json["status"],
        message: json["message"],
        isFollow: json["isFollow"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "isFollow": isFollow,
      };
}
