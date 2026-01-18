import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:LoveBirds/common/loading_widget.dart';
import 'package:LoveBirds/custom/bottom_sheet/report_bottom_sheet.dart';
import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/custom/gift_bottom_sheet/gift_bottom_sheet.dart';
import 'package:LoveBirds/pages/video_call_page/controller/video_call_controller.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoCallView extends StatelessWidget {
  const VideoCallView({super.key});

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

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: GetBuilder<VideoCallController>(
        id: AppConstant.idOnVideoCall,
        builder: (logic) {
          return PopScope(
            canPop: true,
            onPopInvokedWithResult: (didPop, result) {
              Utils.showLog("Show Log Dispose => ");

              logic.onCallDisconnected();
              logic.onDisposeCall(isAlreadyBack: true);
            },
            child: logic.callType == "audio"
                ? Stack(
                    children: [
                      Container(
                        height: Get.height,
                        width: Get.width,
                        decoration: BoxDecoration(
                          gradient: AppColors.incomingCallGradient,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              height: 110,
                              width: 110,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppColors.gradientButtonColor,
                              ),
                              child: Container(
                                height: 114,
                                width: 114,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: AppColors.gradientButtonColor,
                                ),
                                child: Container(
                                  height: Get.height,
                                  width: Get.width,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: AppColors.gradientButtonColor,
                                  ),
                                  child: SizedBox(
                                    height: 110,
                                    width: 110,
                                    child: CustomImage(
                                      image: logic.receiverId == Database.hostId
                                          ? logic.senderImage
                                          : logic.receiverImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          10.height,
                          Text(
                            logic.receiverId == Database.hostId
                                ? logic.senderName
                                : logic.receiverName,
                            style: AppFontStyle.styleW800(
                                AppColors.whiteColor, 24),
                          ),
                          5.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(56),
                                  color: AppColors.whiteColor
                                      .withValues(alpha: 0.12),
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
                          270.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GetBuilder<VideoCallController>(
                                id: AppConstant.idSpeaker,
                                builder: (logic) {
                                  return GestureDetector(
                                    onTap: () => logic.speaker(),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor
                                            .withValues(alpha: 0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        color: AppColors.whiteColor,
                                        logic.isSpeaker
                                            ? AppAsset.icSpeakerOn
                                            : AppAsset.icSpeakerOff,
                                        height: 30,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              30.width,
                              GestureDetector(
                                onTap: () => logic.onCallDisconnected(),
                                child: Image.asset(
                                  AppAsset.imgCallCancel,
                                  height: 70,
                                ),
                              ),
                              30.width,
                              GetBuilder<VideoCallController>(
                                id: AppConstant.idMuteMic,
                                builder: (logic) {
                                  return GestureDetector(
                                    onTap: () => logic.muteMic(),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor
                                            .withValues(alpha: 0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        color: AppColors.whiteColor,
                                        logic.isMute
                                            ? AppAsset.icUnMuteMic
                                            : AppAsset.icMuteMic,
                                        height: 30,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        right: 20,
                        top: 40,
                        child: PopupMenuButton<String>(
                          child: Container(
                            width: 27,
                            height: 27,
                            color: AppColors.transparent,
                            child: Image.asset(
                              AppAsset.circleMoreIcon,
                            ),
                          ),
                          onSelected: (value) {
                            if (value == EnumLocale.txtBlock.name.tr) {
                              logic.getBlock(context: context);
                            } else if (value == EnumLocale.txtReport.name.tr) {
                              ReportBottomSheetUi.show(
                                context: context,
                              );
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
                              value: EnumLocale.txtBlock.name.tr,
                              child: Text(EnumLocale.txtBlock.name.tr),
                            ),
                            PopupMenuItem(
                              value: EnumLocale.txtReport.name.tr,
                              child: Text(EnumLocale.txtReport.name.tr),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      logic.onUserMuteVideo
                          ? GetBuilder<VideoCallController>(
                              id: AppConstant.idOnVideoCall,
                              builder: (logic) {
                                if (logic.remoteUid != null &&
                                    logic.remoteUid != 0) {
                                  return logic.callType == "audio"
                                      ? Container()
                                      : logic.onUserMuteAudio
                                          ? logic.isLocalVideoEnlarged
                                              ? AgoraVideoView(
                                                  controller:
                                                      VideoViewController(
                                                    rtcEngine: logic.engine!,
                                                    canvas: const VideoCanvas(
                                                      uid: 0,
                                                      mirrorMode:
                                                          VideoMirrorModeType
                                                              .videoMirrorModeEnabled,
                                                    ),
                                                  ),
                                                )
                                              : AgoraVideoView(
                                                  controller:
                                                      VideoViewController
                                                          .remote(
                                                    rtcEngine: logic.engine!,
                                                    canvas: VideoCanvas(
                                                      uid: logic.remoteUid!,
                                                      mirrorMode:
                                                          VideoMirrorModeType
                                                              .videoMirrorModeEnabled,
                                                    ),
                                                    connection: RtcConnection(
                                                        channelId:
                                                            logic.channel),
                                                  ),
                                                )
                                          : Stack(
                                              children: [
                                                AgoraVideoView(
                                                  controller:
                                                      VideoViewController
                                                          .remote(
                                                    rtcEngine: logic.engine!,
                                                    canvas: VideoCanvas(
                                                      uid: logic.remoteUid!,
                                                      mirrorMode:
                                                          VideoMirrorModeType
                                                              .videoMirrorModeEnabled,
                                                    ),
                                                    connection: RtcConnection(
                                                        channelId:
                                                            logic.channel),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    height: 120,
                                                    width: 110,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.black38,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Spacer(),
                                                        Image.asset(
                                                          AppAsset.icUnMuteMic,
                                                          height: 50,
                                                          width: 50,
                                                        ),
                                                        10.height,
                                                        Text(
                                                          "Call on mute",
                                                          style: AppFontStyle
                                                              .styleW800(
                                                                  AppColors
                                                                      .whiteColor,
                                                                  14),
                                                        ),
                                                        const Spacer(),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                } else {
                                  return const Center(child: LoadingWidget());
                                }
                              },
                            )
                          : Stack(
                              children: [
                                SizedBox(
                                  height: Get.height,
                                  width: Get.width,
                                  child: CustomImage(
                                    image: logic.callerRole == "host"
                                        ? logic.callerId == Database.hostId
                                            ? logic.receiverImage
                                            : logic.senderImage
                                        : logic.receiverId == Database.hostId
                                            ? logic.senderImage
                                            : logic.receiverImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                BlurryContainer(
                                  blur: 17,
                                  height: Get.height,
                                  width: Get.width,
                                  elevation: 0,
                                  color: AppColors.blackColor
                                      .withValues(alpha: 0.2),
                                  child: SizedBox(
                                    height: Get.height,
                                    width: Get.width,
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    height: 120,
                                    width: logic.onUserMuteVideo &&
                                            logic.onUserMuteAudio
                                        ? 110
                                        : 130,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.black38,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Spacer(),
                                        Image.asset(
                                          logic.onUserMuteVideo == false &&
                                                  logic.onUserMuteAudio == true
                                              ? AppAsset.icVideoPause
                                              : AppAsset.icMicCamera,
                                          height: 50,
                                          width: 50,
                                          color: AppColors.whiteColor,
                                        ),
                                        10.height,
                                        Text(
                                          logic.onUserMuteVideo == false &&
                                                  logic.onUserMuteAudio == true
                                              ? "Video Call Paused"
                                              : "Camera/Mic off",
                                          style: AppFontStyle.styleW800(
                                              AppColors.whiteColor, 14),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            50.height,
                            Row(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                                  child: Image.asset(AppAsset
                                                      .icProfilePlaceHolder),
                                                ),
                                                AspectRatio(
                                                  aspectRatio: 1,
                                                  child: CustomImage(
                                                    image: logic.callerRole ==
                                                            "host"
                                                        ? logic.callerId ==
                                                                Database.hostId
                                                            ? logic
                                                                .receiverImage
                                                            : logic.senderImage
                                                        : logic.receiverId ==
                                                                Database.hostId
                                                            ? logic.senderImage
                                                            : logic
                                                                .receiverImage,
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
                                                  logic.callerRole == "host"
                                                      ? logic.callerId ==
                                                              Database.hostId
                                                          ? logic.receiverName
                                                          : logic.senderName
                                                      : logic.receiverId ==
                                                              Database.hostId
                                                          ? logic.senderName
                                                          : logic.receiverName,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppFontStyle.styleW600(
                                                      AppColors.whiteColor, 14),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Utils.copyText(
                                                    logic.callerUniqueId
                                                                .isEmpty ==
                                                            true
                                                        ? logic.receiverId ==
                                                                Database.hostId
                                                            ? "95863248"
                                                            : "65895412"
                                                        : logic.callerRole ==
                                                                "host"
                                                            ? logic.callerId ==
                                                                    Database
                                                                        .hostId
                                                                ? logic
                                                                    .receiverUniqueId
                                                                : logic
                                                                    .callerUniqueId
                                                            : logic.receiverId ==
                                                                    Database
                                                                        .hostId
                                                                ? logic
                                                                    .callerUniqueId
                                                                : logic
                                                                    .receiverUniqueId,
                                                  );
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      logic.callerUniqueId
                                                                  .isEmpty ==
                                                              true
                                                          ? logic.receiverId ==
                                                                  Database
                                                                      .hostId
                                                              ? "95863248"
                                                              : "65895412"
                                                          : logic.callerRole ==
                                                                  "host"
                                                              ? logic.callerId ==
                                                                      Database
                                                                          .hostId
                                                                  ? logic
                                                                      .receiverUniqueId
                                                                  : logic
                                                                      .callerUniqueId
                                                              : logic.receiverId ==
                                                                      Database
                                                                          .hostId
                                                                  ? logic
                                                                      .callerUniqueId
                                                                  : logic
                                                                      .receiverUniqueId,
                                                      maxLines: 1,
                                                      style: AppFontStyle
                                                          .styleW500(
                                                              AppColors
                                                                  .whiteColor,
                                                              10),
                                                    ),
                                                    5.width,
                                                    GestureDetector(
                                                      onTap: () {
                                                        Utils.copyText(
                                                          logic.callerUniqueId
                                                                      .isEmpty ==
                                                                  true
                                                              ? logic.receiverId ==
                                                                      Database
                                                                          .hostId
                                                                  ? "95863248"
                                                                  : "65895412"
                                                              : logic.callerRole ==
                                                                      "host"
                                                                  ? logic.callerId ==
                                                                          Database
                                                                              .hostId
                                                                      ? logic
                                                                          .receiverUniqueId
                                                                      : logic
                                                                          .callerUniqueId
                                                                  : logic.receiverId ==
                                                                          Database
                                                                              .hostId
                                                                      ? logic
                                                                          .callerUniqueId
                                                                      : logic
                                                                          .receiverUniqueId,
                                                        );
                                                      },
                                                      child: Container(
                                                        color:
                                                            Colors.transparent,
                                                        child: Image.asset(
                                                          AppAsset.copy,
                                                          height: 13,
                                                          width: 13,
                                                          color: AppColors
                                                              .whiteColor,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                    5.height,
                                    !Database.isHost
                                        ? Positioned(
                                            top: 30,
                                            right: 12,
                                            child:
                                                GetBuilder<VideoCallController>(
                                              id: AppConstant.idUpdateCoin,
                                              builder: (logic) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(
                                                            AppRoutes.topUpPage)
                                                        ?.then((_) async {
                                                      await logic
                                                          .getUpdatedCoin();
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 32,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors
                                                              .colorDimButton),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      gradient: AppColors
                                                          .gradientButtonColor,
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Image.asset(
                                                          AppAsset.coinIcon2,
                                                          height: 20,
                                                          width: 20,
                                                        ),
                                                        const SizedBox(
                                                            width: 6),
                                                        Text(
                                                          Database.coin
                                                              .toString()
                                                              .split('.')[0],
                                                          style: AppFontStyle
                                                              .styleW800(
                                                            AppColors
                                                                .whiteColor,
                                                            16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : 1.height,
                                  ],
                                ),
                                PopupMenuButton<String>(
                                  child: Container(
                                    width: 27,
                                    height: 27,
                                    color: AppColors.transparent,
                                    child: Image.asset(
                                      AppAsset.circleMoreIcon,
                                    ),
                                  ),
                                  onSelected: (value) {
                                    if (value == EnumLocale.txtBlock.name.tr) {
                                      logic.getBlock(context: context);
                                    } else if (value ==
                                        EnumLocale.txtReport.name.tr) {
                                      ReportBottomSheetUi.show(
                                        context: context,
                                      );
                                    }
                                  },
                                  itemBuilder: (BuildContext context) => [
                                    PopupMenuItem(
                                      value: EnumLocale.txtBlock.name.tr,
                                      child: Text(EnumLocale.txtBlock.name.tr),
                                    ),
                                    PopupMenuItem(
                                      value: EnumLocale.txtReport.name.tr,
                                      child: Text(EnumLocale.txtReport.name.tr),
                                    ),
                                  ],
                                ).paddingOnly(top: 8, left: 6),
                                const Spacer(),
                                GetBuilder<VideoCallController>(
                                  builder: (logic) {
                                    if (logic.engine != null) {
                                      return GestureDetector(
                                        onTap: () {
                                          print(
                                              "tappped herer somewherehre=====\n/\n\n\n\n\n");
                                          logic.toggleVideoView();
                                          logic.update(
                                              [AppConstant.idOnVideoCall]);
                                        },
                                        child: Container(
                                          height: 172,
                                          width: 140,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: AppColors.blackColor,
                                          ),
                                          child: logic.isLocalVideoEnlarged
                                              // 🔹 Show remote video in small preview when local is large
                                              ? (logic.remoteUid != null &&
                                                      logic.remoteUid != 0
                                                  ? AgoraVideoView(
                                                      controller:
                                                          VideoViewController
                                                              .remote(
                                                        rtcEngine:
                                                            logic.engine!,
                                                        canvas: VideoCanvas(
                                                            uid: logic
                                                                .remoteUid!),
                                                        connection:
                                                            RtcConnection(
                                                                channelId: logic
                                                                    .channel),
                                                      ),
                                                    )
                                                  : Center(
                                                      child: Text(
                                                          "Waiting for remote...")))
                                              // 🔹 Otherwise show local video in small preview
                                              : logic.callType == "audio"
                                                  ? Center(
                                                      child: Text(EnumLocale
                                                          .txtAudioCall
                                                          .name
                                                          .tr),
                                                    )
                                                  : !logic.isVideoOn &&
                                                          logic.isMute
                                                      ? Center(
                                                          child: Image.asset(
                                                            AppAsset
                                                                .icMicCamera,
                                                            height: 50,
                                                            width: 50,
                                                            color: AppColors
                                                                .whiteColor,
                                                          ),
                                                        )
                                                      : logic.isVideoOn
                                                          ? logic.isMute
                                                              ? Stack(
                                                                  children: [
                                                                    AgoraVideoView(
                                                                      controller:
                                                                          VideoViewController(
                                                                        rtcEngine:
                                                                            logic.engine!,
                                                                        canvas:
                                                                            const VideoCanvas(
                                                                          uid:
                                                                              0,
                                                                          mirrorMode:
                                                                              VideoMirrorModeType.videoMirrorModeEnabled,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Center(
                                                                      child: Image
                                                                          .asset(
                                                                        AppAsset
                                                                            .icUnMuteMic,
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : AgoraVideoView(
                                                                  controller:
                                                                      VideoViewController(
                                                                    rtcEngine: logic
                                                                        .engine!,
                                                                    canvas:
                                                                        const VideoCanvas(
                                                                      uid: 0,
                                                                      mirrorMode:
                                                                          VideoMirrorModeType
                                                                              .videoMirrorModeEnabled,
                                                                    ),
                                                                  ),
                                                                )
                                                          : Center(
                                                              child:
                                                                  Image.asset(
                                                                AppAsset
                                                                    .icVideoPause,
                                                                height: 50,
                                                                width: 50,
                                                              ),
                                                            ),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                )
                              ],
                            ),
                            const Spacer(),
                            Container(
                              height: 70,
                              width: Get.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color:
                                    AppColors.blackColor.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  !Database.isHost
                                      ? GetBuilder<VideoCallController>(
                                          builder: (logic) {
                                            return GestureDetector(
                                              onTap: () {
                                                GiftBottomSheetWidget.show(
                                                  context: Get.context!,
                                                  callback: () =>
                                                      logic.onSendGift(),
                                                  isChat: false,
                                                );
                                                logic.update();
                                              },
                                              child: Image.asset(
                                                  AppAsset.icGift,
                                                  height: 34),
                                            );
                                          },
                                        )
                                      : const SizedBox.shrink(),
                                  GetBuilder<VideoCallController>(
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

                                  GetBuilder<VideoCallController>(
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

                                  GetBuilder<VideoCallController>(
                                    id: AppConstant.idToggleCamera,
                                    builder: (logic) {
                                      return GestureDetector(
                                        onTap: () => logic.toggleCamera(),
                                        child: circularIcon(
                                            AppAsset.icCameraRoted),
                                      );
                                    },
                                  ),

                                  // End call button
                                  GestureDetector(
                                    onTap: () => logic.onCallDisconnected(),
                                    child: Image.asset(
                                      AppAsset.icCallCut,
                                      height: 46,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            30.height,
                          ],
                        ),
                      )
                    ],
                  ),
          );
        },
      ),
    );
  }
}
