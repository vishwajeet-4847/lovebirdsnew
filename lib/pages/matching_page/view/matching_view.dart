import 'dart:math';

import 'package:figgy/custom/custom_image/custom_profile_image.dart';
import 'package:figgy/pages/matching_page/controller/matching_controller.dart';
import 'package:figgy/pages/matching_page/widget/matching_bg_widget.dart';
import 'package:figgy/routes/app_routes.dart';
import 'package:figgy/socket/socket_emit.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class MatchingView extends StatelessWidget {
  const MatchingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: GetBuilder<MatchingController>(
        builder: (logic) {
          return Stack(
            children: [
              const MatchingBgWidget(),
              Positioned(
                top: 20,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 30,
                    width: 30,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(top: 20, right: 20, bottom: 20, left: 10),
                    child: Image.asset(AppAsset.icLeftArrow),
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    30.width,
                    RippleAnimation(
                      color: AppColors.timeTxtColor,
                      delay: const Duration(milliseconds: 300),
                      repeat: true,
                      minRadius: 50,
                      maxRadius: 80,
                      ripplesCount: 3,
                      duration: const Duration(milliseconds: 6 * 300),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.shimmerHighlightColor,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: CustomImage(
                          image: (Database.profileImage.startsWith("http")) ? Database.profileImage : "${Api.baseUrl}${Database.profileImage}",
                          fit: BoxFit.cover,
                          padding: 20,
                        ),
                      ),
                    ),
                    Image.asset(AppAsset.icMatchRing, height: 50, width: 50).paddingOnly(left: 30, right: 30),
                    RippleAnimation(
                      color: AppColors.timeTxtColor,
                      delay: const Duration(milliseconds: 300),
                      repeat: true,
                      minRadius: 50,
                      maxRadius: 80,
                      ripplesCount: 3,
                      duration: const Duration(milliseconds: 6 * 300),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.shimmerHighlightColor,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: CustomImage(
                          image: (logic.getAvailableHost?.image?.startsWith("http") == true)
                              ? (logic.getAvailableHost?.image ?? "")
                              : "${Api.baseUrl}${logic.getAvailableHost?.image}",
                          fit: BoxFit.cover,
                          padding: 20,
                        ),
                      ),
                    ),
                    30.width,
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    EnumLocale.txtItSMatch.name.tr,
                    style: GoogleFonts.pacifico(
                      color: AppColors.whiteColor,
                      fontSize: 35,
                    ),
                  ),
                  Text(
                    "${EnumLocale.txtYouAnd.name.tr} ${logic.getAvailableHost?.name} ${EnumLocale.txtHaveLikedEachOther.name.tr}",
                    textAlign: TextAlign.center,
                    style: AppFontStyle.styleW400(AppColors.whiteColor.withValues(alpha: 0.8), 18),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      if (Database.coin >
                          (Database.fetchLoginUserProfileModel?.user?.gender?.toLowerCase() == "male"
                              ? Database.maleRandomCallRate
                              : Database.fetchLoginUserProfileModel?.user?.gender?.toLowerCase() == "female"
                                  ? Database.femaleRandomCallRate
                                  : Database.generalRandomCallRate)) {
                        if (logic.getAvailableHost?.isFake == true) {
                          final random = Random();
                          final List<String>? videoList = logic.getAvailableHost?.video;
                          final String randomVideoUrl =
                              (videoList != null && videoList.isNotEmpty) ? videoList[random.nextInt(videoList.length)] : "";

                          Utils.showLog("randomVideoUrl****************** $randomVideoUrl");

                          Get.toNamed(AppRoutes.incomingHostCall, arguments: {
                            "hostName": logic.getAvailableHost?.name,
                            "hostImage": logic.getAvailableHost?.image,
                            "videoUrl": randomVideoUrl,
                            "agoraUID": 0,
                            "channel": logic.onGenerateRandomNumber(),
                            "hostUniqueId": logic.getAvailableHost?.uniqueId,
                            "hostId": logic.getAvailableHost?.id,
                            "gender": logic.selectedGender,
                            "callId": logic.getAvailableHost?.callId.toString(),
                            "callMode": "random",
                            "isBackProfile": false,
                            "callType": "video",
                          });
                        } else {
                          SocketEmit.onCallRingingStarted(
                            callerId: Database.loginUserId,
                            receiverId: logic.getAvailableHost?.id ?? "",
                            agoraUID: 0,
                            channel: logic.onGenerateRandomNumber(),
                            gender: logic.selectedGender ?? "both",
                            callerRole: "user",
                            receiverRole: "host",
                          );
                        }
                      } else {
                        Utils.showToast(EnumLocale.txtYouHaveInsufficientCoins.name.tr);
                        await 600.milliseconds.delay();
                        Get.toNamed(AppRoutes.topUpPage)?.then((val) => logic.update());
                      }
                    },
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: AppColors.gradientButtonColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAsset.icVideoRecord,
                            color: AppColors.whiteColor,
                            height: 25,
                            width: 25,
                          ),
                          10.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                EnumLocale.txtVideoCall.name.tr,
                                style: AppFontStyle.styleW800(AppColors.whiteColor, 16),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 15,
                                    child: Image.asset(AppAsset.coinIcon2),
                                  ),
                                  5.width,
                                  Text(
                                    "${(logic.selectedGender == "male" ? logic.getAvailableHost?.randomCallMaleRate : logic.selectedGender == "female" ? logic.getAvailableHost?.randomCallFemaleRate : logic.getAvailableHost?.randomCallRate).toString()}/min",
                                    style: AppFontStyle.styleW800(AppColors.whiteColor, 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  8.height,
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.chatPage,
                        arguments: {
                          "senderId": Database.loginUserId,
                          "hostId": logic.getAvailableHost?.id ?? "",
                          "hostName": logic.getAvailableHost?.name ?? "",
                          "profileImage": logic.getAvailableHost?.image ?? "",
                          "isOnline": logic.getAvailableHost?.isOnline ?? "",
                          "isChatHostDetail": false,
                          "isFake": logic.getAvailableHost?.isFake ?? false,
                        },
                      )?.then(
                        (value) {
                          Get.back();
                        },
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: AppColors.saveButton,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAsset.icMessageCall,
                            color: AppColors.whiteColor,
                            height: 22,
                            width: 22,
                          ),
                          8.width,
                          Text(
                            EnumLocale.txtSayHi.name.tr,
                            style: AppFontStyle.styleW800(AppColors.whiteColor, 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  25.height,
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      EnumLocale.txtContinueMatching.name.tr,
                      style: AppFontStyle.styleW400(
                        AppColors.colorGry.withValues(alpha: 0.5),
                        18,
                      ),
                    ),
                  ),
                ],
              ).paddingOnly(bottom: 30, top: 70),
            ],
          );
        },
      ),
    );
  }
}
