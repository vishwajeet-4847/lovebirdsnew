import 'dart:convert';
import 'dart:developer';

GetCallModel getCallModelFromJson(String str) =>
    GetCallModel.fromJson(json.decode(str));

String getCallModelToJson(GetCallModel data) => json.encode(data.toJson());

class GetCallModel {
  String? callType;
  String? callerId;
  String? receiverId;
  String? callerImage;
  String? callerName;
  String? receiverName;
  String? receiverImage;
  String? callId;
  String? callMode;
  String? token;
  String? channel;

  GetCallModel({
    this.callType,
    this.callerId,
    this.receiverId,
    this.callerImage,
    this.callerName,
    this.receiverName,
    this.receiverImage,
    this.callId,
    this.callMode,
    this.token,
    this.channel,
  });

  factory GetCallModel.fromJson(Map<String, dynamic> json) {
    log("JsonData=>${json.toString()}");
    return GetCallModel(
      callType: json["callType"],
      callerId: json["callerId"],
      receiverId: json["receiverId"],
      callerImage: json["callerImage"],
      callerName: json["callerName"],
      receiverName: json["receiverName"],
      receiverImage: json["receiverImage"],
      callId: json["callId"],
      callMode: json["callMode"],
      token: json["token"],
      channel: json["channel"],
    );
  }

  Map<String, dynamic> toJson() => {
        "callType": callType,
        "callerId": callerId,
        "receiverId": receiverId,
        "callerImage": callerImage,
        "callerName": callerName,
        "receiverName": receiverName,
        "receiverImage": receiverImage,
        "callId": callId,
        "callMode": callMode,
        "token": token,
        "channel": channel,
      };
}
