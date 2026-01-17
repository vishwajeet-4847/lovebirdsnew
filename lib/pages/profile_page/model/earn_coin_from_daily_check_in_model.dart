import 'dart:convert';

EarnCoinFromDailyCheckInModel earnCoinFromDailyCheckInModelFromJson(String str) => EarnCoinFromDailyCheckInModel.fromJson(json.decode(str));

String earnCoinFromDailyCheckInModelToJson(EarnCoinFromDailyCheckInModel data) => json.encode(data.toJson());

class EarnCoinFromDailyCheckInModel {
  bool? status;
  String? message;
  bool? isCheckIn;

  EarnCoinFromDailyCheckInModel({
    this.status,
    this.message,
    this.isCheckIn,
  });

  factory EarnCoinFromDailyCheckInModel.fromJson(Map<String, dynamic> json) => EarnCoinFromDailyCheckInModel(
        status: json["status"],
        message: json["message"],
        isCheckIn: json["isCheckIn"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "isCheckIn": isCheckIn,
      };
}
