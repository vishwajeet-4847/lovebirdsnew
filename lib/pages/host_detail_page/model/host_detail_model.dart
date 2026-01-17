// To parse this JSON data, do
//
//     final hostDetailModel = hostDetailModelFromJson(jsonString);

import 'dart:convert';

HostDetailModel hostDetailModelFromJson(String str) => HostDetailModel.fromJson(json.decode(str));

String hostDetailModelToJson(HostDetailModel data) => json.encode(data.toJson());

class HostDetailModel {
  bool? status;
  String? message;
  Host? host;
  List<ReceivedGift>? receivedGifts;

  HostDetailModel({
    this.status,
    this.message,
    this.host,
    this.receivedGifts,
  });

  factory HostDetailModel.fromJson(Map<String, dynamic> json) => HostDetailModel(
        status: json["status"],
        message: json["message"],
        host: json["host"] == null ? null : Host.fromJson(json["host"]),
        receivedGifts: json["receivedGifts"] == null ? [] : List<ReceivedGift>.from(json["receivedGifts"]!.map((x) => ReceivedGift.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "host": host?.toJson(),
        "receivedGifts": receivedGifts == null ? [] : List<dynamic>.from(receivedGifts!.map((x) => x.toJson())),
      };
}

class Host {
  String? id;
  String? name;
  String? gender;
  String? bio;
  String? email;
  String? countryFlagImage;
  String? country;
  List<String>? impression;
  List<String>? language;
  String? image;
  List<String>? photoGallery;
  List<String>? profileVideo;
  List<String>? video;
  List<String>? liveVideo;
  String? uniqueId;
  int? randomCallRate;
  int? randomCallFemaleRate;
  int? randomCallMaleRate;
  int? privateCallRate;
  int? audioCallRate;
  int? chatRate;
  double? coin;
  bool? isFake;
  bool? isFollowing;
  int? totalFollower;

  Host({
    this.id,
    this.name,
    this.gender,
    this.bio,
    this.email,
    this.countryFlagImage,
    this.country,
    this.impression,
    this.language,
    this.image,
    this.photoGallery,
    this.profileVideo,
    this.video,
    this.liveVideo,
    this.uniqueId,
    this.randomCallRate,
    this.randomCallFemaleRate,
    this.randomCallMaleRate,
    this.privateCallRate,
    this.audioCallRate,
    this.chatRate,
    this.coin,
    this.isFake,
    this.isFollowing,
    this.totalFollower,
  });

  factory Host.fromJson(Map<String, dynamic> json) => Host(
        id: json["_id"],
        name: json["name"],
        gender: json["gender"],
        bio: json["bio"],
        email: json["email"],
        countryFlagImage: json["countryFlagImage"],
        country: json["country"],
        impression: json["impression"] == null ? [] : List<String>.from(json["impression"]!.map((x) => x)),
        language: json["language"] == null ? [] : List<String>.from(json["language"]!.map((x) => x)),
        image: json["image"],
        photoGallery: json["photoGallery"] == null ? [] : List<String>.from(json["photoGallery"]!.map((x) => x)),
        profileVideo: json["profileVideo"] == null ? [] : List<String>.from(json["profileVideo"]!.map((x) => x)),
        video: json["video"] == null ? [] : List<String>.from(json["video"]!.map((x) => x)),
        liveVideo: json["liveVideo"] == null ? [] : List<String>.from(json["liveVideo"]!.map((x) => x)),
        uniqueId: json["uniqueId"],
        randomCallRate: json["randomCallRate"],
        randomCallFemaleRate: json["randomCallFemaleRate"],
        randomCallMaleRate: json["randomCallMaleRate"],
        privateCallRate: json["privateCallRate"],
        audioCallRate: json["audioCallRate"],
        chatRate: json["chatRate"],
        coin: json["coin"]?.toDouble(),
        isFake: json["isFake"],
        isFollowing: json["isFollowing"],
        totalFollower: json["totalFollower"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "gender": gender,
        "bio": bio,
        "email": email,
        "countryFlagImage": countryFlagImage,
        "country": country,
        "impression": impression == null ? [] : List<dynamic>.from(impression!.map((x) => x)),
        "language": language == null ? [] : List<dynamic>.from(language!.map((x) => x)),
        "image": image,
        "photoGallery": photoGallery == null ? [] : List<dynamic>.from(photoGallery!.map((x) => x)),
        "profileVideo": profileVideo == null ? [] : List<dynamic>.from(profileVideo!.map((x) => x)),
        "video": video == null ? [] : List<dynamic>.from(video!.map((x) => x)),
        "liveVideo": liveVideo == null ? [] : List<dynamic>.from(liveVideo!.map((x) => x)),
        "uniqueId": uniqueId,
        "randomCallRate": randomCallRate,
        "randomCallFemaleRate": randomCallFemaleRate,
        "randomCallMaleRate": randomCallMaleRate,
        "privateCallRate": privateCallRate,
        "audioCallRate": audioCallRate,
        "chatRate": chatRate,
        "coin": coin,
        "isFake": isFake,
        "isFollowing": isFollowing,
        "totalFollower": totalFollower,
      };
}

class ReceivedGift {
  String? id;
  int? totalReceived;
  DateTime? lastReceivedAt;
  String? giftImage;
  String? giftsvgaImage;
  int? giftType;
  String? giftId;
  int? giftCoin;

  ReceivedGift({
    this.id,
    this.totalReceived,
    this.lastReceivedAt,
    this.giftImage,
    this.giftsvgaImage,
    this.giftType,
    this.giftId,
    this.giftCoin,
  });

  factory ReceivedGift.fromJson(Map<String, dynamic> json) => ReceivedGift(
        id: json["_id"],
        totalReceived: json["totalReceived"],
        lastReceivedAt: json["lastReceivedAt"] == null ? null : DateTime.parse(json["lastReceivedAt"]),
        giftImage: json["giftImage"],
        giftsvgaImage: json["giftsvgaImage"],
        giftType: json["giftType"],
        giftId: json["giftId"],
        giftCoin: json["giftCoin"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "totalReceived": totalReceived,
        "lastReceivedAt": lastReceivedAt?.toIso8601String(),
        "giftImage": giftImage,
        "giftsvgaImage": giftsvgaImage,
        "giftType": giftType,
        "giftId": giftId,
        "giftCoin": giftCoin,
      };
}
