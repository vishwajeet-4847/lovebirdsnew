// To parse this JSON data, do
//
//     final validateAgencyCodeModel = validateAgencyCodeModelFromJson(jsonString);

import 'dart:convert';

ValidateAgencyCodeModel validateAgencyCodeModelFromJson(String str) => ValidateAgencyCodeModel.fromJson(json.decode(str));

String validateAgencyCodeModelToJson(ValidateAgencyCodeModel data) => json.encode(data.toJson());

class ValidateAgencyCodeModel {
  bool? status;
  String? message;
  bool? isValid;

  ValidateAgencyCodeModel({
    this.status,
    this.message,
    this.isValid,
  });

  factory ValidateAgencyCodeModel.fromJson(Map<String, dynamic> json) => ValidateAgencyCodeModel(
        status: json["status"],
        message: json["message"],
        isValid: json["isValid"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "isValid": isValid,
      };
}
