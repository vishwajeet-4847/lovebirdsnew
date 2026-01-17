import 'dart:convert';

GetSocketDataModel getSocketDataModelFromJson(String str) =>
    GetSocketDataModel.fromJson(json.decode(str));

String getSocketDataModelToJson(GetSocketDataModel data) =>
    json.encode(data.toJson());

class GetSocketDataModel {
  String? chatTopicId;
  String? senderId;
  String? receiverId;
  String? senderRole;
  String? receiverRole;
  String? giftId;
  String? giftCount;
  String? giftUrl;
  String? messageId;

  GetSocketDataModel({
    this.chatTopicId,
    this.senderId,
    this.receiverId,
    this.senderRole,
    this.receiverRole,
    this.giftId,
    this.giftCount,
    this.giftUrl,
    this.messageId,
  });

  factory GetSocketDataModel.fromJson(Map<String, dynamic> json) =>
      GetSocketDataModel(
        chatTopicId: json["chatTopicId"],
        senderId: json["senderId"],
        receiverId: json["receiverId"],
        senderRole: json["senderRole"],
        receiverRole: json["receiverRole"],
        giftId: json["giftId"],
        giftCount: json["giftCount"],
        giftUrl: json["giftUrl"],
        messageId: json["messageId"],
      );

  Map<String, dynamic> toJson() => {
        "chatTopicId": chatTopicId,
        "senderId": senderId,
        "receiverId": receiverId,
        "senderRole": senderRole,
        "receiverRole": receiverRole,
        "giftId": giftId,
        "giftCount": giftCount,
        "giftUrl": giftUrl,
        "messageId": messageId,
      };
}
