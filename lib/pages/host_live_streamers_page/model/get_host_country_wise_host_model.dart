import 'dart:convert';

GetHostCountryWiseHostModel getHostCountryWiseHostModelFromJson(String str) => GetHostCountryWiseHostModel.fromJson(json.decode(str));

String getHostCountryWiseHostModelToJson(GetHostCountryWiseHostModel data) => json.encode(data.toJson());

class GetHostCountryWiseHostModel {
  bool? status;
  String? message;
  List<HostList>? hosts;
  List<FollowerList>? followerList;

  GetHostCountryWiseHostModel({
    this.status,
    this.message,
    this.hosts,
    this.followerList,
  });

  factory GetHostCountryWiseHostModel.fromJson(Map<String, dynamic> json) => GetHostCountryWiseHostModel(
        status: json["status"],
        message: json["message"],
        hosts: json["hosts"] == null ? [] : List<HostList>.from(json["hosts"]!.map((x) => HostList.fromJson(x))),
        followerList: json["followerList"] == null ? [] : List<FollowerList>.from(json["followerList"]!.map((x) => FollowerList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "hosts": hosts == null ? [] : List<dynamic>.from(hosts!.map((x) => x.toJson())),
        "followerList": followerList == null ? [] : List<dynamic>.from(followerList!.map((x) => x.toJson())),
      };
}

class FollowerList {
  String? id;
  FollowerId? followerId;
  String? followingId;
  DateTime? createdAt;
  DateTime? updatedAt;

  FollowerList({
    this.id,
    this.followerId,
    this.followingId,
    this.createdAt,
    this.updatedAt,
  });

  factory FollowerList.fromJson(Map<String, dynamic> json) => FollowerList(
        id: json["_id"],
        followerId: json["followerId"] == null ? null : FollowerId.fromJson(json["followerId"]),
        followingId: json["followingId"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "followerId": followerId?.toJson(),
        "followingId": followingId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class FollowerId {
  String? id;
  String? name;
  String? image;
  String? uniqueId;

  FollowerId({
    this.id,
    this.name,
    this.image,
    this.uniqueId,
  });

  factory FollowerId.fromJson(Map<String, dynamic> json) => FollowerId(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        uniqueId: json["uniqueId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "uniqueId": uniqueId,
      };
}

class HostList {
  String? id;
  String? name;
  String? countryFlagImage;
  String? country;
  String? image;
  int? privateCallRate;
  int? audioCallRate;
  bool? isFake;
  String? status;

  HostList({
    this.id,
    this.name,
    this.countryFlagImage,
    this.country,
    this.image,
    this.privateCallRate,
    this.audioCallRate,
    this.isFake,
    this.status,
  });

  factory HostList.fromJson(Map<String, dynamic> json) => HostList(
        id: json["_id"],
        name: json["name"],
        countryFlagImage: json["countryFlagImage"],
        country: json["country"],
        image: json["image"],
        privateCallRate: json["privateCallRate"],
        audioCallRate: json["audioCallRate"],
        isFake: json["isFake"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "countryFlagImage": countryFlagImage,
        "country": country,
        "image": image,
        "privateCallRate": privateCallRate,
        "audioCallRate": audioCallRate,
        "isFake": isFake,
        "status": status,
      };
}
