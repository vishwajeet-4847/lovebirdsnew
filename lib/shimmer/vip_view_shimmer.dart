import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class VipViewShimmer extends StatelessWidget {
  const VipViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: Column(
        children: [
          25.height,
          Container(
            width: Get.width,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.shimmerBaseColor.withValues(alpha: 0.5),
            ),
            child: Column(
              children: [
                20.height,
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.shimmerBaseColor),
                ),
                18.height,
                Container(
                  height: 20,
                  width: 170,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.shimmerBaseColor),
                ),
                7.height,
                Container(
                  height: 20,
                  width: 210,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.shimmerBaseColor),
                ),
                19.height,
              ],
            ),
          ),

          const SizedBox(height: 20),

          // VIP Plan List Shimmer
          SizedBox(
            height: 130,
            child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (_, __) => Container(
                width: 100,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.shimmerBaseColor,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      color: AppColors.shimmerBaseColor,
                    )
                  ],
                ),
              ),
            ),
          ),

          20.height,

          // Pay Now Button Shimmer
          Container(
            height: 55,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
