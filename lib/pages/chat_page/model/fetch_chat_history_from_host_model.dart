// To parse this JSON data, do
//
//     final fetchChatHistoryFromHostModel = fetchChatHistoryFromHostModelFromJson(jsonString);

import 'dart:convert';

FetchChatHistoryFromHostModel fetchChatHistoryFromHostModelFromJson(String str) => FetchChatHistoryFromHostModel.fromJson(json.decode(str));

String fetchChatHistoryFromHostModelToJson(FetchChatHistoryFromHostModel data) => json.encode(data.toJson());

class FetchChatHistoryFromHostModel {
  bool? status;
  String? message;
  String? chatTopic;
  List<HostChat>? chat;
  CallRate? callRate;

  FetchChatHistoryFromHostModel({
    this.status,
    this.message,
    this.chatTopic,
    this.chat,
    this.callRate,
  });

  factory FetchChatHistoryFromHostModel.fromJson(Map<String, dynamic> json) => FetchChatHistoryFromHostModel(
        status: json["status"],
        message: json["message"],
        chatTopic: json["chatTopic"],
        chat: json["chat"] == null ? [] : List<HostChat>.from(json["chat"]!.map((x) => HostChat.fromJson(x))),
        callRate: json["callRate"] == null ? null : CallRate.fromJson(json["callRate"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "chatTopic": chatTopic,
        "chat": chat == null ? [] : List<dynamic>.from(chat!.map((x) => x.toJson())),
        "callRate": callRate?.toJson(),
      };
}

class CallRate {
  int? privateCallRate;
  int? audioCallRate;

  CallRate({
    this.privateCallRate,
    this.audioCallRate,
  });

  factory CallRate.fromJson(Map<String, dynamic> json) => CallRate(
        privateCallRate: json["privateCallRate"],
        audioCallRate: json["audioCallRate"],
      );

  Map<String, dynamic> toJson() => {
        "privateCallRate": privateCallRate,
        "audioCallRate": audioCallRate,
      };
}

class HostChat {
  String? id;
  String? chatTopicId;
  String? senderId;
  int? messageType;
  String? message;
  String? image;
  String? audio;
  int? giftType;
  int? giftCount;
  String? giftsvgaImage;
  String? giftImage;
  bool? isRead;
  dynamic callId;
  String? callDuration;
  String? date;
  DateTime? createdAt;
  DateTime? updatedAt;

  HostChat({
    this.id,
    this.chatTopicId,
    this.senderId,
    this.messageType,
    this.message,
    this.image,
    this.audio,
    this.giftType,
    this.giftCount,
    this.giftsvgaImage,
    this.giftImage,
    this.isRead,
    this.callId,
    this.callDuration,
    this.date,
    this.createdAt,
    this.updatedAt,
  });

  factory HostChat.fromJson(Map<String, dynamic> json) => HostChat(
        id: json["_id"],
        chatTopicId: json["chatTopicId"],
        senderId: json["senderId"],
        messageType: json["messageType"],
        message: json["message"],
        image: json["image"],
        audio: json["audio"],
        giftType: json["giftType"],
        giftCount: json["giftCount"],
        giftsvgaImage: json["giftsvgaImage"],
    giftImage: json["giftImage"],
        isRead: json["isRead"],
        callId: json["callId"],
        callDuration: json["callDuration"],
        date: json["date"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "chatTopicId": chatTopicId,
        "senderId": senderId,
        "messageType": messageType,
        "message": message,
        "image": image,
        "audio": audio,
        "giftType": giftType,
        "giftCount": giftCount,
        "giftsvgaImage": giftsvgaImage,
        "giftImage": giftImage,
        "isRead": isRead,
        "callId": callId,
        "callDuration": callDuration,
        "date": date,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
