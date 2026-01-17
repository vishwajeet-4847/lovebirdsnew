import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StopLiveDialog extends StatelessWidget {
  const StopLiveDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 410,
      width: 330,
      padding: const EdgeInsets.all(15),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(AppAsset.icLogOut, width: 90),
              10.height,
              Text(
                EnumLocale.txtStopLive.name.tr,
                style: AppFontStyle.styleW700(AppColors.blackColor, 24),
              ),
              10.height,
              Text(
                textAlign: TextAlign.center,
                EnumLocale.txtStopLiveText.name.tr,
                style: AppFontStyle.styleW400(AppColors.colorTextGrey, 12),
              ),
              20.height,
              GestureDetector(
                onTap: () {
                  Get.close(3);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.colorLightRedBg,
                  ),
                  height: 52,
                  width: Get.width,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          EnumLocale.txtStop.name.tr,
                          style: AppFontStyle.styleW700(AppColors.redColor, 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              10.height,
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.colorGreyBg,
                  ),
                  height: 52,
                  width: Get.width,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(EnumLocale.txtCancel.name.tr, style: AppFontStyle.styleW700(AppColors.coloGreyText, 16)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
