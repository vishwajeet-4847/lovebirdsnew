import 'dart:convert';

HostRequestModel hostRequestModelFromJson(String str) =>
    HostRequestModel.fromJson(json.decode(str));

String hostRequestModelToJson(HostRequestModel data) =>
    json.encode(data.toJson());

class HostRequestModel {
  bool status;
  String message;

  HostRequestModel({
    required this.status,
    required this.message,
  });

  factory HostRequestModel.fromJson(Map<String, dynamic> json) =>
      HostRequestModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
