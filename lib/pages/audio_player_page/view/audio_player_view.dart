import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/pages/audio_player_page/controller/audio_player_controller.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AudioPlayerView extends GetView<AudioPlayerController> {
  const AudioPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );

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
        body: GetBuilder<AudioPlayerController>(
          id: AppConstant.idOnAudioCall,
          builder: (logic) {
            return Stack(
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
                                image: logic.hostImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    10.height,
                    Text(
                      logic.hostName,
                      style: AppFontStyle.styleW800(AppColors.whiteColor, 24),
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
                            color: AppColors.whiteColor.withValues(alpha: 0.12),
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
                        GestureDetector(
                          onTap: () => logic.toggleSpeaker(),
                          child: Container(
                            height: 50,
                            width: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:
                                  AppColors.whiteColor.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              color: AppColors.whiteColor,
                              logic.isSpeakerOn
                                  ? AppAsset.icSpeakerOn
                                  : AppAsset.icSpeakerOff,
                              height: 30,
                            ),
                          ),
                        ),
                        30.width,
                        GestureDetector(
                          onTap: () {
                            if (logic.isBackProfile) {
                              Get.back();
                            } else {
                              Get.back();
                              Get.back();
                            }
                          },
                          child: Image.asset(
                            AppAsset.imgCallCancel,
                            height: 70,
                          ),
                        ),
                        30.width,
                        GestureDetector(
                          onTap: () => logic.muteMic(),
                          child: Container(
                            height: 50,
                            width: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:
                                  AppColors.whiteColor.withValues(alpha: 0.2),
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
                        ),
                      ],
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
