import 'dart:async';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:chewie/chewie.dart';
import 'package:LoveBirds/common/loading_widget.dart';
import 'package:LoveBirds/socket/socket_emit.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class HostVideoCallController extends GetxController {
  CameraController? cameraController;
  CameraLensDirection cameraLensDirection = CameraLensDirection.front;

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

  Timer? timer;
  DateTime? startTime;
  DateTime? endTime;
  Duration? duration;
  int? minutes;
  int? seconds;
  String? finalDuration;
  String? formattedTime;

  bool isMute = false;
  bool isVideoOn = true;
  bool isRotedCamera = false;

  ChewieController? chewieController;
  VideoPlayerController? videoPlayerController;

  // Gift functionality variables
  RxBool isShowGift = false.obs;
  String? currentGiftUrl;
  String? currentGiftType;
  Timer? giftAnimationTimer;

  @override
  void onInit() {
    Map<String, dynamic> data = Get.arguments ?? {};

    log("IncomingHostCall arguments :: $data");

    videoUrl = data['videoUrl'];
    initializeVideoPlayer();

    hostName = data['hostName'];
    hostImage = data['hostImage'];
    agoraUID = data['agoraUID'];
    channel = data['channel'];
    hostUniqueId = data['hostUniqueId'];
    hostId = data['hostId'];
    gender = data['gender'];
    callId = data['callId'];
    callMode = data['callMode'];
    isBackProfile = data['isBackProfile'];

    onRequestPermissions();

    1.seconds.delay();
    startTimer();

    if (!Database.isHost) {
      Utils.showLog("Enter in Database.isHost == true");
      onFakeCallCoinCut(gender: gender);
    }

    super.onInit();
  }

  @override
  void onClose() {
    Utils.showLog("Enter in host video call controller close");
    stopTimer();
    onDisposeVideoPlayer();
    onDisposeCamera();
    super.dispose();
  }

  bool get shouldMirrorCamera {
    return cameraLensDirection == CameraLensDirection.front;
  }

  Future<void> onRequestPermissions() async {
    final camera = await Permission.camera.request();
    final microphone = await Permission.microphone.request();
    if (camera.isGranted && microphone.isGranted) {
      onInitializeCamera();
    } else {
      Utils.showToast("Please allow permission !!");
    }
  }

  Future<void> onInitializeCamera() async {
    try {
      final cameras = await availableCameras();
      final camera = cameras.last; // Use the first available camera
      cameraController = CameraController(camera, ResolutionPreset.medium);
      await cameraController!.initialize();

      update([AppConstant.onInitializeCamera]);
    } catch (e) {
      Utils.showLog("Error initializing camera: $e");
    }
  }

  Future<void> onDisposeCamera() async {
    Utils.showLog("Enter in host video call controller dispose camera");

    cameraController?.dispose();
    cameraController = null;
    Utils.showLog("Camera Controller Dispose Success");
  }

  Future<void> onSwitchCamera() async {
    Get.dialog(
        barrierDismissible: false,
        const PopScope(
            canPop: false, child: LoadingWidget())); // Start Loading...

    cameraLensDirection = cameraLensDirection == CameraLensDirection.back
        ? CameraLensDirection.front
        : CameraLensDirection.back;
    final cameras = await availableCameras();
    final camera = cameras
        .firstWhere((camera) => camera.lensDirection == cameraLensDirection);
    cameraController = CameraController(camera, ResolutionPreset.high);
    await cameraController!.initialize();

    update([AppConstant.onInitializeCamera]);
    Get.back(); // Stop Loading...
  }

  void startTimer() {
    startTime = DateTime.now();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final duration = DateTime.now().difference(startTime ?? DateTime.now());
      final minutes = duration.inMinutes.remainder(60);
      final seconds = duration.inSeconds.remainder(60);
      formattedTime =
          '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

      if (seconds == 0) {
        Utils.showLog('Start timer :: $formattedTime');

        if (!Database.isHost) {
          Utils.showLog("Enter in Database.isHost == true");
          onFakeCallCoinCut(gender: gender);
        }
      }

      update([AppConstant.idOnVideoCall]);
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
    finalDuration =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    Utils.showLog('Call Duration :: $duration');
    Utils.showLog('Final Duration :: $finalDuration');
  }

  void muteMic() {
    isMute = !isMute;
    update([AppConstant.idMuteMic, AppConstant.idOnVideoCall]);
  }

  Future<void> toggleCamera() async {
    isRotedCamera = !isRotedCamera;

    cameraLensDirection = cameraLensDirection == CameraLensDirection.front
        ? CameraLensDirection.back
        : CameraLensDirection.front;

    try {
      final cameras = await availableCameras();
      final selectedCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == cameraLensDirection,
      );

      await cameraController?.dispose();

      cameraController = CameraController(
        selectedCamera,
        ResolutionPreset.medium,
      );

      await cameraController!.initialize();

      update([
        AppConstant.onInitializeCamera,
        AppConstant.idToggleCamera,
        AppConstant.idOnVideoCall
      ]);
    } catch (e) {
      Utils.showLog("Camera switch error: $e");
    }
  }

  void toggleVideo() {
    isVideoOn = !isVideoOn;
    update([
      AppConstant.onInitializeCamera,
      AppConstant.idToggleVideo,
      AppConstant.idOnVideoCall
    ]);
  }

  Future<void> initializeVideoPlayer() async {
    try {
      log("Video Url =>'${Api.baseUrl + videoUrl}'");
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(Api.baseUrl + videoUrl));

      await videoPlayerController?.initialize();

      if (videoPlayerController != null &&
          (videoPlayerController?.value.isInitialized ?? false)) {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController!,
          looping: true,
          allowedScreenSleep: false,
          allowMuting: false,
          showControlsOnInitialize: false,
          showControls: false,
          maxScale: 1,
        );
        videoPlayerController?.play();
        update([AppConstant.initializeVideoPlayer]);
      }
    } catch (e) {
      onDisposeVideoPlayer();
      Utils.showLog("Reels Video Initialization Failed !!! => $e");
    }
  }

  void onDisposeVideoPlayer() {
    Utils.showLog("Enter in host video call controller dispose video player");

    try {
      videoPlayerController?.dispose();
      chewieController?.dispose();
      chewieController = null;
      videoPlayerController = null;
    } catch (e) {
      Utils.showLog(">>>> On Dispose VideoPlayer Error => $e");
    }
  }

  void onFakeCallCoinCut({required String gender}) {
    Utils.showLog("Coin Cut For Fake Call===================");
    SocketEmit.onCoinCutForFakeCall(
      callerId: Database.loginUserId,
      receiverId: hostId,
      callType: "video",
      callMode: callMode,
      gender: gender,
    );
  }
}
