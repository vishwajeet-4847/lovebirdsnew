import 'dart:async';
import 'dart:developer';

import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:proximity_screen_lock/proximity_screen_lock.dart';

class IncomingHostCallController extends GetxController {
  String hostName = "";
  String hostImage = "";
  String videoUrl = "";
  int agoraUID = 0;
  String channel = "";
  String hostUniqueId = "";
  String hostId = "";
  String gender = "";
  String callId = "";
  String callMode = "";
  bool isBackProfile = false;
  String callType = "";

  Timer? timer;

  StreamSubscription<bool>? subsProximity;
  bool isProximitySupported = false;
  bool isObjectNear = false;

  @override
  void onInit() async {
    Map<String, dynamic> data = Get.arguments ?? {};

    log("IncomingHostCall arguments :: $data");

    hostName = data['hostName'];
    hostImage = data['hostImage'];
    videoUrl = data['videoUrl'];
    agoraUID = data['agoraUID'];
    channel = data['channel'];
    hostUniqueId = data['hostUniqueId'];
    hostId = data['hostId'];
    gender = data['gender'];
    callId = data['callId'];
    callMode = data['callMode'];
    isBackProfile = data['isBackProfile'];
    callType = data['callType'];

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

    timer = Timer(const Duration(seconds: 5), () {
      if (callType == "audio") {
        Get.back();
        Get.toNamed(AppRoutes.audioPlayerPage, arguments: {
          "hostName": hostName,
          "hostImage": hostImage,
          "hostId": hostId,
          "gender": gender,
          "callId": callId,
          "callMode": callMode,
          "isBackProfile": isBackProfile,
        });
      } else {
        Get.back();
        Get.toNamed(AppRoutes.hostVideoCall, arguments: {
          "hostName": hostName,
          "hostImage": hostImage,
          "videoUrl": videoUrl,
          "agoraUID": agoraUID,
          "channel": channel,
          "hostUniqueId": hostUniqueId,
          "hostId": hostId,
          "gender": gender,
          "callId": callId,
          "callMode": callMode,
          "isBackProfile": isBackProfile,
        });
      }
    });

    FlutterRingtonePlayer().play(
      fromAsset: AppAsset.callingAudio,
      ios: IosSounds.glass,
      looping: true,
      volume: 100.0,
      asAlarm: false,
    );

    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();
    FlutterRingtonePlayer().stop();

    if (callType == "audio") {
      subsProximity?.cancel();
      ProximityScreenLock.setActive(false);
    }

    super.onClose();
  }
}
