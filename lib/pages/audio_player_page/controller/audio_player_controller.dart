import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/utils.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proximity_screen_lock/proximity_screen_lock.dart';

class AudioPlayerController extends GetxController {
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
  String audio = "";

  Timer? timer;
  DateTime? startTime;
  DateTime? endTime;
  Duration? duration;
  int? minutes;
  int? seconds;
  String? finalDuration;
  String? formattedTime;

  bool isMute = false;
  bool isSpeakerOn = false;

  late AudioPlayer _audioPlayer;

  StreamSubscription<bool>? subsProximity;
  bool isProximitySupported = false;
  bool isObjectNear = false;

  @override
  void onInit() async {
    Map<String, dynamic> data = Get.arguments ?? {};

    hostName = data['hostName'];
    hostImage = data['hostImage'];
    hostId = data['hostId'];
    gender = data['gender'];
    callId = data['callId'];
    callMode = data['callMode'];
    isBackProfile = data['isBackProfile'];

    _audioPlayer = AudioPlayer();

    onRequestPermissions();

    playAudio();
    startTimer();

    await 2.seconds.delay();
    isProximitySupported = await ProximityScreenLock.isProximityLockSupported();
    if (isProximitySupported) {
      await ProximityScreenLock.setActive(true);
      subsProximity = ProximityScreenLock.proximityStates.listen((objectDetected) {
        isObjectNear = objectDetected;
        Utils.showLog("Proximity object detected: $isObjectNear");
      });
    }

    super.onInit();
  }

  Future<void> playAudio() async {
    try {
      final List<String> assetAudioList = [
        AppAsset.audio1,
        AppAsset.audio2,
        AppAsset.audio3,
        AppAsset.audio4,
      ];

      final random = Random();
      final fullAssetPath = assetAudioList[random.nextInt(assetAudioList.length)];
      final assetPath = fullAssetPath.replaceFirst('assets/', '');

      Utils.showLog("Attempting to play: $assetPath");
      Utils.showLog("Full path was: $fullAssetPath");

      await _audioPlayer.setAudioContext(AudioContext(
        android: const AudioContextAndroid(
          isSpeakerphoneOn: false,
          stayAwake: true,
          contentType: AndroidContentType.speech,
          usageType: AndroidUsageType.voiceCommunication,
          audioFocus: AndroidAudioFocus.gain,
        ),
        iOS: AudioContextIOS(
          category: AVAudioSessionCategory.playAndRecord,
          options: const {AVAudioSessionOptions.defaultToSpeaker},
        ),
      ));

      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.setVolume(isMute ? 0.0 : 100.0);

      _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
        Utils.showLog("Audio player state changed: $state");
      });

      await _audioPlayer.play(AssetSource(assetPath));

      Utils.showLog("Audio play command executed successfully");
    } catch (e) {
      Utils.showLog("Audio play error: $e");
    }
  }

  @override
  void onClose() {
    stopTimer();
    _audioPlayer.stop();
    _audioPlayer.dispose();

    subsProximity?.cancel();
    ProximityScreenLock.setActive(false);

    super.onClose();
  }

  Future<void> onRequestPermissions() async {
    await Permission.microphone.request();
  }

  void startTimer() {
    startTime = DateTime.now();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final duration = DateTime.now().difference(startTime ?? DateTime.now());
      final minutes = duration.inMinutes.remainder(60);
      final seconds = duration.inSeconds.remainder(60);
      formattedTime = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

      update([AppConstant.idOnAudioCall]);
    });
  }

  void stopTimer() {
    Utils.showLog("Enter in host video call controller stop timer");

    endTime = DateTime.now();
    timer?.cancel();
    timer = null;

    duration = endTime?.difference(startTime!);
    minutes = duration?.inMinutes.remainder(60);
    seconds = duration?.inSeconds.remainder(60);
    finalDuration = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    Utils.showLog('Call Duration :: $duration');
    Utils.showLog('Final Duration :: $finalDuration');
  }

  void muteMic() async {
    isMute = !isMute;

    if (isMute) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
    Utils.showLog("Mute status changed: $isMute");

    update([AppConstant.idMuteMic, AppConstant.idOnAudioCall]);
  }

  void toggleSpeaker() async {
    isSpeakerOn = !isSpeakerOn;

    await _audioPlayer.setAudioContext(AudioContext(
      android: AudioContextAndroid(
        isSpeakerphoneOn: isSpeakerOn,
        stayAwake: true,
        contentType: AndroidContentType.speech,
        usageType: AndroidUsageType.voiceCommunication,
        audioFocus: AndroidAudioFocus.gainTransientMayDuck, // Better handoff
      ),
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.playAndRecord,
        options: const {AVAudioSessionOptions.defaultToSpeaker},
      ),
    ));

    /// Re-apply volume to ensure continuity
    await _audioPlayer.setVolume(isMute ? 0.0 : 100.0);

    update([AppConstant.idOnAudioCall]);
    Utils.showLog("Speaker toggled: $isSpeakerOn");
  }
}
