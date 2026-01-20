import 'package:LoveBirds/custom/gift_bottom_sheet/gift_bottom_sheet.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:camera/camera.dart';
import 'package:chewie/chewie.dart';
import 'package:LoveBirds/common/loading_widget.dart';
import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/pages/host_video_call_page/controller/host_video_call_controller.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HostVideoCallView extends GetView<HostVideoCallController> {
  const HostVideoCallView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.isBackProfile) {
          Get.back();
        } else {
          Get.back();
          Get.back();
        }
        return true;
      },
      child: Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          color: AppColors.blackColor,
          child: Stack(
            children: [
              GetBuilder<HostVideoCallController>(
                id: AppConstant.initializeVideoPlayer,
                builder: (controller) {
                  return Container(
                    color: AppColors.blackColor,
                    width: Get.width,
                    height: Get.height,
                    child: controller.chewieController != null &&
                            controller.videoPlayerController != null &&
                            controller
                                .videoPlayerController!.value.isInitialized
                        ? SizedBox.expand(
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                width: controller.videoPlayerController?.value
                                        .size.width ??
                                    0,
                                height: controller.videoPlayerController?.value
                                        .size.height ??
                                    0,
                                child: Chewie(
                                    controller: controller.chewieController!),
                              ),
                            ),
                          )
                        : Container(
                            height: Get.height,
                            width: Get.width,
                            color: AppColors.blackColor,
                            child: Stack(
                              children: [
                                Container(
                                  color: AppColors.colorTextGrey
                                      .withValues(alpha: 0.22),
                                  height: Get.height,
                                  width: Get.width,
                                  child: CustomImage(
                                    image: controller.hostImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                BlurryContainer(
                                  blur: 10,
                                  elevation: 0,
                                  borderRadius: BorderRadius.zero,
                                  color: Colors.black45,
                                  child: SizedBox(
                                    height: Get.height,
                                    width: Get.width,
                                  ),
                                ),
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.transparent,
                                          border: Border.all(
                                            color: AppColors.whiteColor,
                                            width: 2,
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          height: 125,
                                          width: 125,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.colorTextGrey
                                                .withValues(alpha: 0.22),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: CustomImage(
                                            image: controller.hostImage,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      3.height,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            EnumLocale.txtConnect.name.tr,
                                            style: AppFontStyle.styleW700(
                                                AppColors.whiteColor, 20),
                                          ),
                                          Lottie.asset(
                                            AppAsset.lottieLoading,
                                            height: 35,
                                          ).paddingOnly(top: 10),
                                        ],
                                      )
                                    ],
                                  ).paddingOnly(bottom: Get.height * 0.08),
                                ),
                              ],
                            ),
                          ),
                  );
                },
              ),
              GetBuilder<HostVideoCallController>(
                id: AppConstant.onInitializeCamera,
                builder: (controller) {
                  if (controller.cameraController != null &&
                      (controller.cameraController?.value.isInitialized ??
                          false) &&
                      controller.isVideoOn) {
                    return Positioned(
                      top: 50,
                      right: 20,
                      width: 135,
                      height: 170,
                      child: Container(
                        width: 135,
                        height: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: ClipRect(
                            clipper:
                                _MediaSizeClipper(MediaQuery.of(context).size),
                            child: Transform.scale(
                              scale: 1 /
                                  (controller
                                          .cameraController!.value.aspectRatio *
                                      MediaQuery.of(context).size.aspectRatio),
                              alignment: Alignment.topCenter,
                              child: controller.shouldMirrorCamera
                                  ? Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.identity()
                                        ..scale(-1.0, 1.0),
                                      child: CameraPreview(
                                          controller.cameraController!),
                                    )
                                  : CameraPreview(controller.cameraController!),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Positioned(
                      top: 50,
                      right: 20,
                      width: 135,
                      height: 170,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.blackColor),
                        child: controller.isVideoOn
                            ? const LoadingWidget()
                            : Icon(
                                Icons.videocam_off,
                                size: 25,
                                color: AppColors.whiteColor,
                              ),
                      ),
                    );
                  }
                },
              ),
              Align(
                alignment: Alignment.center,
                child: GiftBottomSheetWidget.onShowGift(),
              ),
              Positioned(
                top: 50,
                left: 20,
                child: GetBuilder<HostVideoCallController>(
                  id: AppConstant.idOnVideoCall,
                  builder: (logic) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(56),
                                border: Border.all(
                                    color: AppColors.colorBorder
                                        .withValues(alpha: 0.3)),
                                color: AppColors.blackColor
                                    .withValues(alpha: 0.45),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle),
                                    child: Stack(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 1,
                                          child: Image.asset(
                                              AppAsset.icProfilePlaceHolder),
                                        ),
                                        AspectRatio(
                                          aspectRatio: 1,
                                          child: CustomImage(
                                            image: logic.hostImage,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  7.width,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 85,
                                        child: Text(
                                          logic.hostName.trim(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppFontStyle.styleW600(
                                              AppColors.whiteColor, 14),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Utils.copyText(
                                            logic.hostUniqueId.isEmpty == true
                                                ? "96854320"
                                                : logic.hostUniqueId,
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              logic.hostUniqueId.isEmpty == true
                                                  ? "96854320"
                                                  : logic.hostUniqueId,
                                              maxLines: 1,
                                              style: AppFontStyle.styleW500(
                                                  AppColors.whiteColor, 10),
                                            ),
                                            5.width,
                                            GestureDetector(
                                              onTap: () {
                                                Utils.copyText(
                                                  logic.hostUniqueId.isEmpty ==
                                                          true
                                                      ? "96854320"
                                                      : logic.hostUniqueId,
                                                );
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                child: Image.asset(
                                                  AppAsset.copy,
                                                  height: 13,
                                                  width: 13,
                                                  color: AppColors.whiteColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            10.height,
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(56),
                                border: Border.all(
                                    color: AppColors.colorBorder
                                        .withValues(alpha: 0.3)),
                                color: AppColors.blackColor
                                    .withValues(alpha: 0.45),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAsset.icClock1,
                                    width: 18,
                                    color: AppColors.whiteColor,
                                  ),
                                  8.width,
                                  Text(
                                    logic.formattedTime ?? "",
                                    style: AppFontStyle.styleW700(
                                        AppColors.whiteColor, 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 30,
                right: 5,
                left: 5,
                child: Container(
                  height: 70,
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.blackColor.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GetBuilder<HostVideoCallController>(
                        id: AppConstant.idMuteMic,
                        builder: (logic) {
                          return GestureDetector(
                            onTap: () => logic.muteMic(),
                            child: circularIcon(
                              logic.isMute
                                  ? AppAsset.icUnMuteMic
                                  : AppAsset.icMuteMic,
                            ),
                          );
                        },
                      ),
                      GetBuilder<HostVideoCallController>(
                        id: AppConstant.idToggleVideo,
                        builder: (logic) {
                          return GestureDetector(
                            onTap: () => logic.toggleVideo(),
                            child: circularIcon(
                              logic.isVideoOn
                                  ? AppAsset.icVCall
                                  : AppAsset.icVCallOff,
                            ),
                          );
                        },
                      ),
                      GetBuilder<HostVideoCallController>(
                        id: AppConstant.idToggleCamera,
                        builder: (logic) {
                          return GestureDetector(
                            onTap: () => logic.toggleCamera(),
                            child: circularIcon(AppAsset.icCameraRoted),
                          );
                        },
                      ),
                      GetBuilder<HostVideoCallController>(
                        builder: (logic) {
                          return GestureDetector(
                            onTap: () {
                              if (logic.isBackProfile) {
                                Get.back();
                              } else {
                                Get.back();
                                Get.back();
                              }
                            },
                            child: Image.asset(
                              AppAsset.icCallCut,
                              height: 46,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              30.height,
            ],
          ),
        ),
      ),
    );
  }

  Widget circularIcon(String asset) {
    return Container(
      height: 46,
      width: 46,
      padding: const EdgeInsets.symmetric(horizontal: 13),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.whiteColor.withValues(alpha: 0.4),
      ),
      child: Image.asset(
        asset,
        color: AppColors.whiteColor,
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
