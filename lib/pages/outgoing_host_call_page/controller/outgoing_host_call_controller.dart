import 'dart:async';

import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class OutgoingHostCallController extends GetxController {
  String hostImage = "";
  String hostName = "";
  String videoUrl = "";
  int agoraUID = 0;
  String channel = "";
  String hostUniqueId = "";
  String hostId = "";
  String gender = "";
  String callId = "";
  String callMode = "";

  Timer? timer;
  Timer? timerVibration;

  @override
  void onInit() {
    Map<String, dynamic> data = Get.arguments ?? {};

    Utils.showLog("IncomingHostCall arguments :: $data");

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

    FlutterRingtonePlayer().play(
      fromAsset: AppAsset.ringtoneAudio,
      ios: IosSounds.glass,
      looping: true,
      volume: 100.0,
      asAlarm: false,
    );

    startVibrationLoop();

    timer = Timer(const Duration(seconds: 30), () {
      Get.back();
      FlutterRingtonePlayer().stop();
      timerVibration?.cancel();
      Vibration.cancel();
    });

    FlutterRingtonePlayer().play(
      fromAsset: AppAsset.ringtoneAudio,
      ios: IosSounds.glass,
      looping: true,
      volume: 100.0,
      asAlarm: false,
    );

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
    timer?.cancel();
    FlutterRingtonePlayer().stop();
    timerVibration?.cancel();
    Vibration.cancel();
    super.onClose();
  }
}
