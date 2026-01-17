// // To parse this JSON data, do
// //
// //     final getAvailableHostModel = getAvailableHostModelFromJson(jsonString);
//
// import 'dart:convert';
//
// GetAvailableHostModel getAvailableHostModelFromJson(String str) => GetAvailableHostModel.fromJson(json.decode(str));
//
// String getAvailableHostModelToJson(GetAvailableHostModel data) => json.encode(data.toJson());
//
// class GetAvailableHostModel {
//   bool? status;
//   String? message;
//   GetAvailableHost? data;
//
//   GetAvailableHostModel({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   factory GetAvailableHostModel.fromJson(Map<String, dynamic> json) => GetAvailableHostModel(
//         status: json["status"],
//         message: json["message"],
//         data: json["data"] == null ? null : GetAvailableHost.fromJson(json["data"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data?.toJson(),
//       };
// }
//
// class GetAvailableHost {
//   String? id;
//   dynamic userId;
//   dynamic agencyId;
//   String? name;
//   String? gender;
//   String? bio;
//   int? age;
//   String? dob;
//   String? email;
//   String? countryFlagImage;
//   String? country;
//   List<String>? impression;
//   List<String>? language;
//   String? identityProofType;
//   List<dynamic>? identityProof;
//   String? image;
//   List<String>? photoGallery;
//   List<String>? video;
//   List<String>? liveVideo;
//   String? ipAddress;
//   String? identity;
//   dynamic fcmToken;
//   String? uniqueId;
//   int? status;
//   String? reason;
//   int? randomCallRate;
//   int? randomCallFemaleRate;
//   int? randomCallMaleRate;
//   int? privateCallRate;
//   int? audioCallRate;
//   int? chatRate;
//   int? coin;
//   int? totalGifts;
//   int? redeemedCoins;
//   int? redeemedAmount;
//   bool? isBlock;
//   bool? isFake;
//   bool? isOnline;
//   bool? isBusy;
//   dynamic callId;
//   bool? isLive;
//   dynamic liveHistoryId;
//   int? agoraUid;
//   String? channel;
//   String? token;
//   String? date;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   GetAvailableHost({
//     this.id,
//     this.userId,
//     this.agencyId,
//     this.name,
//     this.gender,
//     this.bio,
//     this.age,
//     this.dob,
//     this.email,
//     this.countryFlagImage,
//     this.country,
//     this.impression,
//     this.language,
//     this.identityProofType,
//     this.identityProof,
//     this.image,
//     this.photoGallery,
//     this.video,
//     this.liveVideo,
//     this.ipAddress,
//     this.identity,
//     this.fcmToken,
//     this.uniqueId,
//     this.status,
//     this.reason,
//     this.randomCallRate,
//     this.randomCallFemaleRate,
//     this.randomCallMaleRate,
//     this.privateCallRate,
//     this.audioCallRate,
//     this.chatRate,
//     this.coin,
//     this.totalGifts,
//     this.redeemedCoins,
//     this.redeemedAmount,
//     this.isBlock,
//     this.isFake,
//     this.isOnline,
//     this.isBusy,
//     this.callId,
//     this.isLive,
//     this.liveHistoryId,
//     this.agoraUid,
//     this.channel,
//     this.token,
//     this.date,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory GetAvailableHost.fromJson(Map<String, dynamic> json) => GetAvailableHost(
//         id: json["_id"],
//         userId: json["userId"],
//         agencyId: json["agencyId"],
//         name: json["name"],
//         gender: json["gender"],
//         bio: json["bio"],
//         age: json["age"],
//         dob: json["dob"],
//         email: json["email"],
//         countryFlagImage: json["countryFlagImage"],
//         country: json["country"],
//         impression: json["impression"] == null ? [] : List<String>.from(json["impression"]!.map((x) => x)),
//         language: json["language"] == null ? [] : List<String>.from(json["language"]!.map((x) => x)),
//         identityProofType: json["identityProofType"],
//         identityProof: json["identityProof"] == null ? [] : List<dynamic>.from(json["identityProof"]!.map((x) => x)),
//         image: json["image"],
//         photoGallery: json["photoGallery"] == null ? [] : List<String>.from(json["photoGallery"]!.map((x) => x)),
//         video: json["video"] == null ? [] : List<String>.from(json["video"]!.map((x) => x)),
//         liveVideo: json["liveVideo"] == null ? [] : List<String>.from(json["liveVideo"]!.map((x) => x)),
//         ipAddress: json["ipAddress"],
//         identity: json["identity"],
//         fcmToken: json["fcmToken"],
//         uniqueId: json["uniqueId"],
//         status: json["status"],
//         reason: json["reason"],
//         randomCallRate: json["randomCallRate"],
//         randomCallFemaleRate: json["randomCallFemaleRate"],
//         randomCallMaleRate: json["randomCallMaleRate"],
//         privateCallRate: json["privateCallRate"],
//         audioCallRate: json["audioCallRate"],
//         chatRate: json["chatRate"],
//         coin: json["coin"],
//         totalGifts: json["totalGifts"],
//         redeemedCoins: json["redeemedCoins"],
//         redeemedAmount: json["redeemedAmount"],
//         isBlock: json["isBlock"],
//         isFake: json["isFake"],
//         isOnline: json["isOnline"],
//         isBusy: json["isBusy"],
//         callId: json["callId"],
//         isLive: json["isLive"],
//         liveHistoryId: json["liveHistoryId"],
//         agoraUid: json["agoraUid"],
//         channel: json["channel"],
//         token: json["token"],
//         date: json["date"],
//         createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "userId": userId,
//         "agencyId": agencyId,
//         "name": name,
//         "gender": gender,
//         "bio": bio,
//         "age": age,
//         "dob": dob,
//         "email": email,
//         "countryFlagImage": countryFlagImage,
//         "country": country,
//         "impression": impression == null ? [] : List<dynamic>.from(impression!.map((x) => x)),
//         "language": language == null ? [] : List<dynamic>.from(language!.map((x) => x)),
//         "identityProofType": identityProofType,
//         "identityProof": identityProof == null ? [] : List<dynamic>.from(identityProof!.map((x) => x)),
//         "image": image,
//         "photoGallery": photoGallery == null ? [] : List<dynamic>.from(photoGallery!.map((x) => x)),
//         "video": video == null ? [] : List<dynamic>.from(video!.map((x) => x)),
//         "liveVideo": liveVideo == null ? [] : List<dynamic>.from(liveVideo!.map((x) => x)),
//         "ipAddress": ipAddress,
//         "identity": identity,
//         "fcmToken": fcmToken,
//         "uniqueId": uniqueId,
//         "status": status,
//         "reason": reason,
//         "randomCallRate": randomCallRate,
//         "randomCallFemaleRate": randomCallFemaleRate,
//         "randomCallMaleRate": randomCallMaleRate,
//         "privateCallRate": privateCallRate,
//         "audioCallRate": audioCallRate,
//         "chatRate": chatRate,
//         "coin": coin,
//         "totalGifts": totalGifts,
//         "redeemedCoins": redeemedCoins,
//         "redeemedAmount": redeemedAmount,
//         "isBlock": isBlock,
//         "isFake": isFake,
//         "isOnline": isOnline,
//         "isBusy": isBusy,
//         "callId": callId,
//         "isLive": isLive,
//         "liveHistoryId": liveHistoryId,
//         "agoraUid": agoraUid,
//         "channel": channel,
//         "token": token,
//         "date": date,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//       };
// }

// To parse this JSON data, do
//
//     final getAvailableHostModel = getAvailableHostModelFromJson(jsonString);

import 'dart:convert';

GetAvailableHostModel getAvailableHostModelFromJson(String str) => GetAvailableHostModel.fromJson(json.decode(str));

String getAvailableHostModelToJson(GetAvailableHostModel data) => json.encode(data.toJson());

class GetAvailableHostModel {
  bool? status;
  String? message;
  GetAvailableHost? data;

  GetAvailableHostModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetAvailableHostModel.fromJson(Map<String, dynamic> json) => GetAvailableHostModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : GetAvailableHost.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class GetAvailableHost {
  String? id;
  dynamic userId;
  dynamic agencyId;
  String? name;
  String? gender;
  String? bio;
  int? age;
  String? dob;
  String? email;
  String? countryFlagImage;
  String? country;
  List<String>? impression;
  List<String>? language;
  String? identityProofType;
  List<dynamic>? identityProof;
  String? image;
  List<String>? photoGallery;
  List<String>? video;
  List<String>? liveVideo;
  String? ipAddress;
  String? identity;
  dynamic fcmToken;
  String? uniqueId;
  int? status;
  String? reason;
  int? randomCallRate;
  int? randomCallFemaleRate;
  int? randomCallMaleRate;
  int? privateCallRate;
  int? audioCallRate;
  int? chatRate;
  double? coin;
  int? totalGifts;
  int? redeemedCoins;
  int? redeemedAmount;
  bool? isBlock;
  bool? isFake;
  bool? isOnline;
  bool? isBusy;
  dynamic callId;
  bool? isLive;
  dynamic liveHistoryId;
  int? agoraUid;
  String? channel;
  String? token;
  String? date;
  DateTime? createdAt;
  DateTime? updatedAt;

  GetAvailableHost({
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
    this.liveVideo,
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

  factory GetAvailableHost.fromJson(Map<String, dynamic> json) => GetAvailableHost(
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
        identityProof: json["identityProof"] == null ? [] : List<dynamic>.from(json["identityProof"]!.map((x) => x)),
        image: json["image"],
        photoGallery: json["photoGallery"] == null ? [] : List<String>.from(json["photoGallery"]!.map((x) => x)),
        video: json["video"] == null ? [] : List<String>.from(json["video"]!.map((x) => x)),
        liveVideo: json["liveVideo"] == null ? [] : List<String>.from(json["liveVideo"]!.map((x) => x)),
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
        coin: json["coin"]?.toDouble(),
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
        "photoGallery": photoGallery == null ? [] : List<dynamic>.from(photoGallery!.map((x) => x)),
        "video": video == null ? [] : List<dynamic>.from(video!.map((x) => x)),
        "liveVideo": liveVideo == null ? [] : List<dynamic>.from(liveVideo!.map((x) => x)),
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
