import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/pages/outgoing_host_call_page/controller/outgoing_host_call_controller.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OutgoingHostCallView extends GetView<OutgoingHostCallController> {
  const OutgoingHostCallView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: Scaffold(
        body: GetBuilder<OutgoingHostCallController>(
          builder: (logic) {
            return Stack(
              children: [
                SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: CustomImage(
                    image: logic.hostImage,
                    fit: BoxFit.cover,
                  ),
                ),
                BlurryContainer(
                  blur: 6,
                  height: Get.height,
                  width: Get.width,
                  elevation: 0,
                  color: AppColors.blackColor.withValues(alpha: 0.2),
                  child: const SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      60.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            EnumLocale.txtIncomingVideoCall.name.tr,
                            maxLines: 1,
                            style: AppFontStyle.styleW400(
                                AppColors.whiteColor, 20),
                          ),
                          Lottie.asset(
                            AppAsset.lottieLoading,
                            height: 30,
                          ).paddingOnly(top: 10),
                        ],
                      ),
                      50.height,
                      Container(
                        height: 114,
                        width: 114,
                        padding: const EdgeInsets.all(2),
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
                            color: AppColors.shimmerHighlightColor,
                          ),
                          child: CustomImage(
                            image: logic.hostImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      15.height,
                      Container(
                        alignment: Alignment.center,
                        width: Get.width,
                        child: Text(
                          logic.hostName,
                          maxLines: 1,
                          style:
                              AppFontStyle.styleW800(AppColors.whiteColor, 22),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Image.asset(
                              AppAsset.imgCallCancel,
                              height: 70,
                            ),
                          ),
                          10.width,
                          GestureDetector(
                            onTap: () {
                              Get.back();
                              Get.toNamed(AppRoutes.hostVideoCall, arguments: {
                                "hostName": logic.hostName,
                                "hostImage": logic.hostImage,
                                "videoUrl": logic.videoUrl,
                                "agoraUID": logic.agoraUID,
                                "channel": logic.channel,
                                "hostUniqueId": logic.hostUniqueId,
                                "hostId": logic.hostId,
                                "gender": logic.gender,
                                "callId": logic.callId,
                                "callMode": logic.callMode,
                                "isBackProfile": true,
                              });
                            },
                            child: Lottie.asset(
                              AppAsset.lottieAnswer,
                              height: 70,
                            ),
                          ),
                        ],
                      ),
                      100.height,
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
