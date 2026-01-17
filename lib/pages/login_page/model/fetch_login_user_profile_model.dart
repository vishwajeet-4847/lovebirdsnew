// To parse this JSON data, do
//
//     final fetchLoginUserProfileModel = fetchLoginUserProfileModelFromJson(jsonString);

import 'dart:convert';

FetchLoginUserProfileModel fetchLoginUserProfileModelFromJson(String str) => FetchLoginUserProfileModel.fromJson(json.decode(str));

String fetchLoginUserProfileModelToJson(FetchLoginUserProfileModel data) => json.encode(data.toJson());

class FetchLoginUserProfileModel {
  bool? status;
  String? message;
  User? user;
  bool? hasHostRequest;

  FetchLoginUserProfileModel({
    this.status,
    this.message,
    this.user,
    this.hasHostRequest,
  });

  factory FetchLoginUserProfileModel.fromJson(Map<String, dynamic> json) => FetchLoginUserProfileModel(
        status: json["status"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        hasHostRequest: json["hasHostRequest"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user?.toJson(),
        "hasHostRequest": hasHostRequest,
      };
}

class User {
  String? id;
  String? name;
  String? selfIntro;
  String? gender;
  String? bio;
  int? age;
  String? image;
  String? email;
  String? countryFlagImage;
  String? country;
  String? ipAddress;
  String? identity;
  String? fcmToken;
  String? uniqueId;
  String? firebaseUid;
  String? provider;
  num? coin;
  int? spentCoins;
  int? rechargedCoins;
  int? earnedCoins;
  int? totalGifts;
  int? redeemedCoins;
  int? redeemedAmount;
  bool? isVip;
  bool? isBlock;
  bool? isFake;
  bool? isOnline;
  bool? isBusy;
  String? callId;
  bool? isHost;
  dynamic hostId;
  String? lastlogin;
  String? date;
  int? loginType;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? dob;

  User({
    this.id,
    this.name,
    this.selfIntro,
    this.gender,
    this.bio,
    this.age,
    this.image,
    this.email,
    this.countryFlagImage,
    this.country,
    this.ipAddress,
    this.identity,
    this.fcmToken,
    this.uniqueId,
    this.firebaseUid,
    this.provider,
    this.coin,
    this.spentCoins,
    this.rechargedCoins,
    this.earnedCoins,
    this.totalGifts,
    this.redeemedCoins,
    this.redeemedAmount,
    this.isVip,
    this.isBlock,
    this.isFake,
    this.isOnline,
    this.isBusy,
    this.callId,
    this.isHost,
    this.hostId,
    this.lastlogin,
    this.date,
    this.loginType,
    this.createdAt,
    this.updatedAt,
    this.dob,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        selfIntro: json["selfIntro"],
        gender: json["gender"],
        bio: json["bio"],
        age: json["age"],
        image: json["image"],
        email: json["email"],
        countryFlagImage: json["countryFlagImage"],
        country: json["country"],
        ipAddress: json["ipAddress"],
        identity: json["identity"],
        fcmToken: json["fcmToken"],
        uniqueId: json["uniqueId"],
        firebaseUid: json["firebaseUid"],
        provider: json["provider"],
        coin: json["coin"],
        spentCoins: json["spentCoins"],
        rechargedCoins: json["rechargedCoins"],
        earnedCoins: json["earnedCoins"],
        totalGifts: json["totalGifts"],
        redeemedCoins: json["redeemedCoins"],
        redeemedAmount: json["redeemedAmount"],
        isVip: json["isVip"],
        isBlock: json["isBlock"],
        isFake: json["isFake"],
        isOnline: json["isOnline"],
        isBusy: json["isBusy"],
        callId: json["callId"],
        isHost: json["isHost"],
        hostId: json["hostId"],
        lastlogin: json["lastlogin"],
        date: json["date"],
        loginType: json["loginType"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        dob: json["dob"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "selfIntro": selfIntro,
        "gender": gender,
        "bio": bio,
        "age": age,
        "image": image,
        "email": email,
        "countryFlagImage": countryFlagImage,
        "country": country,
        "ipAddress": ipAddress,
        "identity": identity,
        "fcmToken": fcmToken,
        "uniqueId": uniqueId,
        "firebaseUid": firebaseUid,
        "provider": provider,
        "coin": coin,
        "spentCoins": spentCoins,
        "rechargedCoins": rechargedCoins,
        "earnedCoins": earnedCoins,
        "totalGifts": totalGifts,
        "redeemedCoins": redeemedCoins,
        "redeemedAmount": redeemedAmount,
        "isVip": isVip,
        "isBlock": isBlock,
        "isFake": isFake,
        "isOnline": isOnline,
        "isBusy": isBusy,
        "callId": callId,
        "isHost": isHost,
        "hostId": hostId,
        "lastlogin": lastlogin,
        "date": date,
        "loginType": loginType,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "dob": dob,
      };
}
