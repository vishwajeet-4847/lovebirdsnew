import 'dart:convert';

import 'package:LoveBirds/socket/socket_services.dart';
import 'package:LoveBirds/utils/socket_events.dart';
import 'package:LoveBirds/utils/socket_params.dart';
import 'package:LoveBirds/utils/utils.dart';

class SocketEmit {
  static Future<void> onSendMessage({
    required String chatTopicId,
    required String senderId,
    required String receiverId,
    required String message,
    required int messageType,
    required String senderRole,
    required String receiverRole,
    required String date,
    String? messageId,
  }) async {
    final data = jsonEncode({
      SocketParams.chatTopicId: chatTopicId,
      SocketParams.senderId: senderId,
      SocketParams.receiverId: receiverId,
      SocketParams.message: message,
      SocketParams.messageType: messageType,
      SocketParams.senderRole: senderRole,
      SocketParams.receiverRole: receiverRole,
      SocketParams.date: date,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.messageSent, data);
      Utils.showLog("Socket Emit => Message Sent: $data");
    } else {
      Utils.showLog("Socket Not Connected!!");
    }
  }

  static Future<void> onMessageSeen({required String messageId}) async {
    final data = jsonEncode({SocketParams.messageId: messageId});

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.messageSeen, data);
      Utils.showLog("Socket Emit => Message Seen: $messageId");
    } else {
      Utils.showLog("Socket Not Connected!!");
    }
  }

  static Future<void> onSendGift({
    required String chatTopicId,
    required String senderId,
    required String receiverId,
    required String senderRole,
    required String receiverRole,
    required String giftId,
    required String giftCount,
    required String giftUrl,
    required String giftsvgaImage,
    required String giftImage,
    required int giftType,
  }) async {
    final data = jsonEncode({
      SocketParams.chatTopicId: chatTopicId,
      SocketParams.senderId: senderId,
      SocketParams.receiverId: receiverId,
      SocketParams.senderRole: senderRole,
      SocketParams.receiverRole: receiverRole,
      SocketParams.giftId: giftId,
      SocketParams.giftCount: giftCount,
      SocketParams.giftUrl: giftUrl,
      SocketParams.giftType: giftType,
      SocketParams.giftsvgaImage: giftsvgaImage,
      SocketParams.giftImage: giftsvgaImage
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.chatGiftSent, data);
      Utils.showLog("Socket Emit => Gift Sent: $data");
    } else {
      Utils.showLog("Socket Not Connected!!");
    }
  }

  static Future<void> onSendGiftVideoCall({
    required String callId,
    required String senderId,
    required String receiverId,
    required String senderRole,
    required String receiverRole,
    required String giftId,
    required String giftCount,
    required String giftUrl,
    required String giftsvgaImage,
    required String giftImage,
    required int giftType,
  }) async {
    final data = jsonEncode({
      SocketParams.callId: callId,
      SocketParams.senderId: senderId,
      SocketParams.receiverId: receiverId,
      SocketParams.senderRole: senderRole,
      SocketParams.receiverRole: receiverRole,
      SocketParams.giftId: giftId,
      SocketParams.giftCount: giftCount,
      SocketParams.giftUrl: giftUrl,
      SocketParams.giftType: giftType,
      SocketParams.giftsvgaImage: giftsvgaImage,
      SocketParams.giftImage: giftsvgaImage
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.videoGiftSent, data);
      Utils.showLog("Socket Emit => Gift Sent: $data");
    } else {
      Utils.showLog("Socket Not Connected!!");
    }
  }

  static Future<void> onRequestGiftVideoCall({
    required String callId,
    required String senderId,
    required String receiverId,
    required String senderRole,
    required String receiverRole,
    required String giftId,
    required String giftCount,
    required String giftUrl,
    required String giftsvgaImage,
    required String giftImage,
    required int giftType,
  }) async {
    final data = jsonEncode({
      SocketParams.callId: callId,
      SocketParams.senderId: senderId,
      SocketParams.receiverId: receiverId,
      SocketParams.senderRole: senderRole,
      SocketParams.receiverRole: receiverRole,
      SocketParams.giftId: giftId,
      SocketParams.giftCount: giftCount,
      SocketParams.giftUrl: giftUrl,
      SocketParams.giftType: giftType,
      SocketParams.giftsvgaImage: giftsvgaImage,
      SocketParams.giftImage: giftsvgaImage
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.requestGiftVideoCall, data);
      Utils.showLog("Socket Emit => Gift Sent: $data");
    } else {
      Utils.showLog("Socket Not Connected!!");
    }
  }

  static Future<void> onSendPrivateCall({
    required String callerId,
    required String receiverId,
    required int agoraUID,
    required String channel,
    required String callType,
    required String receiverName,
    required String receiverImage,
    required String senderName,
    required String senderImage,
    required String callerRole,
    required String receiverRole,
  }) async {
    if (socket != null && socket?.connected == true) {
      final data = jsonEncode({
        SocketParams.callerId: callerId,
        SocketParams.receiverId: receiverId,
        SocketParams.agoraUID: agoraUID,
        SocketParams.channel: channel,
        SocketParams.callType: callType,
        SocketParams.receiverName: receiverName,
        SocketParams.receiverImage: receiverImage,
        SocketParams.callerName: senderName,
        SocketParams.callerImage: senderImage,
        SocketParams.gender: "",
        SocketParams.callerRole: callerRole,
        SocketParams.receiverRole: receiverRole,
      });

      socket?.emit(SocketEvents.callRinging, data);
      Utils.showLog("Socket Emit => Private Call Sent: $data");
    } else {
      Utils.showLog("Socket Not Connected!!");
    }
  }

  static Future<void> onCallAcceptOrDecline({
    required String callerId,
    required String receiverId,
    required String callId,
    required bool isAccept,
    required String callType,
    required String callMode,
    required String receiverName,
    required String receiverImage,
    required String senderName,
    required String senderImage,
    required String token,
    required String channel,
    required String gender,
    required String callerUniqueId,
    required String receiverUniqueId,
    required String callerRole,
    required String receiverRole,
  }) async {
    final data = jsonEncode({
      SocketParams.callerId: callerId,
      SocketParams.receiverId: receiverId,
      SocketParams.callId: callId,
      SocketParams.isAccept: isAccept,
      SocketParams.callType: callType,
      SocketParams.callMode: callMode,
      SocketParams.receiverName: receiverName,
      SocketParams.receiverImage: receiverImage,
      SocketParams.callerName: senderName,
      SocketParams.callerImage: senderImage,
      SocketParams.token: token,
      SocketParams.channel: channel,
      SocketParams.gender: gender,
      SocketParams.callerUniqueId: callerUniqueId,
      SocketParams.receiverUniqueId: receiverUniqueId,
      SocketParams.callerRole: callerRole,
      SocketParams.receiverRole: receiverRole,
    });
    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.callResponseHandled, data);
      Utils.showLog("Socket Emit => CallAcceptOrDecline: $data");
    } else {
      Utils.showLog("Socket Not Connected!!");
    }
  }

  static Future<void> onCallCut({
    required String callerId,
    required String receiverId,
    required String callId,
    required String callType,
    required String callMode,
    required String callerRole,
    required String receiverRole,
  }) async {
    final data = jsonEncode({
      SocketParams.callerId: callerId,
      SocketParams.receiverId: receiverId,
      SocketParams.callId: callId,
      SocketParams.callType: callType,
      SocketParams.callMode: callMode,
      SocketParams.callerRole: callerRole,
      SocketParams.receiverRole: receiverRole,
    });
    if (socket != null && socket?.connected == true) {
      Utils.showLog("Socket Emit => CallCut :: $data");
      socket?.emit(SocketEvents.callCancelled, data);
    } else {
      Utils.showLog("Socket Not Connected!!");
    }
  }

  static Future<void> onCallDisconnected({
    required String callerId,
    required String receiverId,
    required String callId,
    required String callType,
    required String callMode,
    required String callerRole,
    required String receiverRole,
  }) async {
    final data = jsonEncode({
      SocketParams.callerId: callerId,
      SocketParams.receiverId: receiverId,
      SocketParams.callId: callId,
      SocketParams.callType: callType,
      SocketParams.callMode: callMode,
      SocketParams.callerRole: callerRole,
      SocketParams.receiverRole: receiverRole,
    });
    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.callDisconnected, data);
      Utils.showLog("Socket Emit => CallCut: $data");
    } else {
      Utils.showLog("Socket Not Connected!!");
    }
  }

  static Future<void> onCallCoinCut({
    required String callerId,
    required String receiverId,
    required String callId,
    required String callType,
    required String callMode,
    required String gender,
  }) async {
    final data = jsonEncode({
      SocketParams.callerId: callerId,
      SocketParams.receiverId: receiverId,
      SocketParams.callId: callId,
      SocketParams.callType: callType,
      SocketParams.callMode: callMode,
      if (callMode == 'random') SocketParams.gender: gender,
    });
    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.callCoinCharged, data);
      Utils.showLog("Socket Emit => Coin Cut: $data");
    } else {
      Utils.showLog("Socket Not Connected!!");
    }
  }

  static Future<void> onCoinCutForFakeCall({
    required String callerId,
    required String receiverId,
    required String callType,
    required String callMode,
    required String gender,
  }) async {
    final data = jsonEncode({
      SocketParams.callerId: callerId,
      SocketParams.receiverId: receiverId,
      SocketParams.callType: callType,
      SocketParams.callMode: callMode,
      if (callMode == 'random') SocketParams.gender: gender,
    });
    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.callCoinChargedForFakeCall, data);
      Utils.showLog("Socket Emit => Coin Cut Fake Call : $data");
    } else {
      Utils.showLog("Socket Not Connected!!");
    }
  }

  static Future<void> onCallRingingStarted({
    required String callerId,
    required String receiverId,
    required int agoraUID,
    required String channel,
    required String gender,
    required String callerRole,
    required String receiverRole,
  }) async {
    final data = jsonEncode({
      SocketParams.callerId: callerId,
      SocketParams.receiverId: receiverId,
      SocketParams.agoraUID: agoraUID,
      SocketParams.channel: channel,
      SocketParams.gender: gender,
      SocketParams.callerRole: callerRole,
      SocketParams.receiverRole: receiverRole,
    });
    if (socket != null && socket?.connected == true) {
      Utils.showLog("Socket Emit => Call ringing started :: $data");
      socket?.emit(SocketEvents.ringingStarted, data);
    } else {
      Utils.showLog("Socket Not Connected!!");
    }
  }
}
