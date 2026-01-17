import 'package:figgy/pages/splash_screen_page/controller/splash_screen_controller.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);

    return Scaffold(
      body: Center(
        child: GetBuilder<SplashScreenController>(
          builder: (logic) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(gradient: AppColors.gradientButtonColor),
                  child: Image.asset(
                    AppAsset.splashScreenImage2,
                    fit: BoxFit.cover,
                    height: Get.height,
                    width: Get.width,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 25,
                  child: Lottie.asset(
                    AppAsset.lottieLoader,
                    height: 70,
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
