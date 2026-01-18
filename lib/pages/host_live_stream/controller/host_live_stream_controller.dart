import 'dart:async';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:LoveBirds/common/loading_widget.dart';
import 'package:LoveBirds/pages/host_live_stream/api/create_host_live_api.dart';
import 'package:LoveBirds/pages/host_live_stream/model/create_host_live_model.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HostLiveStreamController extends GetxController {
  CameraController? cameraController;
  CameraLensDirection cameraLensDirection = CameraLensDirection.front;
  CreateHostLiveModel? createHostLiveModel;

  bool isStartCountDown = false;
  bool isCountingDown = false;
  int count = 3;
  Timer? timer;

  @override
  void onInit() {
    onRequestPermissions();
    super.onInit();
  }

  @override
  void onClose() {
    onDisposeCamera();
    timer?.cancel();
    super.onClose();
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

  void startCountdown() {
    isCountingDown = true;
    update([AppConstant.onStartCountDown]);

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (count > 1) {
        count--;
      } else {
        count = 0;
        isCountingDown = false;
        timer.cancel();

        onCreateHostLive();
      }

      update([AppConstant.onStartCountDown]);
    });
  }

  void onClickGoLive() {
    isStartCountDown = true;
    count = 3;
    update([AppConstant.onStartCountDown]);
    startCountdown();
  }

  onCreateHostLive() async {
    createHostLiveModel = await CreateHostLiveApi.callApi(
      hostId: Database.hostId,
      agoraUID: "0",
      channel: (100000 + Random().nextInt(900000)).toString(),
    );

    if (createHostLiveModel?.status == true) {
      Get.toNamed(
        AppRoutes.hostLivePage,
        arguments: {
          "isHost": true,
          "name": createHostLiveModel?.data?.name ?? "",
          "image": createHostLiveModel?.data?.image ?? "",
          "liveHistoryId": createHostLiveModel?.data?.liveHistoryId ?? "",
          "hostId": createHostLiveModel?.data?.hostId ?? "",
          "token": createHostLiveModel?.data?.token ?? "",
          "channel": createHostLiveModel?.data?.channel ?? "",
        },
      );
      onDisposeCamera();
    } else {
      Utils.showToast(createHostLiveModel?.message ?? "");
    }
  }
}
