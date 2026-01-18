import 'dart:convert';

import 'package:LoveBirds/custom/gift_bottom_sheet/gift_bottom_sheet.dart';
import 'package:LoveBirds/pages/chat_page/model/host_send_file_api_model.dart';
import 'package:LoveBirds/pages/host_live_page/controller/host_live_controller.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/socket/socket_listen.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/socket_events.dart';
import 'package:LoveBirds/utils/socket_params.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

io.Socket? socket;

class SocketServices {
  // This is use to When the live user exits the streaming page, the viewing user exits automatically...
  static bool isLiveRunning = false;

  // This is use to live room id
  static String liveRoomHistoryId = "";

  // This is use to live user send comment...
  static RxList mainLiveComments = [].obs;

  // This is use to how many users see the live user...
  static RxInt userWatchCount = 0.obs;

  // This is use to chat between two user...
  static List<Chat> userChats = [];

  // This is use to if get new message/comment then auto scroll down list...
  static ScrollController scrollController = ScrollController();

  // This is use to When the user exits the chat page, the message seen event emit...
  static RxBool isMessageSeenEvent = false.obs;

  static Future<void> onConnect() async {
    Utils.showLog("MY USER ID => ${Database.loginUserId}");

    try {
      socket = io.io(
        Api.baseUrl,
        io.OptionBuilder().setTransports(['websocket']).setQuery({
          "globalRoom":
              "globalRoom:${Database.isHost ? Database.hostId : Database.loginUserId}"
        }).build(),
      );

      socket?.connect();
      userWatchCount.value = 0;

      socket?.onConnect((data) async {
        Utils.showLog("Socket Listen => Socket Connected : ${socket?.id}");
        Utils.showLog(
            "liveHistoryId.isNotEmpty : ${liveRoomHistoryId.isNotEmpty}");

        if (liveRoomHistoryId.isNotEmpty &&
            socket != null &&
            socket!.connected) {
          try {
            Utils.showLog("Attempting to rejoin room: $liveRoomHistoryId");
            await 7.seconds.delay();

            onLiveRoomConnect(liveHistoryId: liveRoomHistoryId);
          } catch (e) {
            Utils.showLog("Error rejoining room: $e");
            Utils.showToast("Error rejoining room: $e");
          }
        }
      });

      socket!.once(
        "connect",
        (data) {
          socket?.on(SocketEvents.messageSent, (data) async {
            Utils.showLog("Socket Listen => Message Sent : $data");
            SocketListen.onMessageSent(data);
          });

          socket?.on(SocketEvents.messageSeen, (data) async {
            Utils.showLog("Socket Listen => Message Sent : $data");
            SocketListen.onMessageSeen(data);
          });

          socket?.on(SocketEvents.chatGiftSent, (data) async {
            Utils.showLog("Socket Listen  => Gift Sent : $data");
            SocketListen.onGiftSent(data);
          });

          socket?.on(SocketEvents.callRinging, (data) async {
            Utils.showLog("Socket Listen  => Call ringing : $data");
            SocketListen.callRinging(data);
          });

          socket?.on(SocketEvents.callConnected, (data) async {
            Utils.showLog("Socket Listen  => Private Call Sent : $data");
            Get.back();
            SocketListen.onPrivateVideoCallSender(data);
          });

          socket?.on(SocketEvents.callIncoming, (data) async {
            Utils.showLog("Socket Listen  => Private Call Received : $data");
            Get.back();
            SocketListen.onPrivateVideoCallReceiver(data);
          });

          socket?.on(SocketEvents.callRejected, (data) async {
            Utils.showLog("Socket Listen  => Private Call Rejected : $data");
            SocketListen.onCallDecline(data);
          });

          socket?.on(SocketEvents.callAnswerReceived, (data) async {
            Utils.showLog(
                "Socket Listen  => Private Call AnswerReceived : $data");

            SocketListen.onAcceptCall(data);
          });

          socket?.on(SocketEvents.callFinished, (data) async {
            Utils.showLog("Socket Listen  => Private Call Finished : $data");
            SocketListen.onCallFinished(data);
          });

          socket?.on(SocketEvents.callDisconnected, (data) async {
            Utils.showLog(
                "Socket Listen  => Private Call Disconnected : $data");
            SocketListen.onCallDisconnected(data);
          });

          socket?.on(SocketEvents.insufficientCoins, (data) async {
            Utils.showLog("Socket Listen  => Call Coin Cut : $data");
            SocketListen.onInsufficientCoins(data);
          });

          socket?.on(SocketEvents.ringingStarted, (data) async {
            Utils.showLog("Socket Listen  => Call Ringing Started : $data");
            SocketListen.onCallRingingStarted(data);
          });

          socket?.on(SocketEvents.callAutoEnded, (data) async {
            Utils.showLog("Socket Listen  => Call Auto Ended : $data");
            SocketListen.onCallAutoEnded(data);
          });

          //================ For Live Streaming ================//

          socket!.on(SocketEvents.liveRoomJoin, (liveRoomConnectData) {
            Utils.showLog(
                "Socket Listen => Live Room Connect : $liveRoomConnectData");

            final data = jsonDecode(liveRoomConnectData);
            liveRoomHistoryId = data["liveHistoryId"];
            Utils.showLog("liveRoomHistoryId : $liveRoomHistoryId");
          });

          socket!.on(SocketEvents.liveJoinerCount, (liveJoinerCountData) {
            userWatchCount.value = liveJoinerCountData;
            Utils.showLog(
                "Socket Listen => Live Room Add : $liveJoinerCountData");
          });

          socket!.on(SocketEvents.removeLiveJoiner, (lessView) {
            userWatchCount.value = lessView;
            Utils.showLog("Socket Listen => Less View : $lessView");
          });

          socket!.on(SocketEvents.liveStreamEnd, (endLive) {
            userWatchCount.value = 0;
            Utils.showLog("Socket Listen => Live Room Disconnect : $endLive");
            if (isLiveRunning) {
              isLiveRunning = false;
              Get.back();
            }
          });

          socket!.on(SocketEvents.liveStreamStatusCheck,
              (liveStreamStatusCheckData) {
            Utils.showLog(
                "Socket Listen => Live Stream Status Check :: $liveStreamStatusCheckData");

            if (Get.currentRoute == AppRoutes.hostLivePage) {
              final controller = Get.find<HostLiveController>();
              Utils.showLog(
                  "controller.liveStatus :: ${controller.liveStatus}");

              controller.liveStatus = liveStreamStatusCheckData["liveStatus"];
              Utils.showLog("Live Status :: ${controller.liveStatus}");
            }
          });

          socket!.on(
            SocketEvents.liveCommentBroadcast,
            (liveChat) async {
              Utils.showLog("Socket Listen => Add New Comment : $liveChat");
              final Map response = jsonDecode(liveChat);
              onGetNewComment(message: response);
            },
          );

          socket!.on(
            SocketEvents.liveGiftReceived,
            (gift) async {
              Utils.showLog("Socket Listen => Add New Gift : $gift");

              onGetNewGift(gift: gift);
            },
          );
        },
      );

      socket?.onDisconnect((data) {
        Utils.showLog("Socket Listen => Socket Disconnected.");
      });

      socket?.on(SocketEvents.error, (data) {
        Utils.showLog("Socket Listen => Socket Error : $data");
      });

      socket?.on(SocketEvents.connectError, (data) {
        Utils.showLog("Socket Listen => Socket Connection Error : $data");
      });
    } catch (e) {
      Utils.showLog("Socket Listen => Socket Connection Error: $e");
    }
  }

  static Future<void> disconnectSocket() async {
    if (socket != null && socket!.connected) {
      socket?.disconnect();
      Utils.showLog("Socket Manually Disconnected.");
    } else {
      Utils.showLog("Socket already disconnected or not initialized.");
    }
  }

  //=================== Socket Emit Method ===================//

  static Future<void> onLiveRoomConnect({required String liveHistoryId}) async {
    final liveRoomConnectData =
        jsonEncode({SocketParams.liveHistoryId: liveHistoryId});

    if (socket != null && socket!.connected) {
      socket?.emit(SocketEvents.liveRoomJoin, liveRoomConnectData);
      Utils.showLog(
          "Socket Emit => Live Room Connected :: $liveRoomConnectData");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onLiveRoomExit(
      {required String liveHistoryId,
      required bool isHost,
      required String hostId}) async {
    if (isHost) {
      final endLive = jsonEncode({
        SocketParams.liveHistoryId: liveHistoryId,
        SocketParams.hostId: hostId,
      });
      Utils.showLog("Socket Emit => Live Room Disconnected. :: $endLive");

      if (socket != null && socket!.connected) {
        socket?.emit(SocketEvents.liveStreamEnd, endLive);
        Utils.showLog("Socket Emit => Live Room Disconnected.");
      } else {
        Utils.showLog("Socket Not Connected !!");
      }
    } else {
      onLessView(userId: Database.loginUserId, liveHistoryId: liveHistoryId);
    }
  }

  static Future<void> onAddView(
      {required String userId, required String liveHistoryId}) async {
    isLiveRunning = true;

    final liveJoinerCount = jsonEncode({
      SocketParams.userId: userId,
      SocketParams.liveHistoryId: liveHistoryId
    });

    if (socket != null && socket!.connected) {
      Utils.showLog(
          "Socket Emit userWatchCount.value :: ${userWatchCount.value}");

      socket?.emit(SocketEvents.liveJoinerCount, liveJoinerCount);
      Utils.showLog(
          "Socket Emit => New User Join Live Room :: $liveJoinerCount");

      liveRoomHistoryId = liveHistoryId;
      Utils.showLog("liveRoomHistoryId : $liveRoomHistoryId");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onLessView(
      {required String userId, required String liveHistoryId}) async {
    final removeLiveJoiner = jsonEncode({
      SocketParams.userId: userId,
      SocketParams.liveHistoryId: liveHistoryId
    });
    Utils.showLog("Socket Emit => User Exit Live Room :: $removeLiveJoiner");

    if (socket != null && socket!.connected) {
      socket?.emit(SocketEvents.removeLiveJoiner, removeLiveJoiner);
      Utils.showLog("Socket Emit => User Exit Live Room");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onLiveRoomReJoin({required String liveHistoryId}) async {
    final liveRoomReJoinConnectData =
        jsonEncode({SocketParams.liveHistoryId: liveHistoryId});

    if (socket != null && socket!.connected) {
      socket?.emit(SocketEvents.liveRoomJoin, liveRoomReJoinConnectData);
      Utils.showLog(
          "Socket Emit => Live Room Re-join Connected :: $liveRoomReJoinConnectData");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onLiveStreamStatusCheck(
      {required String hostId, required String liveHistoryId}) async {
    final liveStreamStatusCheck = jsonEncode({
      SocketParams.liveHistoryId: liveHistoryId,
      SocketParams.hostId: hostId
    });

    if (socket != null && socket!.connected) {
      socket?.emit(SocketEvents.liveStreamStatusCheck, liveStreamStatusCheck);
      Utils.showLog(
          "Socket Emit => Live Stream Status Check :: $liveStreamStatusCheck");

      liveRoomHistoryId = liveHistoryId;
      Utils.showLog("liveRoomHistoryId : $liveRoomHistoryId");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onComment({
    required String liveHistoryId,
    required String loginUserId,
    required String userName,
    required String userImage,
    required String commentText,
    required String hostId,
  }) async {
    final liveComment = jsonEncode(
      {
        SocketParams.liveHistoryId: liveHistoryId,
        SocketParams.userId: loginUserId,
        SocketParams.userName: userName,
        SocketParams.userImage: userImage,
        SocketParams.commentText: commentText,
        SocketParams.hostId: hostId,
      },
    );

    if (socket != null && socket!.connected) {
      socket!.emit(SocketEvents.liveCommentBroadcast, liveComment);
      Utils.showLog("Socket Emit => User Add New Comment");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onLiveSendGift({
    required String liveHistoryId,
    required String senderUserId,
    required String receiverUserId,
    required String giftId,
    required int giftCount,
    required String giftUrl,
    required int giftType,
    required String callerName,
    String? svgaThumbUrl,
    String? giftImage,
  }) async {
    final gift = jsonEncode(
      {
        SocketParams.liveHistoryId: liveHistoryId,
        SocketParams.senderId: senderUserId,
        SocketParams.receiverId: receiverUserId,
        SocketParams.giftId: giftId,
        SocketParams.giftCount: giftCount,
        SocketParams.giftUrl: giftUrl,
        SocketParams.giftType: giftType,
        SocketParams.callerName: callerName,
        SocketParams.svgaThumbUrl: svgaThumbUrl,
        SocketParams.giftImage: svgaThumbUrl,
      },
    );

    if (socket != null && socket!.connected) {
      socket!.emit(SocketEvents.liveGiftSent, gift);
      Utils.showLog("Socket Emit => User Send Gift :: $gift");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onGetNewComment({required Map message}) async {
    mainLiveComments.insert(0, message);
    await onScrollDown();
  }

  static Future<void> onScrollDown() async {
    try {
      await 10.milliseconds.delay();
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
      await 10.milliseconds.delay();
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    } catch (e) {
      Utils.showLog("Scroll Down Failed => $e");
    }
  }

  static Future<void> onGetNewGift({required Map gift}) async {
    GiftBottomSheetWidget.giftUrl = Api.baseUrl + gift["giftUrl"];
    GiftBottomSheetWidget.giftType = gift["giftType"];
    GiftBottomSheetWidget.senderName = gift["callerName"];
    GiftBottomSheetWidget.giftsvgaImage = gift["svgaThumbUrl"];

    GiftBottomSheetWidget.isShowGift.value = true;
    GiftBottomSheetWidget.giftType == 3
        ? await 10000.milliseconds.delay()
        : await 3000.milliseconds.delay();
    GiftBottomSheetWidget.isShowGift.value = false;
  }
}
