import 'dart:convert';

import 'package:LoveBirds/pages/chat_page/controller/chat_controller.dart';
import 'package:LoveBirds/pages/video_call_page/controller/video_call_controller.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/socket/socket_services.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/socket_params.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:get/get.dart';

class SocketListen {
  static Future<void> onMessageSent(dynamic data) async {
    try {
      if (data == null || data[SocketParams.data] == null) {
        return;
      }

      Map<String, dynamic> response = jsonDecode(data[SocketParams.data]);
      Utils.showLog("SocketListen response => $response");

      if (Get.currentRoute == AppRoutes.chatPage) {
        Utils.showLog("SocketListen response===================");
        final controller = Get.find<ChatController>();

        controller.onMessageReceived(response);

        if (Database.isHost) {
          if (response["senderId"] == Database.hostId) {
            SocketServices.isMessageSeenEvent.value = false;
          } else {
            SocketServices.isMessageSeenEvent.value = true;
          }
        } else {
          if (response["senderId"] == Database.loginUserId) {
            SocketServices.isMessageSeenEvent.value = false;
          } else {
            SocketServices.isMessageSeenEvent.value = true;
          }
        }
      }
    } catch (e) {
      Utils.showLog("Error in onMessageSent: $e");
    }
  }

  static Future<void> onMessageSeen(dynamic data) async {
    try {
      if (data == null || data[SocketParams.data] == null) {
        return; // Exit if data is null to avoid errors
      }

      Map<String, dynamic> response = jsonDecode(data[SocketParams.data]);
      Utils.showLog("SocketListen response message Seen => $response");

      if (Get.currentRoute == AppRoutes.chatPage &&
          Get.isRegistered<ChatController>()) {
        final controller = Get.find<ChatController>();

        controller.onMessageSeen(response);
      }
    } catch (e) {
      Utils.showLog("Error in onMessage Seen: $e"); // Log error for debugging
    }
  }

  static Future<void> onGiftSent(dynamic data) async {
    Utils.showLog("Data=>$data");
    try {
      if (data == null || data[SocketParams.data] == null) {
        return; // Exit if data is null to avoid errors
      }

      Map<String, dynamic> response = jsonDecode(data[SocketParams.data]);
      Utils.showLog("Gift Received => $response");

      response.putIfAbsent(
          SocketParams.messageId, () => data[SocketParams.messageId] ?? "");

      if (Get.currentRoute == AppRoutes.chatPage &&
          Get.isRegistered<ChatController>()) {
        final controller = Get.find<ChatController>();
        Utils.showLog("response => $response");
        controller.onGiftReceive(response);
      }
    } catch (e) {
      Utils.showLog("Error in onGiftSent: $e");
    }
  }

  static Future<void> onPrivateVideoCallSender(dynamic data) async {
    try {
      if (data == null) {
        return;
      }

      Utils.showLog("onPrivateVideoCallSender data :: $data");
      Get.toNamed(AppRoutes.outGoingAudioCallPage, arguments: {
        "callId": data["callId"] ?? "",
        "receiverId": data["receiverId"] ?? "",
        "callerId": data["callerId"] ?? "",
        "receiverName": data["receiverName"] ?? "",
        "receiverImage": data["receiverImage"] ?? "",
        "callType": data["callType"] ?? "",
        "callMode": data["callMode"] ?? "",
        "token": data["token"] ?? "",
        "channel": data["channel"] ?? "",
        "gender": data["gender"] ?? "",
        "callerUniqueId": data["callerUniqueId"] ?? "",
        "receiverUniqueId": data["receiverUniqueId"] ?? "",
        "callerRole": data["callerRole"] ?? "",
        "receiverRole": data["receiverRole"] ?? "",
      });
    } catch (e) {
      Utils.showLog("Error in Private Video Call Sender: $e");
    }
  }

  static Future<void> onPrivateVideoCallReceiver(dynamic data) async {
    Utils.showLog("Data=>$data");
    try {
      if (data == null) {
        return; // Exit if data is null to avoid errors
      }

      Utils.showLog("onPrivateVideoCallReceiver data :: $data");
      Get.toNamed(AppRoutes.incomingAudioCallPage, arguments: {
        "callerId": data['callerId'],
        "receiverId": data['receiverId'],
        "callId": data['callId'],
        "senderName": data['callerName'],
        "senderImage": data['callerImage'],
        "receiverName": data['receiverName'],
        "receiverImage": data['receiverImage'],
        "callType": data['callType'],
        "callMode": data['callMode'],
        "token": data['token'],
        "channel": data['channel'],
        "gender": data['gender'],
        "callerUniqueId": data["callerUniqueId"] ?? "",
        "receiverUniqueId": data["receiverUniqueId"] ?? "",
        "callerRole": data["callerRole"] ?? "",
        "receiverRole": data["receiverRole"] ?? "",
      });
    } catch (e) {
      Utils.showLog("Error in onGiftSent: $e");
    }
  }

  static Future<void> callRinging(dynamic data) async {
    Utils.showLog("On callRinging=========================== :: $data");
    Utils.showToast(data["message"]);
  }

  static Future<void> onCallDecline(dynamic data) async {
    try {
      if (data == null) {
        return; // Exit if data is null to avoid errors
      }

      Utils.showLog("onCallDecline data :: $data");
      Get.back();
    } catch (e) {
      Utils.showLog("Error in onDeclineCall : $e"); // Log error for debugging
    }
  }

  static Future<void> onAcceptCall(dynamic data) async {
    try {
      if (data == null) {
        return; // Exit if data is null to avoid errors
      }

      Utils.showLog("onAcceptCall data :: $data");
      final data1 = jsonDecode(data);
      Utils.showLog("onAcceptCall data1 :: $data1");
      Utils.showLog("onAcceptCall data1 :: ${data1['isAccept']}");

      if (data1["isAccept"] == true) {
        // Get.back();

        Get.offNamed(
          AppRoutes.videoCallPage,
          arguments: {
            "callId": data1['callId'] ?? "",
            "receiverId": data1['receiverId'] ?? "",
            "callerId": data1['callerId'] ?? "",
            "callType": data1['callType'] ?? "",
            "receiverName": data1['receiverName'] ?? "",
            "receiverImage": data1['receiverImage'] ?? "",
            "callerName": data1['callerName'] ?? "",
            "callerImage": data1['callerImage'] ?? "",
            "callMode": data1['callMode'] ?? "",
            "token": data1['token'] ?? "",
            "channel": data1['channel'] ?? "",
            "gender": data1['gender'] ?? "",
            "callerUniqueId": data1['callerUniqueId'] ?? "",
            "receiverUniqueId": data1['receiverUniqueId'] ?? "",
            "callerRole": data1["callerRole"] ?? "",
            "receiverRole": data1["receiverRole"] ?? "",
          },
        )?.then(
          (value) {
            Utils.showLog("Current Routes is :: ${Get.currentRoute}");
          },
        );
      }
    } catch (e) {
      Utils.showLog("Error in onAcceptCall: $e"); // Log error for debugging
    }
  }

  static Future<void> onCallFinished(dynamic data) async {
    try {
      if (data == null) {
        return; // Exit if data is null to avoid errors
      }

      Utils.showLog("onCallFinished data :: $data");
      Get.back();
    } catch (e) {
      Utils.showLog("Error in onCallFinished: $e"); // Log error for debugging
    }
  }

  static Future<void> onCallDisconnected(dynamic data) async {
    try {
      if (data == null) {
        return; // Exit if data is null to avoid errors
      }

      Map<String, dynamic> response = jsonDecode(data);
      Utils.showLog("SocketListen response onCallDisconnected => $response");

      final controller = Get.find<VideoCallController>();

      controller.callDisconnected(response);
    } catch (e) {
      Utils.showLog(
          "Error in onCallDisconnected: $e"); // Log error for debugging
    }
  }

  static Future<void> onInsufficientCoins(dynamic data) async {
    try {
      if (data == null) {
        return;
      }

      Utils.showToast(data);

      if (AppRoutes.videoCallPage == Get.currentRoute) {
        Utils.showLog("Get.currentRoute :: ${Get.currentRoute}");
        final controller = Get.find<VideoCallController>();
        controller.onCallDisconnected();
      }
    } catch (e) {
      Utils.showLog("Error in onCall Coin Cut: $e");
    }
  }

  static Future<void> onCallRingingStarted(dynamic data) async {
    if (data == null) {
      return;
    }

    Utils.showLog("CallRingingStarted data :: $data");

    // Check if data is already a Map, if not then try to decode it
    final data1 = data is Map ? data : jsonDecode(data);

    Utils.showLog("CallRingingStarted data1 :: $data1");
    Utils.showLog("CallRingingStarted data1 :: ${data1['isBusy']}");

    if (data1['isBusy'] == true) {
      Utils.showToast(data1["message"]);
    }
  }

  static Future<void> onCallAutoEnded(dynamic data) async {
    Utils.showLog("On call auto ended===============");
  }
}
