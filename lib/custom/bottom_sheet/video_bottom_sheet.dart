import 'dart:math';

import 'package:figgy/routes/app_routes.dart';
import 'package:figgy/socket/socket_emit.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showVideoBottomSheet({
  required BuildContext context,
  required String receiverId,
  required String receiverName,
  required String receiverImage,
  required num audioCallCharge,
  required num videoCallCharge,
  required bool isFake,
  List<String>? videoList,
}) {
  showModalBottomSheet(
    clipBehavior: Clip.antiAlias,
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 256,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: AppColors.callOptionBottomSheet,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).viewPadding.top + 60,
              padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
              alignment: Alignment.center,
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.whiteColor.withValues(alpha: 0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    28.width,
                    Text(
                      EnumLocale.txtSelectCallOption.name.tr,
                      style: AppFontStyle.styleW700(AppColors.whiteColor, 18),
                    ),
                    GestureDetector(
                      onTap: Get.back,
                      child: Container(
                        height: 25,
                        width: 25,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          AppAsset.icCloseDialog,
                          width: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            50.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (Database.audioPrivateCallRate < Database.coin) {
                          if (isFake) {
                            Get.toNamed(AppRoutes.incomingHostCall, arguments: {
                              "hostName": receiverName,
                              "hostImage": receiverImage,
                              "videoUrl": "",
                              "agoraUID": 0,
                              "channel": onGenerateRandomNumber(),
                              "hostUniqueId": "",
                              "hostId": receiverId,
                              "gender": "female",
                              "callId": "",
                              "callMode": "private",
                              "isBackProfile": false,
                              "callType": "audio",
                            });
                          } else {
                            await SocketEmit.onSendPrivateCall(
                              callerId: Database.isHost ? Database.hostId : Database.loginUserId,
                              receiverId: receiverId,
                              agoraUID: 0,
                              channel: (100000 + Random().nextInt(900000)).toString(),
                              callType: "audio",
                              senderName: Database.fetchLoginUserProfileModel?.user?.name ?? "",
                              senderImage: Database.fetchLoginUserProfileModel?.user?.image ?? "",
                              receiverName: receiverName,
                              receiverImage: receiverImage,
                              callerRole: "user",
                              receiverRole: "host",
                            );

                            // Get.back();
                          }
                        } else {
                          Utils.showToast(EnumLocale.txtYouHaveInsufficientCoins.name.tr);
                          await 600.milliseconds.delay();
                          Get.toNamed(AppRoutes.topUpPage);
                        }
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          gradient: AppColors.audioCallButtonGradient,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: AppColors.whiteColor),
                          color: AppColors.redColor,
                        ),
                        child: Image.asset(AppAsset.icAudioCall),
                      ),
                    ),
                    10.height,
                    Text(
                      EnumLocale.txtAudioCall.name.tr,
                      style: AppFontStyle.styleW400(AppColors.whiteColor, 13),
                    ),
                    Row(
                      children: [
                        Image.asset(AppAsset.singleSmallCoin, width: 25),
                        Text(
                          audioCallCharge == 0 ? "${Database.audioPrivateCallRate} /min" : "$audioCallCharge /min",
                          style: AppFontStyle.styleW400(AppColors.whiteColor, 13),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (Database.videoPrivateCallRate < Database.coin) {
                          if (isFake) {
                            final random = Random();
                            final List<String>? videoList1 = videoList;
                            final String randomVideoUrl =
                                (videoList1 != null && videoList1.isNotEmpty) ? videoList1[random.nextInt(videoList1.length)] : "";

                            Get.toNamed(AppRoutes.incomingHostCall, arguments: {
                              "hostName": receiverName,
                              "hostImage": receiverImage,
                              "videoUrl": randomVideoUrl,
                              "agoraUID": 0,
                              "channel": onGenerateRandomNumber(),
                              "hostUniqueId": "",
                              "hostId": receiverId,
                              "gender": "female",
                              "callId": "",
                              "callMode": "private",
                              "isBackProfile": false,
                              "callType": "video",
                            });
                          } else {
                            await SocketEmit.onSendPrivateCall(
                              callerId: Database.isHost ? Database.hostId : Database.loginUserId,
                              receiverId: receiverId,
                              agoraUID: 0,
                              channel: onGenerateRandomNumber(),
                              callType: "video",
                              senderName: Database.userName,
                              senderImage: Database.profileImage,
                              receiverName: receiverName,
                              receiverImage: receiverImage,
                              callerRole: "user",
                              receiverRole: "host",
                            );
                            // Get.back();
                          }
                        } else {
                          Utils.showToast(EnumLocale.txtYouHaveInsufficientCoins.name.tr);
                          await 600.milliseconds.delay();
                          Get.toNamed(AppRoutes.topUpPage);
                        }
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          gradient: AppColors.videoCallButtonGradient,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: AppColors.whiteColor),
                          color: AppColors.redColor,
                        ),
                        child: Image.asset(AppAsset.icVideoCall),
                      ),
                    ),
                    10.height,
                    Text(
                      EnumLocale.txtVideoCall.name.tr,
                      style: AppFontStyle.styleW400(AppColors.whiteColor, 13),
                    ),
                    Row(
                      children: [
                        Image.asset(AppAsset.singleSmallCoin, width: 25),
                        Text(
                          videoCallCharge == 0 ? "${Database.videoPrivateCallRate} /min" : "$videoCallCharge /min",
                          style: AppFontStyle.styleW600(AppColors.whiteColor, 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}

String onGenerateRandomNumber() {
  const String chars = 'abcdefghijklmnopqrstuvwxyz';
  Random random = Random();
  return List.generate(
    25,
    (index) => chars[random.nextInt(chars.length)],
  ).join();
}
