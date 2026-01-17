import 'package:figgy/common/loading_widget.dart';
import 'package:figgy/pages/random_match_page/controller/random_match_controller.dart';
import 'package:figgy/pages/random_match_page/widget/background_image_widget.dart';
import 'package:figgy/pages/random_match_page/widget/random_bottom_view_widget.dart';
import 'package:figgy/pages/random_match_page/widget/top_view_widget.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RandomMatchView extends StatelessWidget {
  const RandomMatchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RandomMatchController>(
        id: AppConstant.idRandomMatchView,
        builder: (logic) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  logic.getAvailableHostApi();
                },
                child: Stack(
                  children: [
                    const BackgroundImageRandomPageWidget(),
                    Lottie.asset(
                      AppAsset.lottieMatch,
                      height: 700,
                      width: Get.width,
                    ),
                    const RandomTopViewWidget(),
                    const RandomBottomViewWidget(),
                  ],
                ),
              ),
              if (logic.isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.4),
                    child: const Center(
                      child: LoadingWidget(),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
