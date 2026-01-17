import 'dart:convert';

HostSendFileApiModel hostSendFileApiModelFromJson(String str) =>
    HostSendFileApiModel.fromJson(json.decode(str));

String hostSendFileApiModelToJson(HostSendFileApiModel data) =>
    json.encode(data.toJson());

class HostSendFileApiModel {
  bool? status;
  String? message;
  Chat? chat;

  HostSendFileApiModel({
    this.status,
    this.message,
    this.chat,
  });

  factory HostSendFileApiModel.fromJson(Map<String, dynamic> json) =>
      HostSendFileApiModel(
        status: json["status"],
        message: json["message"],
        chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "chat": chat?.toJson(),
      };
}

class Chat {
  String? chatTopicId;
  String? senderId;
  String? message;
  String? image;
  String? audio;
  int? giftCount;
  bool? isRead;
  dynamic callId;
  String? callDuration;
  String? date;
  String? id;
  int? messageType;
  DateTime? createdAt;
  DateTime? updatedAt;

  Chat({
    this.chatTopicId,
    this.senderId,
    this.message,
    this.image,
    this.audio,
    this.giftCount,
    this.isRead,
    this.callId,
    this.callDuration,
    this.date,
    this.id,
    this.messageType,
    this.createdAt,
    this.updatedAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        chatTopicId: json["chatTopicId"],
        senderId: json["senderId"],
        message: json["message"],
        image: json["image"],
        audio: json["audio"],
        giftCount: json["giftCount"],
        isRead: json["isRead"],
        callId: json["callId"],
        callDuration: json["callDuration"],
        date: json["date"],
        id: json["_id"],
        messageType: json["messageType"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "chatTopicId": chatTopicId,
        "senderId": senderId,
        "message": message,
        "image": image,
        "audio": audio,
        "giftCount": giftCount,
        "isRead": isRead,
        "callId": callId,
        "callDuration": callDuration,
        "date": date,
        "_id": id,
        "messageType": messageType,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
