import 'package:LoveBirds/common/loading_widget.dart';
import 'package:LoveBirds/pages/fake_live_page/controller/fake_live_controller.dart';
import 'package:LoveBirds/pages/fake_live_page/widget/fake_live_widget.dart';
import 'package:LoveBirds/socket/socket_services.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FakeLiveView extends StatefulWidget {
  const FakeLiveView({super.key});

  @override
  State<FakeLiveView> createState() => _FakeLiveViewState();
}

class _FakeLiveViewState extends State<FakeLiveView> {
  final controller = Get.put(FakeLiveController());

  bool isHost = false;
  String localUserID = Database.loginUserId;
  String localUserName = "Hello Developer";
  String roomID = "1234";

  Widget? localView;
  int? localViewID;
  Widget? remoteView;
  int? remoteViewID;

  @override
  void initState() {
    SocketServices.mainLiveComments.clear();

    controller.videoUrl = Get.arguments["videoUrl"] ?? "";
    controller.initializeVideoPlayer();
    Utils.showLog("Is Live User Following => ${controller.videoUrl}");

    isHost = Get.arguments["isHost"] ?? "";
    controller.name = Get.arguments["name"];
    controller.image = Get.arguments["image"];
    roomID = Get.arguments["liveHistoryId"];
    controller.userId = Get.arguments["hostId"];

    controller.liveHistoryId = Get.arguments["liveHistoryId"];
    controller.hostId = Get.arguments["hostId"];

    super.initState();
  }

  @override
  void dispose() {
    controller.isLivePage = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: AppColors.blackColor,
        child: UserLiveUi(
          liveScreen: remoteView ?? const LoadingWidget(),
          liveRoomId: roomID,
          liveUserId: controller.userId,
        ),
      ),
    );
  }
}
