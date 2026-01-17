// To parse this JSON data, do
//
//     final createHostLiveModel = createHostLiveModelFromJson(jsonString);

import 'dart:convert';

CreateHostLiveModel createHostLiveModelFromJson(String str) => CreateHostLiveModel.fromJson(json.decode(str));

String createHostLiveModelToJson(CreateHostLiveModel data) => json.encode(data.toJson());

class CreateHostLiveModel {
  bool? status;
  String? message;
  CreateHostLive? data;

  CreateHostLiveModel({
    this.status,
    this.message,
    this.data,
  });

  factory CreateHostLiveModel.fromJson(Map<String, dynamic> json) => CreateHostLiveModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : CreateHostLive.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class CreateHostLive {
  String? liveHistoryId;
  String? hostId;
  String? name;
  String? gender;
  String? image;
  String? countryFlagImage;
  String? country;
  bool? isFake;
  int? agoraUid;
  String? channel;
  String? token;
  int? view;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  CreateHostLive({
    this.liveHistoryId,
    this.hostId,
    this.name,
    this.gender,
    this.image,
    this.countryFlagImage,
    this.country,
    this.isFake,
    this.agoraUid,
    this.channel,
    this.token,
    this.view,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory CreateHostLive.fromJson(Map<String, dynamic> json) => CreateHostLive(
        liveHistoryId: json["liveHistoryId"],
        hostId: json["hostId"],
        name: json["name"],
        gender: json["gender"],
        image: json["image"],
        countryFlagImage: json["countryFlagImage"],
        country: json["country"],
        isFake: json["isFake"],
        agoraUid: json["agoraUid"],
        channel: json["channel"],
        token: json["token"],
        view: json["view"],
        id: json["_id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "liveHistoryId": liveHistoryId,
        "hostId": hostId,
        "name": name,
        "gender": gender,
        "image": image,
        "countryFlagImage": countryFlagImage,
        "country": country,
        "isFake": isFake,
        "agoraUid": agoraUid,
        "channel": channel,
        "token": token,
        "view": view,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
