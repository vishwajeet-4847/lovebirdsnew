// To parse this JSON data, do
//
//     final getChatThumbListUserModel = getChatThumbListUserModelFromJson(jsonString);

import 'dart:convert';

GetChatThumbListUserModel getChatThumbListUserModelFromJson(String str) => GetChatThumbListUserModel.fromJson(json.decode(str));

String getChatThumbListUserModelToJson(GetChatThumbListUserModel data) => json.encode(data.toJson());

class GetChatThumbListUserModel {
  bool? status;
  String? message;
  List<ChatList>? chatList;

  GetChatThumbListUserModel({
    this.status,
    this.message,
    this.chatList,
  });

  factory GetChatThumbListUserModel.fromJson(Map<String, dynamic> json) => GetChatThumbListUserModel(
        status: json["status"],
        message: json["message"],
        chatList: json["chatList"] == null ? [] : List<ChatList>.from(json["chatList"]!.map((x) => ChatList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "chatList": chatList == null ? [] : List<dynamic>.from(chatList!.map((x) => x.toJson())),
      };
}

class ChatList {
  String? id;
  String? receiverId;
  String? name;
  String? image;
  bool? isFake;
  bool? isOnline;
  String? chatTopic;
  String? senderId;
  int? messageType;
  String? message;
  int? unreadCount;
  String? time;

  ChatList({
    this.id,
    this.receiverId,
    this.name,
    this.image,
    this.isFake,
    this.isOnline,
    this.chatTopic,
    this.senderId,
    this.messageType,
    this.message,
    this.unreadCount,
    this.time,
  });

  factory ChatList.fromJson(Map<String, dynamic> json) => ChatList(
        id: json["_id"],
        receiverId: json["receiverId"],
        name: json["name"],
        image: json["image"],
        isFake: json["isFake"],
        isOnline: json["isOnline"],
        chatTopic: json["chatTopic"],
        senderId: json["senderId"],
        messageType: json["messageType"],
        message: json["message"],
        unreadCount: json["unreadCount"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "receiverId": receiverId,
        "name": name,
        "image": image,
        "isFake": isFake,
        "isOnline": isOnline,
        "chatTopic": chatTopic,
        "senderId": senderId,
        "messageType": messageType,
        "message": message,
        "unreadCount": unreadCount,
        "time": time,
      };
}
