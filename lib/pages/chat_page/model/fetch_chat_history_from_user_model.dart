// To parse this JSON data, do
//
//     final fetchChatHistoryFromUserModel = fetchChatHistoryFromUserModelFromJson(jsonString);

import 'dart:convert';

FetchChatHistoryFromUserModel fetchChatHistoryFromUserModelFromJson(String str) => FetchChatHistoryFromUserModel.fromJson(json.decode(str));

String fetchChatHistoryFromUserModelToJson(FetchChatHistoryFromUserModel data) => json.encode(data.toJson());

class FetchChatHistoryFromUserModel {
  bool? status;
  String? message;
  String? chatTopic;
  List<UserChat>? chat;
  CallRate? callRate;

  FetchChatHistoryFromUserModel({
    this.status,
    this.message,
    this.chatTopic,
    this.chat,
    this.callRate,
  });

  factory FetchChatHistoryFromUserModel.fromJson(Map<String, dynamic> json) => FetchChatHistoryFromUserModel(
        status: json["status"],
        message: json["message"],
        chatTopic: json["chatTopic"],
        chat: json["chat"] == null ? [] : List<UserChat>.from(json["chat"]!.map((x) => UserChat.fromJson(x))),
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

class UserChat {
  String? id;
  String? chatTopicId;
  String? senderId;
  num? messageType;
  String? message;
  String? image;
  String? audio;
  num? giftType;
  num? giftCount;
  String? giftsvgaImage;
  String? giftImage;
  bool? isRead;
  dynamic callId;
  String? callDuration;
  String? date;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserChat({
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

  factory UserChat.fromJson(Map<String, dynamic> json) => UserChat(
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
        "giftsvgaImage": giftsvgaImage,
        "giftImage": giftImage,
        "giftCount": giftCount,
        "isRead": isRead,
        "callId": callId,
        "callDuration": callDuration,
        "date": date,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
