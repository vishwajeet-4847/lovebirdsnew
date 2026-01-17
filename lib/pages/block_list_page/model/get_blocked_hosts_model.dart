import 'dart:convert';

GetBlockedHostsModel getBlockedHostsModelFromJson(String str) =>
    GetBlockedHostsModel.fromJson(json.decode(str));

String getBlockedHostsModelToJson(GetBlockedHostsModel data) =>
    json.encode(data.toJson());

class GetBlockedHostsModel {
  bool? status;
  String? message;
  List<BlockedHost>? blockedHosts;

  GetBlockedHostsModel({
    this.status,
    this.message,
    this.blockedHosts,
  });

  factory GetBlockedHostsModel.fromJson(Map<String, dynamic> json) =>
      GetBlockedHostsModel(
        status: json["status"],
        message: json["message"],
        blockedHosts: json["blockedHosts"] == null
            ? []
            : List<BlockedHost>.from(
                json["blockedHosts"]!.map((x) => BlockedHost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "blockedHosts": blockedHosts == null
            ? []
            : List<dynamic>.from(blockedHosts!.map((x) => x.toJson())),
      };
}

class BlockedHost {
  String? id;
  HostId? hostId;

  BlockedHost({
    this.id,
    this.hostId,
  });

  factory BlockedHost.fromJson(Map<String, dynamic> json) => BlockedHost(
        id: json["_id"],
        hostId: json["hostId"] == null ? null : HostId.fromJson(json["hostId"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "hostId": hostId?.toJson(),
      };
}

class HostId {
  String? id;
  String? name;
  String? countryFlagImage;
  String? country;
  String? image;

  HostId({
    this.id,
    this.name,
    this.countryFlagImage,
    this.country,
    this.image,
  });

  factory HostId.fromJson(Map<String, dynamic> json) => HostId(
        id: json["_id"],
        name: json["name"],
        countryFlagImage: json["countryFlagImage"],
        country: json["country"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "countryFlagImage": countryFlagImage,
        "country": country,
        "image": image,
      };
}
