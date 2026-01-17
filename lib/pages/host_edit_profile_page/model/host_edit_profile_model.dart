import 'dart:convert';

HostEditProfileModel hostEditProfileModelFromJson(String str) => HostEditProfileModel.fromJson(json.decode(str));

String hostEditProfileModelToJson(HostEditProfileModel data) => json.encode(data.toJson());

class HostEditProfileModel {
  bool? status;
  String? message;
  // Host? host;

  HostEditProfileModel({
    this.status,
    this.message,
    // this.host,
  });

  factory HostEditProfileModel.fromJson(Map<String, dynamic> json) => HostEditProfileModel(
        status: json["status"],
        message: json["message"],
        // host: json["host"] == null ? null : Host.fromJson(json["host"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        // "host": host?.toJson(),
      };
}

class Host {
  String? id;
  String? userId;
  String? agencyId;
  String? name;
  String? gender;
  String? bio;
  num? age;
  String? dob;
  String? email;
  String? countryFlagImage;
  String? country;
  List<String>? impression;
  List<String>? language;
  String? identityProofType;
  List<String>? identityProof;
  String? image;
  List<PhotoGallery>? photoGallery;
  String? video;
  String? ipAddress;
  String? identity;
  String? fcmToken;
  String? uniqueId;
  num? status;
  String? reason;
  num? randomCallRate;
  num? randomCallFemaleRate;
  num? randomCallMaleRate;
  num? privateCallRate;
  num? audioCallRate;
  num? chatRate;
  num? coin;
  num? totalGifts;
  num? redeemedCoins;
  num? redeemedAmount;
  bool? isBlock;
  bool? isFake;
  bool? isOnline;
  bool? isBusy;
  dynamic callId;
  bool? isLive;
  dynamic liveHistoryId;
  num? agoraUid;
  String? channel;
  String? token;
  String? date;
  DateTime? createdAt;
  DateTime? updatedAt;

  Host({
    this.id,
    this.userId,
    this.agencyId,
    this.name,
    this.gender,
    this.bio,
    this.age,
    this.dob,
    this.email,
    this.countryFlagImage,
    this.country,
    this.impression,
    this.language,
    this.identityProofType,
    this.identityProof,
    this.image,
    this.photoGallery,
    this.video,
    this.ipAddress,
    this.identity,
    this.fcmToken,
    this.uniqueId,
    this.status,
    this.reason,
    this.randomCallRate,
    this.randomCallFemaleRate,
    this.randomCallMaleRate,
    this.privateCallRate,
    this.audioCallRate,
    this.chatRate,
    this.coin,
    this.totalGifts,
    this.redeemedCoins,
    this.redeemedAmount,
    this.isBlock,
    this.isFake,
    this.isOnline,
    this.isBusy,
    this.callId,
    this.isLive,
    this.liveHistoryId,
    this.agoraUid,
    this.channel,
    this.token,
    this.date,
    this.createdAt,
    this.updatedAt,
  });

  factory Host.fromJson(Map<String, dynamic> json) => Host(
        id: json["_id"],
        userId: json["userId"],
        agencyId: json["agencyId"],
        name: json["name"],
        gender: json["gender"],
        bio: json["bio"],
        age: json["age"],
        dob: json["dob"],
        email: json["email"],
        countryFlagImage: json["countryFlagImage"],
        country: json["country"],
        impression: json["impression"] == null ? [] : List<String>.from(json["impression"]!.map((x) => x)),
        language: json["language"] == null ? [] : List<String>.from(json["language"]!.map((x) => x)),
        identityProofType: json["identityProofType"],
        identityProof: json["identityProof"] == null ? [] : List<String>.from(json["identityProof"]!.map((x) => x)),
        image: json["image"],
        photoGallery: json["photoGallery"] == null ? [] : List<PhotoGallery>.from(json["photoGallery"]!.map((x) => PhotoGallery.fromJson(x))),
        video: json["video"],
        ipAddress: json["ipAddress"],
        identity: json["identity"],
        fcmToken: json["fcmToken"],
        uniqueId: json["uniqueId"],
        status: json["status"],
        reason: json["reason"],
        randomCallRate: json["randomCallRate"],
        randomCallFemaleRate: json["randomCallFemaleRate"],
        randomCallMaleRate: json["randomCallMaleRate"],
        privateCallRate: json["privateCallRate"],
        audioCallRate: json["audioCallRate"],
        chatRate: json["chatRate"],
        coin: json["coin"],
        totalGifts: json["totalGifts"],
        redeemedCoins: json["redeemedCoins"],
        redeemedAmount: json["redeemedAmount"],
        isBlock: json["isBlock"],
        isFake: json["isFake"],
        isOnline: json["isOnline"],
        isBusy: json["isBusy"],
        callId: json["callId"],
        isLive: json["isLive"],
        liveHistoryId: json["liveHistoryId"],
        agoraUid: json["agoraUid"],
        channel: json["channel"],
        token: json["token"],
        date: json["date"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "agencyId": agencyId,
        "name": name,
        "gender": gender,
        "bio": bio,
        "age": age,
        "dob": dob,
        "email": email,
        "countryFlagImage": countryFlagImage,
        "country": country,
        "impression": impression == null ? [] : List<dynamic>.from(impression!.map((x) => x)),
        "language": language == null ? [] : List<dynamic>.from(language!.map((x) => x)),
        "identityProofType": identityProofType,
        "identityProof": identityProof == null ? [] : List<dynamic>.from(identityProof!.map((x) => x)),
        "image": image,
        "photoGallery": photoGallery == null ? [] : List<dynamic>.from(photoGallery!.map((x) => x.toJson())),
        "video": video,
        "ipAddress": ipAddress,
        "identity": identity,
        "fcmToken": fcmToken,
        "uniqueId": uniqueId,
        "status": status,
        "reason": reason,
        "randomCallRate": randomCallRate,
        "randomCallFemaleRate": randomCallFemaleRate,
        "randomCallMaleRate": randomCallMaleRate,
        "privateCallRate": privateCallRate,
        "audioCallRate": audioCallRate,
        "chatRate": chatRate,
        "coin": coin,
        "totalGifts": totalGifts,
        "redeemedCoins": redeemedCoins,
        "redeemedAmount": redeemedAmount,
        "isBlock": isBlock,
        "isFake": isFake,
        "isOnline": isOnline,
        "isBusy": isBusy,
        "callId": callId,
        "isLive": isLive,
        "liveHistoryId": liveHistoryId,
        "agoraUid": agoraUid,
        "channel": channel,
        "token": token,
        "date": date,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class PhotoGallery {
  String? url;

  PhotoGallery({
    this.url,
  });

  factory PhotoGallery.fromJson(Map<String, dynamic> json) => PhotoGallery(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
