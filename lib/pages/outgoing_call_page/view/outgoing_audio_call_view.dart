import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/pages/outgoing_call_page/controller/out_going_controller.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutGoingAudioCallView extends StatelessWidget {
  const OutGoingAudioCallView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OutGoingCall>(
        builder: (logic) {
          return Stack(
            children: [
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: CustomImage(
                  image: logic.receiverImage ?? "",
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
                    Container(
                      alignment: Alignment.center,
                      width: Get.width,
                      child: Text(
                        logic.callType == 'video'
                            ? "Video call..."
                            : "Audio call...",
                        maxLines: 1,
                        style: AppFontStyle.styleW400(AppColors.whiteColor, 20),
                      ),
                    ),
                    50.height,
                    Container(
                      height: 110,
                      width: 110,
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
                          image: logic.receiverImage ?? "",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    15.height,
                    Container(
                      alignment: Alignment.center,
                      width: Get.width,
                      child: Text(
                        logic.receiverName ?? "",
                        maxLines: 1,
                        style: AppFontStyle.styleW800(AppColors.whiteColor, 22),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () => logic.onCallCut(),
                          child: Image.asset(
                            AppAsset.imgCallCancel,
                            height: 70,
                          ),
                        ),
                      ],
                    ),
                    70.height,
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
