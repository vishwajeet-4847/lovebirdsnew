// To parse this JSON data, do
//
//     final getHostProfileModel = getHostProfileModelFromJson(jsonString);

import 'dart:convert';

GetHostProfileModel getHostProfileModelFromJson(String str) => GetHostProfileModel.fromJson(json.decode(str));

String getHostProfileModelToJson(GetHostProfileModel data) => json.encode(data.toJson());

class GetHostProfileModel {
  bool? status;
  String? message;
  Host? host;
  List<ReceivedGift>? receivedGifts;

  GetHostProfileModel({
    this.status,
    this.message,
    this.host,
    this.receivedGifts,
  });

  factory GetHostProfileModel.fromJson(Map<String, dynamic> json) => GetHostProfileModel(
        status: json["status"],
        message: json["message"],
        host: json["host"] == null ? null : Host.fromJson(json["host"]),
        receivedGifts: json["receivedGifts"] == null ? [] : List<ReceivedGift>.from(json["receivedGifts"]!.map((x) => ReceivedGift.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "host": host?.toJson(),
        "receivedGifts": receivedGifts == null ? [] : List<dynamic>.from(receivedGifts!.map((x) => x)),
      };
}

class Host {
  String? id;
  String? name;
  String? gender;
  String? bio;
  String? dob;
  String? email;
  String? countryFlagImage;
  String? country;
  List<String>? impression;
  List<String>? language;
  String? image;
  List<String>? photoGallery;
  List<String>? profileVideo;
  num? randomCallRate;
  num? randomCallFemaleRate;
  num? randomCallMaleRate;
  num? privateCallRate;
  num? audioCallRate;
  num? chatRate;
  num? coin;
  String? uniqueId;

  Host({
    this.id,
    this.name,
    this.gender,
    this.bio,
    this.dob,
    this.email,
    this.countryFlagImage,
    this.country,
    this.impression,
    this.language,
    this.image,
    this.photoGallery,
    this.profileVideo,
    this.randomCallRate,
    this.randomCallFemaleRate,
    this.randomCallMaleRate,
    this.privateCallRate,
    this.audioCallRate,
    this.chatRate,
    this.coin,
    this.uniqueId,
  });

  factory Host.fromJson(Map<String, dynamic> json) => Host(
        id: json["_id"],
        name: json["name"],
        gender: json["gender"],
        bio: json["bio"],
        dob: json["dob"],
        email: json["email"],
        countryFlagImage: json["countryFlagImage"],
        country: json["country"],
        impression: json["impression"] == null ? [] : List<String>.from(json["impression"]!.map((x) => x)),
        language: json["language"] == null ? [] : List<String>.from(json["language"]!.map((x) => x)),
        image: json["image"],
        photoGallery: json["photoGallery"] == null ? [] : List<String>.from(json["photoGallery"]!.map((x) => x)),
        profileVideo: json["profileVideo"] == null ? [] : List<String>.from(json["profileVideo"]!.map((x) => x)),
        randomCallRate: json["randomCallRate"],
        randomCallFemaleRate: json["randomCallFemaleRate"],
        randomCallMaleRate: json["randomCallMaleRate"],
        privateCallRate: json["privateCallRate"],
        audioCallRate: json["audioCallRate"],
        chatRate: json["chatRate"],
        coin: json["coin"],
        uniqueId: json["uniqueId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "gender": gender,
        "bio": bio,
        "dob": dob,
        "email": email,
        "countryFlagImage": countryFlagImage,
        "country": country,
        "impression": impression == null ? [] : List<dynamic>.from(impression!.map((x) => x)),
        "language": language == null ? [] : List<dynamic>.from(language!.map((x) => x)),
        "image": image,
        "photoGallery": photoGallery == null ? [] : List<dynamic>.from(photoGallery!.map((x) => x)),
        "profileVideo": profileVideo == null ? [] : List<dynamic>.from(profileVideo!.map((x) => x)),
        "randomCallRate": randomCallRate,
        "randomCallFemaleRate": randomCallFemaleRate,
        "randomCallMaleRate": randomCallMaleRate,
        "privateCallRate": privateCallRate,
        "audioCallRate": audioCallRate,
        "chatRate": chatRate,
        "coin": coin,
        "uniqueId": uniqueId,
      };
}

class ReceivedGift {
  String? id;
  num? totalReceived;
  num? giftType;
  DateTime? lastReceivedAt;
  String? giftImage;
  String? giftId;

  ReceivedGift({
    this.id,
    this.giftType,
    this.totalReceived,
    this.lastReceivedAt,
    this.giftImage,
    this.giftId,
  });

  factory ReceivedGift.fromJson(Map<String, dynamic> json) => ReceivedGift(
        id: json["_id"],
        giftType: json["giftType"],
        totalReceived: json["totalReceived"],
        lastReceivedAt: json["lastReceivedAt"] == null ? null : DateTime.parse(json["lastReceivedAt"]),
        giftImage: json["giftImage"],
        giftId: json["giftId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "giftType": giftType,
        "totalReceived": totalReceived,
        "lastReceivedAt": lastReceivedAt?.toIso8601String(),
        "giftImage": giftImage,
        "giftId": giftId,
      };
}
