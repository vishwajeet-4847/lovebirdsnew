import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:LoveBirds/common/loading_widget.dart';
import 'package:LoveBirds/custom/dialog/stop_live_dialog.dart';
import 'package:LoveBirds/pages/host_live_page/controller/host_live_controller.dart';
import 'package:LoveBirds/pages/host_live_page/widget/host_live_widget.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostLiveView extends StatefulWidget {
  const HostLiveView({super.key});

  @override
  State<HostLiveView> createState() => _HostLiveViewState();
}

class _HostLiveViewState extends State<HostLiveView> {
  final controller = Get.put(HostLiveController());

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  void dispose() {
    controller.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.isHost) {
          await Get.dialog(
            barrierColor: AppColors.blackColor.withValues(alpha: 0.8),
            Dialog(
              backgroundColor: AppColors.transparent,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              child: const StopLiveDialog(),
            ),
          );
          return false;
        }
        return true;
      },
      child: GetBuilder<HostLiveController>(
        id: AppConstant.onCreateEngine,
        builder: (logic) {
          return Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) {
                return GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus &&
                        currentFocus.focusedChild != null) {
                      currentFocus.focusedChild?.unfocus();
                    }
                  },
                  child: Container(
                    height: Get.height,
                    width: Get.width,
                    color: AppColors.blackColor,
                    child: controller.isHost
                        ? HostLiveUi(
                            liveScreen: (controller.engine == null)
                                ? const LoadingWidget()
                                : AgoraVideoView(
                                    controller: VideoViewController(
                                      rtcEngine: controller.engine!,
                                      canvas: const VideoCanvas(uid: 0),
                                    ),
                                  ),
                          )
                        : GetBuilder<HostLiveController>(
                            builder: (controller) {
                              return UserLiveUi(
                                liveScreen: (controller.engine == null)
                                    ? const LoadingWidget()
                                    : (controller.remoteId == null)
                                        ? (controller.liveStatus == false &&
                                                Get.currentRoute ==
                                                    AppRoutes.hostLivePage)
                                            ? LiveStreamEndUi(
                                                image: controller.image)
                                            : const LoadingWidget()
                                        : AgoraVideoView(
                                            controller:
                                                VideoViewController.remote(
                                              rtcEngine: controller.engine!,
                                              canvas: VideoCanvas(
                                                  uid: controller.remoteId),
                                              connection: RtcConnection(
                                                  channelId:
                                                      controller.channel),
                                            ),
                                          ),
                                liveStatus: controller.liveStatus,
                                liveRoomId: controller.liveHistoryId,
                                liveUserId: controller.hostId,
                              );
                            },
                          ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
