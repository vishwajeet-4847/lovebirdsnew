import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class ImagePickerBottomSheetUi {
  static Future<void> show({
    required BuildContext context,
    required Callback onClickGallery,
    required Callback onClickCamera,
    String? mainTitle,
    String? title,
  }) async {
    await showModalBottomSheet(
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
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top),
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
                        mainTitle ?? EnumLocale.txtChooseImage.name.tr,
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
                          Get.back();
                          onClickGallery.call();
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            gradient: AppColors.audioCallButtonGradient,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: AppColors.whiteColor),
                            color: AppColors.redColor,
                          ),
                          child: Image.asset(
                            AppAsset.icGalleryGradiant,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                      10.height,
                      Text(
                        EnumLocale.txtGallery.name.tr,
                        style: AppFontStyle.styleW400(AppColors.whiteColor, 13),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Get.back();
                          onClickCamera.call();
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            gradient: AppColors.videoCallButtonGradient,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: AppColors.whiteColor),
                            color: AppColors.redColor,
                          ),
                          child: Image.asset(
                            AppAsset.icCameraGradiant,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                      10.height,
                      Text(
                        title ?? EnumLocale.txtTakePhoto.name.tr,
                        style: AppFontStyle.styleW400(AppColors.whiteColor, 13),
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
}
