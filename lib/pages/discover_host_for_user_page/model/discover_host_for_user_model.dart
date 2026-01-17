import 'dart:convert';

DiscoverHostForUserModel discoverHostForUserModelFromJson(String str) => DiscoverHostForUserModel.fromJson(json.decode(str));

String getCountryWiseHostModelToJson(DiscoverHostForUserModel data) => json.encode(data.toJson());

class DiscoverHostForUserModel {
  bool? status;
  String? message;
  List<Host>? followedHost;
  List<Host>? liveHost;
  List<Host>? hosts;

  DiscoverHostForUserModel({
    this.status,
    this.message,
    this.followedHost,
    this.liveHost,
    this.hosts,
  });

  factory DiscoverHostForUserModel.fromJson(Map<String, dynamic> json) => DiscoverHostForUserModel(
        status: json["status"],
        message: json["message"],
        followedHost: json["followedHost"] == null ? [] : List<Host>.from(json["followedHost"]!.map((x) => Host.fromJson(x))),
        liveHost: json["liveHost"] == null ? [] : List<Host>.from(json["liveHost"]!.map((x) => Host.fromJson(x))),
        hosts: json["hosts"] == null ? [] : List<Host>.from(json["hosts"]!.map((x) => Host.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "followedHost": followedHost == null ? [] : List<dynamic>.from(followedHost!.map((x) => x.toJson())),
        "liveHost": liveHost == null ? [] : List<dynamic>.from(liveHost!.map((x) => x.toJson())),
        "hosts": hosts == null ? [] : List<dynamic>.from(hosts!.map((x) => x.toJson())),
      };
}

class Host {
  String? id;
  String? name;
  String? countryFlagImage;
  String? country;
  String? image;
  bool? isFake;
  String? liveHistoryId;
  String? channel;
  String? token;
  String? hostId;
  List<String>? video;
  List<String>? liveVideo;
  String? status;
  int? audioCallRate;
  int? privateCallRate;

  Host({
    this.id,
    this.name,
    this.countryFlagImage,
    this.country,
    this.image,
    this.isFake,
    this.liveHistoryId,
    this.channel,
    this.token,
    this.hostId,
    this.video,
    this.liveVideo,
    this.status,
    this.audioCallRate,
    this.privateCallRate,
  });

  factory Host.fromJson(Map<String, dynamic> json) => Host(
        id: json["_id"],
        name: json["name"],
        countryFlagImage: json["countryFlagImage"],
        country: json["country"],
        image: json["image"],
        isFake: json["isFake"],
        liveHistoryId: json["liveHistoryId"],
        channel: json["channel"],
        token: json["token"],
        hostId: json["hostId"],
        video: json["video"] == null ? [] : List<String>.from(json["video"]!.map((x) => x)),
        liveVideo: json["liveVideo"] == null ? [] : List<String>.from(json["liveVideo"]!.map((x) => x)),
        status: json["status"],
        audioCallRate: json["audioCallRate"],
        privateCallRate: json["privateCallRate"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "countryFlagImage": countryFlagImage,
        "country": country,
        "image": image,
        "isFake": isFake,
        "liveHistoryId": liveHistoryId,
        "channel": channel,
        "token": token,
        "hostId": hostId,
        "video": video == null ? [] : List<dynamic>.from(video!.map((x) => x)),
        "liveVideo": liveVideo == null ? [] : List<dynamic>.from(liveVideo!.map((x) => x)),
        "status": status,
        "audioCallRate": audioCallRate,
        "privateCallRate": privateCallRate,
      };
}
