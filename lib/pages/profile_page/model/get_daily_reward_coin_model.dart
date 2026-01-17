import 'dart:convert';

GetDailyRewardCoinModel getDailyRewardCoinModelFromJson(String str) => GetDailyRewardCoinModel.fromJson(json.decode(str));

String getDailyRewardCoinModelToJson(GetDailyRewardCoinModel data) => json.encode(data.toJson());

class GetDailyRewardCoinModel {
  bool? status;
  String? message;
  List<Datum>? data;
  int? streak;
  num? totalCoins;

  GetDailyRewardCoinModel({
    this.status,
    this.message,
    this.data,
    this.streak,
    this.totalCoins,
  });

  factory GetDailyRewardCoinModel.fromJson(Map<String, dynamic> json) => GetDailyRewardCoinModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        streak: json["streak"],
        totalCoins: json["totalCoins"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "streak": streak,
        "totalCoins": totalCoins,
      };
}

class Datum {
  int? day;
  int? reward;
  bool? isCheckIn;
  dynamic checkInDate;

  Datum({
    this.day,
    this.reward,
    this.isCheckIn,
    this.checkInDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        day: json["day"],
        reward: json["reward"],
        isCheckIn: json["isCheckIn"],
        checkInDate: json["checkInDate"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "reward": reward,
        "isCheckIn": isCheckIn,
        "checkInDate": checkInDate,
      };
}
