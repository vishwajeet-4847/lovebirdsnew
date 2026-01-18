import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class WithdrawShimmerUi extends StatelessWidget {
  const WithdrawShimmerUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            15.height,
            Container(
              height: 148,
              width: Get.width,
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  color: AppColors.blackColor,
                  borderRadius: BorderRadius.circular(30)),
            ),
            Container(
              height: 25,
              width: 150,
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                  color: AppColors.blackColor,
                  borderRadius: BorderRadius.circular(8)),
            ),
            Container(
              height: 54,
              width: Get.width,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: AppColors.blackColor,
                  borderRadius: BorderRadius.circular(15)),
            ),
            Container(
              height: 25,
              width: 150,
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                  color: AppColors.blackColor,
                  borderRadius: BorderRadius.circular(8)),
            ),
            Container(
              height: 54,
              width: Get.width,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: AppColors.blackColor,
                  borderRadius: BorderRadius.circular(15)),
            ),
            const Spacer(),
            Container(
              height: 54,
              width: Get.width,
              margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
              decoration: BoxDecoration(
                  color: AppColors.blackColor,
                  borderRadius: BorderRadius.circular(50)),
            ),
          ],
        ),
      ),
    );
  }
}
