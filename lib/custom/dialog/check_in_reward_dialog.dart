import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

void showBlockedUserDialog({required int coin}) {
  Get.dialog(
    barrierColor: AppColors.blackColor.withValues(alpha: 0.8),
    WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: AppColors.checkInDialog,
                image: const DecorationImage(
                  image: AssetImage(AppAsset.imCheckInReward),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(36),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    "Congratulation.!",
                    style: AppFontStyle.styleW700(AppColors.rewardColor, 28).copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "You Earned",
                    style: AppFontStyle.styleW900(AppColors.rewardColor, 40).copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        coin.toString(),
                        style: AppFontStyle.styleW800(AppColors.rewardColor, 34),
                      ),
                      Text(
                        " Coins",
                        style: AppFontStyle.styleW700(AppColors.rewardColor, 26).copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 52,
                      width: Get.width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: AppColors.gradientButtonColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          "Done",
                          style: AppFontStyle.styleW700(AppColors.whiteColor, 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -60,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  AppAsset.rechargeCoin,
                  width: 285,
                  height: 161,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Lottie.asset(AppAsset.lottieCannon),
              ),
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
