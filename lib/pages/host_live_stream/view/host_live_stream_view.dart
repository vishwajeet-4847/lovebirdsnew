import 'package:camera/camera.dart';
import 'package:figgy/common/loading_widget.dart';
import 'package:figgy/pages/host_live_stream/controller/host_live_stream_controller.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class HostLiveStreamView extends StatelessWidget {
  const HostLiveStreamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: AppColors.blackColor,
        child: Stack(
          children: [
            GetBuilder<HostLiveStreamController>(
                id: AppConstant.onInitializeCamera,
                builder: (controller) {
                  if (controller.cameraController != null && (controller.cameraController?.value.isInitialized ?? false)) {
                    final mediaSize = MediaQuery.of(context).size;
                    final scale = 1 / (controller.cameraController!.value.aspectRatio * mediaSize.aspectRatio);

                    return ClipRect(
                      clipper: _MediaSizeClipper(mediaSize),
                      child: Transform.scale(
                        scale: scale,
                        alignment: Alignment.topCenter,
                        child: CameraPreview(controller.cameraController!),
                      ),
                    );
                  } else {
                    return const LoadingWidget();
                  }
                }),
            Positioned(
              right: 0,
              top: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: 210,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              height: 34,
                              width: 34,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.whiteColor.withValues(alpha: 0.1),
                                border: Border.all(
                                  strokeAlign: 0.4,
                                  color: AppColors.whiteColor.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Image.asset(AppAsset.icClose),
                            ),
                          ),
                          18.height,
                          GetBuilder<HostLiveStreamController>(
                            id: AppConstant.onStartCountDown,
                            builder: (logic) {
                              return logic.isStartCountDown
                                  ? const SizedBox()
                                  : GestureDetector(
                                      onTap: logic.onSwitchCamera,
                                      child: Container(
                                        height: 34,
                                        width: 34,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.whiteColor.withValues(alpha: 0.1),
                                          border: Border.all(
                                            strokeAlign: 0.4,
                                            color: AppColors.whiteColor.withValues(alpha: 0.2),
                                          ),
                                        ),
                                        child: Image.asset(AppAsset.icCameraRoted).paddingAll(3),
                                      ),
                                    );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GetBuilder<HostLiveStreamController>(
                    id: AppConstant.onStartCountDown,
                    builder: (logic) {
                      return logic.isStartCountDown
                          ? const SizedBox()
                          : GestureDetector(
                              onTap: () {
                                logic.onClickGoLive();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.transparent,
                                  border: GradientBoxBorder(gradient: AppColors.hostLiveButton, width: 4),
                                ),
                                child: Container(
                                  width: 68,
                                  height: 68,
                                  decoration: BoxDecoration(shape: BoxShape.circle, gradient: AppColors.hostLiveInnerButton),
                                ),
                              ),
                            );
                    },
                  ),
                  15.height,
                  GetBuilder<HostLiveStreamController>(
                    id: AppConstant.onStartCountDown,
                    builder: (logic) {
                      return logic.isStartCountDown
                          ? const SizedBox()
                          : Container(
                              height: 31,
                              width: 82,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.blackColor.withValues(alpha: 0.5),
                                border: Border.all(color: AppColors.borderColorLiveButton, strokeAlign: 0.5),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                EnumLocale.txtGoLive.name.tr,
                                style: AppFontStyle.styleW600(AppColors.whiteColor, 16),
                              ),
                            );
                    },
                  ),
                  30.height,
                ],
              ),
            ),
            GetBuilder<HostLiveStreamController>(
              id: AppConstant.onStartCountDown,
              builder: (logic) {
                return logic.isCountingDown || logic.isStartCountDown
                    ? Align(
                        alignment: Alignment.center,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: ScaleTransition(
                                scale: animation,
                                child: child,
                              ),
                            );
                          },
                          child: logic.isCountingDown
                              ? Text(
                                  '${logic.count}',
                                  key: ValueKey<int>(logic.count),
                                  style: AppFontStyle.styleW900(Colors.white70, 175),
                                )
                              : Text(
                                  'Start',
                                  key: const ValueKey('Start'),
                                  style: AppFontStyle.styleW900(Colors.white70, 100),
                                ),
                        ),
                      )
                    : const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MediaSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;
  const _MediaSizeClipper(this.mediaSize);
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
