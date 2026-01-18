// import 'dart:async';
// import 'dart:math';

// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:LoveBirds/custom/dialog/block_dialog.dart';
// import 'package:LoveBirds/custom/other/custom_fetch_user_coin.dart';
// import 'package:LoveBirds/socket/socket_emit.dart';
// import 'package:LoveBirds/utils/colors_utils.dart';
// import 'package:LoveBirds/utils/constant.dart';
// import 'package:LoveBirds/utils/database.dart';
// import 'package:LoveBirds/utils/utils.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:proximity_screen_lock/proximity_screen_lock.dart';

// class VideoCallController extends GetxController {
//   RtcEngine? engine;
//   int? _remoteUid;
//   bool localUserJoined = false;
//   bool isMute = false;
//   bool isSpeaker = false;
//   bool isRotedCamera = false;
//   bool isVideoOn = true;
//   int? get remoteUid => _remoteUid;

//   bool onUserMuteVideo = true;
//   bool onUserMuteAudio = true;

//   String callId = '';
//   String callerId = '';
//   String receiverId = '';
//   String callType = '';
//   String callMode = '';
//   String receiverName = '';
//   String receiverImage = '';
//   String senderName = '';
//   String senderImage = '';
//   String token = '';
//   String channel = '';
//   String gender = '';
//   String callerUniqueId = '';
//   String receiverUniqueId = '';
//   String callerRole = '';
//   String receiverRole = '';
//   int uid = 0;

//   Timer? timer;
//   DateTime? startTime;
//   DateTime? endTime;
//   Duration? duration;
//   int? minutes;
//   int? seconds;
//   String? finalDuration;
//   String? formattedTime;
//   int callDurationSeconds = 0;

//   StreamSubscription<bool>? subsProximity;
//   bool isProximitySupported = false;
//   bool isObjectNear = false;

//   @override
//   void onInit() async {
//     Map<String, dynamic> data = Get.arguments ?? {};
//     Utils.showLog("Video call arguments data :: $data");

//     callId = data["callId"];
//     receiverId = data["receiverId"];
//     callerId = data["callerId"];
//     callType = data["callType"];
//     callMode = data["callMode"];
//     receiverName = data["receiverName"];
//     receiverImage = data["receiverImage"];
//     senderName = data["callerName"];
//     senderImage = data["callerImage"];
//     token = data["token"] ?? '';
//     channel = data["channel"] ?? '';
//     gender = data["gender"];
//     callerUniqueId = data["callerUniqueId"];
//     receiverUniqueId = data["receiverUniqueId"];
//     callerRole = data["callerRole"];
//     receiverRole = data["receiverRole"];

//     Utils.showLog('senderName:$senderName');
//     Utils.showLog('receiverId:$receiverId');
//     Utils.showLog('callerUniqueId:$callerUniqueId');
//     Utils.showLog('receiverUniqueId:$receiverUniqueId');
//     Utils.showLog("Agora App ID: ${Database.agoraAppId}");

//     initAgora();

//     if (!Database.isHost) {
//       Utils.showLog("Enter in Database.isHost == true");
//       onCallCoinCut(gender: gender);
//     }

//     await 2.seconds.delay();
//     if (callType == "audio") {
//       isProximitySupported =
//           await ProximityScreenLock.isProximityLockSupported();
//       if (isProximitySupported) {
//         await ProximityScreenLock.setActive(true);
//         subsProximity =
//             ProximityScreenLock.proximityStates.listen((objectDetected) {
//           isObjectNear = objectDetected;
//           Utils.showLog("Proximity object detected: $isObjectNear");
//         });
//       }
//     }

//     super.onInit();
//   }

//   @override
//   void onClose() {
//     Utils.showLog("Enter in Database. CLOSE");
//     onDisposeCall();
//     super.onClose();
//   }

//   String generateRandom7DigitId() {
//     final random = Random();
//     int number = 10000000 + random.nextInt(90000000);
//     return number.toString();
//   }

//   Future<void> initAgora() async {
//     Utils.showLog("🟢 Requesting permissions...");
//     final permissions =
//         await [Permission.microphone, Permission.camera].request();

//     if (!permissions.values.every((status) => status.isGranted)) {
//       Utils.showLog("❌ Permissions not granted. Exiting.");
//       return;
//     }

//     // ✅ ADD THIS: double-check actual permission status again after user grants
//     final micStatus = await Permission.microphone.status;
//     final cameraStatus = await Permission.camera.status;

//     if (!micStatus.isGranted || !cameraStatus.isGranted) {
//       Utils.showLog("❌ Permission still not granted after request. Exiting.");
//       return;
//     }

//     Utils.showLog("✅ Permissions granted.");

//     try {
//       // Agora initialization code here
//       engine = createAgoraRtcEngine();
//       Utils.showLog("✅ Engine created.");

//       print(
//           "==============================${Database.agoraAppId}================");

//       await engine?.initialize(RtcEngineContext(
//         appId: Database.agoraAppId,
//         channelProfile: ChannelProfileType.channelProfileCommunication1v1,
//       ));

//       if (callType == "audio") {
//         await engine?.enableAudio();
//         engine?.setEnableSpeakerphone(false);

//         update([AppConstant.idSpeaker, AppConstant.idOnVideoCall]);
//       } else {
//         engine?.switchCamera();
//         await engine?.enableVideo();
//         await engine?.startPreview();
//       }

//       print(
//           "===========================\n🎥 Video enabled and preview started.");

//       Utils.showLog("🎥 Video enabled and preview started.");

//       engine?.registerEventHandler(
//         RtcEngineEventHandler(
//           onLeaveChannel: (connection, stats) {
//             Utils.showLog("📴 Local user left the channel.");
//             localUserJoined = false;
//             _remoteUid = null;
//             stopTimer();
//             update([AppConstant.idOnVideoCall]);
//           },
//           onJoinChannelSuccess: (RtcConnection connection, int elapsed) async {
//             localUserJoined = true;

//             try {
//               await engine?.setEnableSpeakerphone(isSpeaker);
//             } catch (e) {
//               Utils.showLog("Error applying initial mute state: $e");
//             }

//             startTimer();
//             update([AppConstant.idOnVideoCall, AppConstant.idMuteMic]);
//           },
//           onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//             Utils.showLog("👤 Remote user $remoteUid joined.");
//             _remoteUid = remoteUid;
//             update([AppConstant.idOnVideoCall]);
//           },
//           onUserOffline: (RtcConnection connection, int remoteUid,
//               UserOfflineReasonType reason) async {
//             Utils.showLog("🚪 Remote user $remoteUid left. Reason: $reason");
//             _remoteUid = null;
//           },
//           onUserMuteVideo: (connection, remoteUid, muted) {
//             Utils.showLog(
//                 "🚪 Remote user $remoteUid left.onUserMuteVideo muted: $muted");

//             Utils.showLog("onUserMuteVideo before: $onUserMuteVideo");
//             if (muted == true) {
//               onUserMuteVideo = false;
//             } else {
//               onUserMuteVideo = true;
//             }

//             update([AppConstant.idOnVideoCall]);
//             Utils.showLog("onUserMuteVideo after: $onUserMuteVideo");
//           },
//           onUserMuteAudio: (connection, remoteUid, muted) {
//             Utils.showLog(
//                 "🚪 Remote user $remoteUid left.onUserMuteAudio muted: $muted");

//             Utils.showLog("onUserMuteAudio before: $onUserMuteAudio");
//             if (muted == true) {
//               onUserMuteAudio = false;
//             } else {
//               onUserMuteAudio = true;
//             }

//             update([AppConstant.idOnVideoCall]);
//             Utils.showLog("onUserMuteAudio after: $onUserMuteAudio");
//           },
//         ),
//       );

//       await joinChannel();

//       update([AppConstant.idOnVideoCall]);
//     } catch (e) {
//       Utils.showLog("❌ Error during initAgora: $e");
//     }
//   }

//   Future<void> joinChannel() async {
//     Utils.showLog("Joining channel...");
//     try {
//       await engine?.joinChannel(
//         token: token,
//         channelId: channel,
//         uid: uid,
//         options: ChannelMediaOptions(
//           autoSubscribeVideo: callType == "audio" ? false : true,
//           autoSubscribeAudio: true,
//           publishCameraTrack: callType == "audio" ? false : true,
//           publishMicrophoneTrack: true,
//           clientRoleType: ClientRoleType.clientRoleBroadcaster,
//         ),
//       );

//       Utils.showLog("Joining Channel Success !!");
//     } catch (e) {
//       Utils.showLog("Error joining channel: $e");
//     }
//   }

//   void muteMic() {
//     isMute = !isMute;
//     engine?.muteLocalAudioStream(isMute);
//     update([AppConstant.idMuteMic, AppConstant.idOnVideoCall]);
//   }

//   Future<void> speaker() async {
//     isSpeaker = !isSpeaker;
//     Utils.showLog("Toggling mute -> new isMute = $isSpeaker");

//     try {
//       await engine?.setEnableSpeakerphone(isSpeaker);
//       // optional: ensure recording volume zero when muted, restore when unmuted
//       // await engine?.adjustRecordingSignalVolume(isMute ? 0 : 100);
//       Utils.showLog("Engine muteLocalAudioStream called with: $isSpeaker");
//     } catch (e) {
//       Utils.showLog("Error toggling mic: $e");
//     }

//     update([AppConstant.idSpeaker, AppConstant.idOnVideoCall]);
//   }

//   void toggleCamera() {
//     isRotedCamera = !isRotedCamera;
//     engine?.switchCamera();
//     update([AppConstant.idToggleCamera, AppConstant.idOnVideoCall]);
//   }

//   void toggleVideo() {
//     isVideoOn = !isVideoOn;

//     if (isVideoOn) {
//       engine?.muteLocalVideoStream(false); // Turn video back on
//       engine?.startPreview(); // Start showing camera preview again
//     } else {
//       engine?.muteLocalVideoStream(true); // Mute the outgoing video
//       engine?.stopPreview(); // Stop local camera preview
//     }

//     update([AppConstant.idToggleVideo, AppConstant.idOnVideoCall]);
//   }

//   Future<void> onCallDisconnected() async {
//     Utils.showLog("call disconnect callerId :: $callerId");
//     Utils.showLog("call disconnect receiverId :: $receiverId");
//     Utils.showLog("call disconnect callId :: $callId");

//     SocketEmit.onCallDisconnected(
//       callerId: callerId,
//       receiverId: receiverId,
//       callId: callId,
//       callType: callType,
//       callMode: callMode,
//       callerRole: callerRole,
//       receiverRole: receiverRole,
//     );
//     300.milliseconds.delay();
//     await CustomFetchUserCoin.init();
//   }

//   void callDisconnected(Map<String, dynamic> response) {
//     Utils.showLog("callDisconnected :: $response");
//     onDisposeCall();
//   }

//   bool isCall = false;
//   onDisposeCall({bool? isAlreadyBack}) async {
//     if (isCall) return;
//     isCall = true;
//     stopTimer();
//     await engine?.leaveChannel(); // Leave the channel
//     await engine?.release(); // Release resources
//     Utils.showLog('leave----------------------');

//     if (callType == "audio") {
//       subsProximity?.cancel();
//       ProximityScreenLock.setActive(false);
//     }

//     if (isAlreadyBack != true) {
//       Get.back();
//     }
//   }

//   void startTimer() {
//     startTime = DateTime.now();
//     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       final duration = DateTime.now().difference(startTime ?? DateTime.now());
//       final minutes = duration.inMinutes.remainder(60);
//       final seconds = duration.inSeconds.remainder(60);
//       formattedTime =
//           '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

//       if (seconds == 0) {
//         Utils.showLog('Start timer :: $formattedTime');

//         if (!Database.isHost) {
//           Utils.showLog("Enter in Database.isHost == true");
//           onCallCoinCut(gender: gender);
//         }
//       }

//       update([AppConstant.idOnVideoCall]);
//     });
//   }

//   void stopTimer() {
//     endTime = DateTime.now();
//     timer?.cancel();
//     timer = null;

//     duration = endTime?.difference(startTime!);
//     minutes = duration?.inMinutes.remainder(60);
//     seconds = duration?.inSeconds.remainder(60);
//     finalDuration =
//         '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

//     Utils.showLog('Call Duration :: $duration');
//     Utils.showLog('Final Duration :: $finalDuration');
//   }

//   void onCallCoinCut({required String gender}) {
//     Utils.showLog("Coin Cut");
//     SocketEmit.onCallCoinCut(
//       callerId: callerId,
//       receiverId: receiverId,
//       callId: callId,
//       callType: callType,
//       callMode: callMode,
//       gender: gender,
//     );
//   }

//   //**************** Block
//   void getBlock({required BuildContext context}) async {
//     Get.dialog(
//       barrierColor: AppColors.blackColor.withValues(alpha: 0.8),
//       Dialog(
//         backgroundColor: AppColors.transparent,
//         shadowColor: Colors.transparent,
//         surfaceTintColor: Colors.transparent,
//         elevation: 0,
//         child: BlockDialog(
//           hostId: Database.isHost ? callerId : receiverId,
//           isHost: Database.isHost ? false : true,
//           userId: Database.isHost ? callerId : receiverId,
//           isVideoCall: true,
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:math';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:LoveBirds/custom/dialog/block_dialog.dart';
import 'package:LoveBirds/custom/gift_bottom_sheet/gift_bottom_sheet.dart';
import 'package:LoveBirds/custom/other/custom_fetch_user_coin.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/socket/socket_emit.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/internet_connection.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proximity_screen_lock/proximity_screen_lock.dart';

class VideoCallController extends GetxController {
  RtcEngine? engine;
  int? _remoteUid;
  bool localUserJoined = false;
  bool isMute = false;
  bool isSpeaker = false;
  bool isRotedCamera = false;
  bool isVideoOn = true;
  int? get remoteUid => _remoteUid;
  bool isLocalVideoEnlarged = false;

  bool onUserMuteVideo = true;
  bool onUserMuteAudio = true;

  String callId = '';
  String callerId = '';
  String receiverId = '';
  String callType = '';
  String callMode = '';
  String receiverName = '';
  String receiverImage = '';
  String senderName = '';
  String senderImage = '';
  String token = '';
  String channel = '';
  String gender = '';
  String callerUniqueId = '';
  String receiverUniqueId = '';
  String callerRole = '';
  String receiverRole = '';
  int uid = 0;

  Timer? timer;
  DateTime? startTime;
  DateTime? endTime;
  Duration? duration;
  int? minutes;
  int? seconds;
  String? finalDuration;
  String? formattedTime;
  int callDurationSeconds = 0;

  StreamSubscription<bool>? subsProximity;
  bool isProximitySupported = false;
  bool isObjectNear = false;

  bool isCall = false;

  @override
  void onInit() async {
    print("🟢 onInit called in VideoCallController");
    Map<String, dynamic> data = Get.arguments ?? {};
    print("Video call arguments data: $data");

    callId = data["callId"];
    receiverId = data["receiverId"];
    callerId = data["callerId"];
    callType = data["callType"];
    callMode = data["callMode"];
    receiverName = data["receiverName"];
    receiverImage = data["receiverImage"];
    senderName = data["callerName"];
    senderImage = data["callerImage"];
    token = data["token"] ?? '';
    channel = data["channel"] ?? '';
    gender = data["gender"];
    callerUniqueId = data["callerUniqueId"];
    receiverUniqueId = data["receiverUniqueId"];
    callerRole = data["callerRole"];
    receiverRole = data["receiverRole"];

    print("SenderName: $senderName, ReceiverId: $receiverId");
    print(
        "CallerUniqueId: $callerUniqueId, ReceiverUniqueId: $receiverUniqueId");
    print("Agora App ID: ${Database.agoraAppId}");

    await initAgora();

    if (!Database.isHost) {
      print("🎯 Non-host detected: triggering onCallCoinCut");
      onCallCoinCut(gender: gender);
    }

    await 2.seconds.delay();

    if (callType == "audio") {
      isProximitySupported =
          await ProximityScreenLock.isProximityLockSupported();
      print("Proximity sensor supported: $isProximitySupported");
      if (isProximitySupported) {
        await ProximityScreenLock.setActive(true);
        subsProximity =
            ProximityScreenLock.proximityStates.listen((objectDetected) {
          isObjectNear = objectDetected;
          print("Proximity object detected: $isObjectNear");
        });
      }
    }

    super.onInit();
  }

  @override
  void onClose() {
    print("🛑 onClose called, cleaning up VideoCallController");
    onDisposeCall();
    super.onClose();
  }

  String generateRandom7DigitId() {
    final random = Random();
    int number = 10000000 + random.nextInt(90000000);
    print("Generated random 7-digit ID: $number");
    return number.toString();
  }

  Future<void> initAgora() async {
    print("🟢 initAgora started, requesting permissions...");

    final permissions =
        await [Permission.microphone, Permission.camera].request();
    if (!permissions.values.every((status) => status.isGranted)) {
      print("❌ Permissions not granted. Exiting initAgora");
      return;
    }

    final micStatus = await Permission.microphone.status;
    final cameraStatus = await Permission.camera.status;

    if (!micStatus.isGranted || !cameraStatus.isGranted) {
      print("❌ Permissions still not granted after request. Exiting initAgora");
      return;
    }

    print("✅ Permissions granted, creating Agora engine");

    try {
      engine = createAgoraRtcEngine();
      print("✅ Agora engine created");

      await engine?.initialize(RtcEngineContext(
        appId: Database.agoraAppId,
        channelProfile: ChannelProfileType.channelProfileCommunication1v1,
      ));
      print("✅ Agora engine initialized");

      if (callType == "audio") {
        await engine?.enableAudio();
        engine?.setEnableSpeakerphone(false);
        print("🎤 Audio enabled, speakerphone off");
        update([AppConstant.idSpeaker, AppConstant.idOnVideoCall]);
      } else {
        print("📹 Video call: enabling video and preview after joinChannel");
      }

      engine?.registerEventHandler(RtcEngineEventHandler(
        onLeaveChannel: (connection, stats) {
          print("📴 Local user left channel");
          localUserJoined = false;
          _remoteUid = null;
          stopTimer();
          update([AppConstant.idOnVideoCall]);
        },
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) async {
          localUserJoined = true;
          print("✅ Joined channel successfully, elapsed: $elapsed ms");
          try {
            await engine?.setEnableSpeakerphone(isSpeaker);
            print("Speakerphone state applied: $isSpeaker");
          } catch (e) {
            print("⚠️ Error setting initial speakerphone: $e");
          }
          startTimer();
          update([AppConstant.idOnVideoCall, AppConstant.idMuteMic]);
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          _remoteUid = remoteUid;
          print("👤 Remote user $remoteUid joined, elapsed: $elapsed ms");
          update([AppConstant.idOnVideoCall]);
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          _remoteUid = null;
          print("🚪 Remote user $remoteUid left. Reason: $reason");
        },
        onUserMuteVideo: (connection, remoteUid, muted) {
          onUserMuteVideo = !muted;
          print(
              "📷 Remote user $remoteUid mute video: $muted, local state: $onUserMuteVideo");
          update([AppConstant.idOnVideoCall]);
        },
        onUserMuteAudio: (connection, remoteUid, muted) {
          onUserMuteAudio = !muted;
          print(
              "🎤 Remote user $remoteUid mute audio: $muted, local state: $onUserMuteAudio");
          update([AppConstant.idOnVideoCall]);
        },
      ));

      await joinChannel();
      if (callType != "audio") {
        await engine?.enableVideo();
        await engine?.startPreview();
        engine?.switchCamera();
        print("🎥 Video preview started and camera switched");
      }

      update([AppConstant.idOnVideoCall]);
    } catch (e) {
      print("❌ Error in initAgora: $e");
    }
  }

  Future<void> joinChannel() async {
    print("🔗 joinChannel called for channel: $channel, uid: $uid");
    try {
      await engine?.joinChannel(
        token: token,
        channelId: channel,
        uid: uid,
        options: ChannelMediaOptions(
          autoSubscribeVideo: callType != "audio",
          autoSubscribeAudio: true,
          publishCameraTrack: callType != "audio",
          publishMicrophoneTrack: true,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ),
      );
      print("✅ joinChannel success");
    } catch (e) {
      print("❌ joinChannel failed: $e");
    }
  }

  void muteMic() {
    isMute = !isMute;
    print("🔇 muteMic called. New state: $isMute");
    engine?.muteLocalAudioStream(isMute);
    update([AppConstant.idMuteMic, AppConstant.idOnVideoCall]);
  }

  Future<void> speaker() async {
    isSpeaker = !isSpeaker;
    print("🔊 speaker toggle called. New state: $isSpeaker");
    try {
      await engine?.setEnableSpeakerphone(isSpeaker);
      print("Speakerphone applied: $isSpeaker");
    } catch (e) {
      print("⚠️ Error toggling speaker: $e");
    }
    update([AppConstant.idSpeaker, AppConstant.idOnVideoCall]);
  }

  void toggleCamera() {
    isRotedCamera = !isRotedCamera;
    print("📷 toggleCamera called. New state: $isRotedCamera");
    engine?.switchCamera();
    update([AppConstant.idToggleCamera, AppConstant.idOnVideoCall]);
  }

  void toggleVideoView() {
    print(
        "====================\n\n\n\n\n==============switcvh \n\n\n\==============");
    isLocalVideoEnlarged = !isLocalVideoEnlarged;
    update([AppConstant.idOnVideoCall]);
  }

  void toggleVideo() {
    isVideoOn = !isVideoOn;
    print("🎥 toggleVideo called. New state: $isVideoOn");

    if (isVideoOn) {
      engine?.muteLocalVideoStream(false);
      engine?.startPreview();
    } else {
      engine?.muteLocalVideoStream(true);
      engine?.stopPreview();
    }

    update([AppConstant.idToggleVideo, AppConstant.idOnVideoCall]);
  }

  Future<void> onCallDisconnected() async {
    print("🔌 onCallDisconnected called: callId $callId");
    SocketEmit.onCallDisconnected(
      callerId: callerId,
      receiverId: receiverId,
      callId: callId,
      callType: callType,
      callMode: callMode,
      callerRole: callerRole,
      receiverRole: receiverRole,
    );
    await 300.milliseconds.delay();
    await CustomFetchUserCoin.init();
  }

  void callDisconnected(Map<String, dynamic> response) {
    print("🚪 callDisconnected event received: $response");
    onDisposeCall();
  }

  onDisposeCall({bool? isAlreadyBack}) async {
    if (isCall) return;
    isCall = true;
    print("🛑 onDisposeCall cleaning up call");
    stopTimer();
    await engine?.leaveChannel();
    await engine?.release();
    print("✅ Left channel and released Agora engine");

    if (callType == "audio") {
      subsProximity?.cancel();
      ProximityScreenLock.setActive(false);
      print("Proximity sensor disabled");
    }

    if (isAlreadyBack != true) {
      Get.back();
      print("Navigating back after call dispose");
    }
  }

  // void startTimer() async {
  //   startTime = DateTime.now();
  //   print("⏱ Timer started at $startTime");

  //   timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     final duration = DateTime.now().difference(startTime ?? DateTime.now());
  //     final minutes = duration.inMinutes.remainder(60);
  //     final seconds = duration.inSeconds.remainder(60);
  //     formattedTime =
  //         '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

  //     print("⏱ Timer tick: $formattedTime");

  //     if (seconds == 0 && !Database.isHost) {
  //       print("🎯 Non-host coin cut triggered");
  //       onCallCoinCut(gender: gender);
  //     }
  //     getUpdatedCoin();
  //     update([AppConstant.idUpdateCoin]);
  //     update([AppConstant.idOnVideoCall]);
  //   });
  // }

  void startTimer() {
    startTime = DateTime.now();
    print("⏱ Timer started at $startTime");

    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final duration = DateTime.now().difference(startTime!);
      final minutes = duration.inMinutes.remainder(60);
      final seconds = duration.inSeconds.remainder(60);

      formattedTime =
          '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

      print("⏱ Timer tick: $formattedTime");

      // Trigger coin cut only at the start of each minute for non-hosts
      if (seconds == 0 && !Database.isHost) {
        print("🎯 Non-host coin cut triggered");
        onCallCoinCut(gender: gender);
        await getUpdatedCoin();
      } else {
        await getUpdatedCoin();
      }

      // Update UI
      update([AppConstant.idUpdateCoin, AppConstant.idOnVideoCall]);
    });
  }

  void stopTimer() {
    endTime = DateTime.now();
    timer?.cancel();
    timer = null;

    duration = endTime?.difference(startTime!);
    minutes = duration?.inMinutes.remainder(60);
    seconds = duration?.inSeconds.remainder(60);
    finalDuration =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    print("⏹ Timer stopped. Duration: $duration, Final: $finalDuration");
  }

  void onCallCoinCut({required String gender}) {
    print("💰 Coin cut triggered for gender: $gender");
    SocketEmit.onCallCoinCut(
      callerId: callerId,
      receiverId: receiverId,
      callId: callId,
      callType: callType,
      callMode: callMode,
      gender: gender,
    );
  }

  Future<void> getUpdatedCoin() async {
    if (InternetConnection.isConnect) {
      update([AppConstant.idRandomMatchView]);

      await CustomFetchUserCoin.init();
      Utils.showLog(
          "vide_host_controller.dart coin: ${CustomFetchUserCoin.coin.value}");

      update([AppConstant.idRandomMatchView, AppConstant.idUpdateCoin]);
    } else {
      Utils.showLog("Internet Connection Lost !!");
    }
  }

  onSendGift() async {
    if (GiftBottomSheetWidget.selectedGiftId.isEmpty ||
        GiftBottomSheetWidget.giftUrl.isEmpty ||
        GiftBottomSheetWidget.giftType == -1) {
      Utils.showToast("Please select a gift first");
      return;
    }

    final totalCost = GiftBottomSheetWidget.giftCoin *
        GiftBottomSheetWidget.giftCount.toInt();
    if (totalCost > Database.coin) {
      Utils.showToast(EnumLocale.txtYouHaveInsufficientCoins.name.tr);
      await 600.milliseconds.delay();
      Get.toNamed(AppRoutes.topUpPage)?.then((_) => update());
      return;
    }

    if (callId.isEmpty) {
      Utils.showLog("Failed to send gift: callid is empty");
      return;
    }

    // Log senderId, hostId, and giftId for debugging
    print(
        "Chat Gift - SenderID: ${Database.isHost ? Database.hostId : Database.loginUserId}, HostID: ${Database.isHost ? receiverId : callerId}, GiftID: ${GiftBottomSheetWidget.selectedGiftId}");

    SocketEmit.onSendGiftVideoCall(
      callId: callId,
      giftCount: GiftBottomSheetWidget.giftCount.toString(),
      giftId: GiftBottomSheetWidget.selectedGiftId,
      giftUrl: GiftBottomSheetWidget.giftUrl,
      giftsvgaImage: GiftBottomSheetWidget.giftsvgaImage,
      giftImage: GiftBottomSheetWidget.giftsvgaImage,
      receiverId: Database.isHost ? receiverId : callerId,
      senderId: Database.isHost ? Database.hostId : Database.loginUserId,
      senderRole: Database.isHost ? "host" : "user",
      receiverRole: Database.isHost ? "user" : "host",
      giftType: GiftBottomSheetWidget.giftType,
    );
  }

  void getBlock({required BuildContext context}) async {
    print("🛑 getBlock dialog opened");
    Get.dialog(
      barrierColor: AppColors.blackColor.withValues(alpha: 0.8),
      Dialog(
        backgroundColor: AppColors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        child: BlockDialog(
          hostId: Database.isHost ? callerId : receiverId,
          isHost: Database.isHost ? false : true,
          userId: Database.isHost ? callerId : receiverId,
          isVideoCall: true,
        ),
      ),
    );
  }
}
