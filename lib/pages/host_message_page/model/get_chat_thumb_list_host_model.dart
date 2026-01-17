// To parse this JSON data, do
//
//     final getChatThumbListHostModel = getChatThumbListHostModelFromJson(jsonString);

import 'dart:convert';

GetChatThumbListHostModel getChatThumbListHostModelFromJson(String str) =>
    GetChatThumbListHostModel.fromJson(json.decode(str));

String getChatThumbListHostModelToJson(GetChatThumbListHostModel data) =>
    json.encode(data.toJson());

class GetChatThumbListHostModel {
  bool? status;
  String? message;
  List<HostChatList>? chatList;

  GetChatThumbListHostModel({
    this.status,
    this.message,
    this.chatList,
  });

  factory GetChatThumbListHostModel.fromJson(Map<String, dynamic> json) =>
      GetChatThumbListHostModel(
        status: json["status"],
        message: json["message"],
        chatList: json["chatList"] == null
            ? []
            : List<HostChatList>.from(
                json["chatList"]!.map((x) => HostChatList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "chatList": chatList == null
            ? []
            : List<dynamic>.from(chatList!.map((x) => x.toJson())),
      };
}

class HostChatList {
  String? id;
  String? userId;
  String? name;
  String? image;
  bool? isOnline;
  dynamic chatTopic;
  String? senderId;
  String? message;
  int? messageType;
  int? unreadCount;
  String? time;

  HostChatList({
    this.id,
    this.userId,
    this.name,
    this.image,
    this.isOnline,
    this.chatTopic,
    this.senderId,
    this.message,
    this.messageType,
    this.unreadCount,
    this.time,
  });

  factory HostChatList.fromJson(Map<String, dynamic> json) => HostChatList(
        id: json["_id"],
        userId: json["userId"],
        name: json["name"],
        image: json["image"],
        isOnline: json["isOnline"],
        chatTopic: json["chatTopic"],
        senderId: json["senderId"],
        message: json["message"],
        messageType: json["messageType"],
        unreadCount: json["unreadCount"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "name": name,
        "image": image,
        "isOnline": isOnline,
        "chatTopic": chatTopic,
        "senderId": senderId,
        "message": message,
        "messageType": messageType,
        "unreadCount": unreadCount,
        "time": time,
      };
}
