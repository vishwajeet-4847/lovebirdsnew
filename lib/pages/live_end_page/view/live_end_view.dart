import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:figgy/custom/custom_image/custom_profile_image.dart';
import 'package:figgy/pages/live_end_page/controller/live_end_controller.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LiveEndScreen extends StatelessWidget {
  const LiveEndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        Get.back();
        return false;
      },
      child: Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          color: AppColors.blackColor,
          child: GetBuilder<LiveEndController>(
            builder: (logic) {
              return Stack(
                children: [
                  Container(
                    color: AppColors.colorTextGrey.withValues(alpha: 0.22),
                    height: Get.height,
                    width: Get.width,
                    child: CustomImage(
                      image: logic.hostImage,
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
                  Positioned(
                    top: 40,
                    child: SizedBox(
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: Container(
                                height: 50,
                                width: 178,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(56),
                                  border: Border.all(
                                    color: AppColors.whiteColor.withValues(alpha: 0.2),
                                  ),
                                  color: AppColors.whiteColor.withValues(alpha: 0.12),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    5.width,
                                    Container(
                                      height: 40,
                                      width: 40,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.colorTextGrey.withValues(alpha: 0.22),
                                      ),
                                      child: Stack(
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 1,
                                            child: Image.asset(AppAsset.icProfilePlaceHolder),
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 95,
                                          child: Text(
                                            logic.hostName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppFontStyle.styleW600(AppColors.whiteColor, 14),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(AppAsset.icEye, width: 18),
                                            5.width,
                                            Text(
                                              "0",
                                              maxLines: 1,
                                              style: AppFontStyle.styleW700(AppColors.whiteColor, 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                Get.back();
                                Get.back();
                              },
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
                                child: Image.asset(
                                  AppAsset.icClose,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                              color: AppColors.colorTextGrey.withValues(alpha: 0.22),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: CustomImage(
                              image: logic.hostImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        3.height,
                        Text(
                          EnumLocale.txtLiveEnd.name.tr,
                          style: AppFontStyle.styleW700(AppColors.whiteColor, 20),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
