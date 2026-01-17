import 'dart:convert';

GetBlockedUserModel getBlockedUserModelFromJson(String str) =>
    GetBlockedUserModel.fromJson(json.decode(str));

String getBlockedUserModelToJson(GetBlockedUserModel data) =>
    json.encode(data.toJson());

class GetBlockedUserModel {
  bool? status;
  String? message;
  List<BlockedUser>? blockedUsers;

  GetBlockedUserModel({
    this.status,
    this.message,
    this.blockedUsers,
  });

  factory GetBlockedUserModel.fromJson(Map<String, dynamic> json) =>
      GetBlockedUserModel(
        status: json["status"],
        message: json["message"],
        blockedUsers: json["blockedUsers"] == null
            ? []
            : List<BlockedUser>.from(
                json["blockedUsers"]!.map((x) => BlockedUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "blockedUsers": blockedUsers == null
            ? []
            : List<dynamic>.from(blockedUsers!.map((x) => x.toJson())),
      };
}

class BlockedUser {
  String? id;
  UserId? userId;

  BlockedUser({
    this.id,
    this.userId,
  });

  factory BlockedUser.fromJson(Map<String, dynamic> json) => BlockedUser(
        id: json["_id"],
        userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId?.toJson(),
      };
}

class UserId {
  String? id;
  String? name;
  String? image;
  String? countryFlagImage;
  String? country;

  UserId({
    this.id,
    this.name,
    this.image,
    this.countryFlagImage,
    this.country,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        countryFlagImage: json["countryFlagImage"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "countryFlagImage": countryFlagImage,
        "country": country,
      };
}
