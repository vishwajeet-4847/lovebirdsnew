import 'dart:async';
import 'dart:developer';

import 'package:LoveBirds/utils/asset.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class IncomingAudioCallController extends GetxController {
  String? callerId;
  String? receiverId;
  String? callId;
  String? senderName;
  String? senderImage;
  String? receiverName;
  String? receiverImage;
  String? callType;
  String? callMode;
  String? token;
  String? channel;
  String? gender;
  String? receiverUniqueId;
  String? callerUniqueId;
  String? callerRole;
  String? receiverRole;

  Timer? timerVibration;

  @override
  void onInit() {
    Map<String, dynamic> data = Get.arguments ?? {};

    log("OutGoingCall arguments :: $data");

    callerId = data['callerId'];
    receiverId = data['receiverId'];
    callId = data['callId'];
    senderName = data['senderName'];
    senderImage = data['senderImage'];
    receiverName = data['receiverName'];
    receiverImage = data['receiverImage'];
    callType = data['callType'];
    callMode = data['callMode'];
    token = data['token'];
    channel = data['channel'];
    gender = data['gender'];
    callerUniqueId = data["callerUniqueId"];
    receiverUniqueId = data["receiverUniqueId"];
    callerRole = data["callerRole"];
    receiverRole = data["receiverRole"];

    FlutterRingtonePlayer().play(
      fromAsset: AppAsset.ringtoneAudio,
      ios: IosSounds.glass,
      looping: true,
      volume: 100.0,
      asAlarm: false,
    );

    startVibrationLoop();

    super.onInit();
  }

  void startVibrationLoop() async {
    if (await Vibration.hasVibrator()) {
      timerVibration = Timer.periodic(const Duration(seconds: 1), (timer) {
        Vibration.vibrate(duration: 500);
      });
    }
  }

  @override
  void onClose() {
    FlutterRingtonePlayer().stop();
    timerVibration?.cancel();
    Vibration.cancel();
    super.dispose();
  }
}
