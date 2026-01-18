import 'dart:async';
import 'dart:developer';

import 'package:LoveBirds/socket/socket_emit.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:proximity_screen_lock/proximity_screen_lock.dart';

class OutGoingCall extends GetxController {
  String? callId;
  String? callerId;
  String? receiverId;
  String? receiverImage;
  String? receiverName;
  String? callType;
  String? callMode;
  String? token;
  String? channel;
  String? gender;
  String? receiverUniqueId;
  String? callerUniqueId;
  String? callerRole;
  String? receiverRole;
  Timer? timer;

  StreamSubscription<bool>? subsProximity;
  bool isProximitySupported = false;
  bool isObjectNear = false;

  @override
  void onInit() async {
    Map<String, dynamic> data = Get.arguments ?? {};

    log("OutGoingCall arguments :: $data");

    callId = data["callId"];
    receiverId = data["receiverId"];
    callerId = data["callerId"];
    receiverName = data["receiverName"];
    receiverImage = data["receiverImage"];
    callType = data["callType"];
    callMode = data["callMode"];
    token = data["token"];
    channel = data["channel"];
    gender = data["gender"];
    callerUniqueId = data["callerUniqueId"];
    receiverUniqueId = data["receiverUniqueId"];
    callerRole = data["callerRole"];
    receiverRole = data["receiverRole"];

    timer = Timer(const Duration(seconds: 30), () {
      onCallCut();
    });

    if (callType == "audio") {
      isProximitySupported =
          await ProximityScreenLock.isProximityLockSupported();
      if (isProximitySupported) {
        await ProximityScreenLock.setActive(true);
        subsProximity =
            ProximityScreenLock.proximityStates.listen((objectDetected) {
          isObjectNear = objectDetected;
          Utils.showLog("Proximity object detected: $isObjectNear");
        });
      }
    }

    FlutterRingtonePlayer().play(
      fromAsset: AppAsset.callingAudio,
      ios: IosSounds.glass,
      looping: true,
      volume: 200,
      asAlarm: false,
    );

    super.onInit();
  }

  @override
  void onClose() {
    log("OutGoingCall Close");

    if (callType == "audio") {
      subsProximity?.cancel();
      ProximityScreenLock.setActive(false);
    }

    FlutterRingtonePlayer().stop();
    timer?.cancel();

    super.onClose();
  }

  void onCallCut() {
    log("callerId :: $callerId");
    log("receiverId :: $receiverId");
    log("callId :: $callId");
    log("senderName :: $receiverImage");
    log("senderImage :: $receiverName");

    SocketEmit.onCallCut(
      callerId: callerId ?? "",
      receiverId: receiverId ?? "",
      callId: callId ?? "",
      callType: callType ?? "",
      callMode: callMode ?? "",
      callerRole: callerRole ?? "",
      receiverRole: receiverRole ?? "",
    );
  }
}
