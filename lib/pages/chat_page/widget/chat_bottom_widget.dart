import 'package:LoveBirds/custom/bottom_sheet/video_bottom_sheet.dart';
import 'package:LoveBirds/custom/custom_format_audio_time.dart';
import 'package:LoveBirds/custom/gift_bottom_sheet/gift_bottom_sheet.dart';
import 'package:LoveBirds/pages/chat_page/controller/chat_controller.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class ChatBottomViewWidget extends GetView<ChatController> {
  const ChatBottomViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 32,
          child: GetBuilder<ChatController>(
            builder: (logic) {
              return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: logic.dummyChat.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => logic.onClickSendDummyChat(index: index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor.withValues(alpha: 0.20),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        logic.dummyChat[index],
                        style: AppFontStyle.styleW600(AppColors.whiteColor, 15),
                      ),
                    ).paddingOnly(left: 10),
                  );
                },
              );
            },
          ),
        ).paddingOnly(left: 4),
        10.height,
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: AppColors.chatBottomColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.blackColor.withValues(alpha: 0.40),
                offset: const Offset(0, -6),
                blurRadius: 34,
                spreadRadius: 0,
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.height,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Database.isHost
                        ? Expanded(
                            child: GetBuilder<ChatController>(
                              id: AppConstant.idOnChangeAudioRecordingEvent,
                              builder: (context) {
                                return Container(
                                  clipBehavior: Clip.antiAlias,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.blackColor
                                            .withValues(alpha: 0.40),
                                        offset: const Offset(0, -6),
                                        blurRadius: 34,
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: TextFormField(
                                    maxLines: null,
                                    clipBehavior: Clip.antiAlias,
                                    controller: controller.messageController,
                                    decoration: InputDecoration(
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap: () =>
                                                controller.onProfileImage(),
                                            child: Image.asset(
                                              AppAsset.icGallery,
                                              height: 22,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Vibration.vibrate(
                                                  duration: 50, amplitude: 128);
                                              Utils.showToast(EnumLocale
                                                  .txtLongPressToEnableAudioRecording
                                                  .name
                                                  .tr);
                                            },
                                            onLongPressStart: (details) {
                                              if (controller
                                                      .isSendingAudioFile ==
                                                  false) {
                                                Vibration.vibrate(
                                                    duration: 50,
                                                    amplitude: 128);
                                                controller
                                                    .onLongPressStartMic();
                                              }
                                            },
                                            onLongPressEnd: (details) {
                                              if (controller
                                                      .isSendingAudioFile ==
                                                  false) {
                                                Vibration.vibrate(
                                                    duration: 50,
                                                    amplitude: 128);
                                                controller.onLongPressEndMic();
                                              }
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              child: Image.asset(
                                                AppAsset.blueMiceIcon,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      hintText: controller.isRecordingAudio
                                          ? CustomFormatAudioTime.convert(
                                              controller.countTime)
                                          : EnumLocale.txtTypeSomething.name.tr,
                                      hintStyle: AppFontStyle.styleW400(
                                          AppColors.textFieldTxtColor, 13),
                                      filled: true,
                                      fillColor: AppColors.textFieldColor,
                                      border: InputBorder.none,
                                    ),
                                    onFieldSubmitted: (value) {
                                      controller.onClickSend();
                                    },
                                  ),
                                );
                              },
                            ),
                          )
                        : Expanded(
                            child: GetBuilder<ChatController>(
                              id: AppConstant.idOnChangeAudioRecordingEvent,
                              builder: (context) {
                                return Container(
                                  clipBehavior: Clip.antiAlias,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: TextFormField(
                                    maxLines: null,
                                    clipBehavior: Clip.antiAlias,
                                    controller: controller.messageController,
                                    decoration: InputDecoration(
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          Vibration.vibrate(
                                              duration: 50, amplitude: 128);
                                          Utils.showToast(EnumLocale
                                              .txtLongPressToEnableAudioRecording
                                              .name
                                              .tr);
                                        },
                                        onLongPressStart: (details) {
                                          if (controller.isSendingAudioFile ==
                                              false) {
                                            Vibration.vibrate(
                                                duration: 50, amplitude: 128);
                                            controller.onLongPressStartMic();
                                          }
                                        },
                                        onLongPressEnd: (details) {
                                          if (controller.isSendingAudioFile ==
                                              false) {
                                            Vibration.vibrate(
                                                duration: 50, amplitude: 128);
                                            controller.onLongPressEndMic();
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Image.asset(
                                            AppAsset.blueMiceIcon,
                                          ),
                                        ),
                                      ),
                                      hintText: controller.isRecordingAudio
                                          ? CustomFormatAudioTime.convert(
                                              controller.countTime)
                                          : EnumLocale.txtTypeSomething.name.tr,
                                      hintStyle: AppFontStyle.styleW400(
                                          AppColors.textFieldTxtColor, 13),
                                      filled: true,
                                      fillColor: AppColors.textFieldColor,
                                      border: InputBorder.none,
                                    ),
                                    onFieldSubmitted: (value) {
                                      controller.onClickSend();
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                    10.width,
                    GestureDetector(
                      onTap: () => controller.onClickSend(),
                      child: Container(
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.hostLiveInnerButton,
                        ),
                        child: Image.asset(
                          AppAsset.icSend,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Database.isHost ? 15.height : 0.height,
              if (Database.isHost)
                const Offstage()
              else
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () => controller.onProfileImage(),
                        child: Image.asset(AppAsset.icGallery, height: 34),
                      ),
                      GetBuilder<ChatController>(
                        builder: (logic) {
                          return GestureDetector(
                            onTap: () {
                              showVideoBottomSheet(
                                context: context,
                                receiverId: Database.isHost
                                    ? logic.receiverId
                                    : logic.hostId,
                                receiverName: controller.hostName,
                                receiverImage: controller.profileImage,
                                audioCallCharge: logic
                                        .fetchChatHistoryFromUserModel
                                        ?.callRate
                                        ?.audioCallRate ??
                                    0,
                                videoCallCharge: logic
                                        .fetchChatHistoryFromUserModel
                                        ?.callRate
                                        ?.privateCallRate ??
                                    0,
                                isFake:
                                    logic.hostDetailModel?.host?.isFake == true
                                        ? true
                                        : false,
                                videoList: logic.hostDetailModel?.host?.video,
                              );
                            },
                            child: Image.asset(AppAsset.callIcon, height: 36),
                          );
                        },
                      ),
                      GetBuilder<ChatController>(
                        builder: (logic) {
                          return GestureDetector(
                            onTap: () {
                              GiftBottomSheetWidget.show(
                                context: Get.context!,
                                callback: () => logic.onSendGift(),
                                isChat: true,
                              );

                              logic.update();
                            },
                            child: Image.asset(AppAsset.icGift, height: 34),
                          );
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
