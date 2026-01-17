import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HostViewShimmer extends StatelessWidget {
  const HostViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 380,
            width: Get.width,
            decoration: BoxDecoration(color: AppColors.shimmerBaseColor.withValues(alpha: 0.5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 30,
                  width: 160,
                  decoration: BoxDecoration(color: AppColors.shimmerBaseColor, borderRadius: BorderRadius.circular(20)),
                ).paddingOnly(bottom: 15, right: 10),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.shimmerBaseColor.withValues(alpha: 0.5)),
              ).paddingOnly(left: 10, top: 18),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 15,
                    width: 120,
                    decoration: BoxDecoration(
                      color: AppColors.shimmerBaseColor.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ).paddingOnly(bottom: 10),
                  Container(
                    height: 15,
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.shimmerBaseColor.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ).paddingOnly(bottom: 10),
                  Container(
                    height: 15,
                    width: 80,
                    decoration: BoxDecoration(
                      color: AppColors.shimmerBaseColor.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  )
                ],
              ).paddingOnly(left: 10),
              const Spacer(),
              Container(
                height: 66,
                width: 90,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    color: AppColors.shimmerBaseColor.withValues(alpha: 0.5)),
              )
            ],
          ),
          20.height,
          Container(
            height: 20,
            width: 90,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.shimmerBaseColor.withValues(alpha: 0.5)),
          ).paddingOnly(left: 10),
          Container(
            height: 80,
            width: Get.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.shimmerBaseColor.withValues(alpha: 0.5)),
          ).paddingOnly(left: 10, right: 10, top: 12),
          Container(
            height: 20,
            width: 90,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.shimmerBaseColor.withValues(alpha: 0.5)),
          ).paddingOnly(left: 10, top: 20),
          Row(
            children: [
              Container(
                height: 38,
                width: 100,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.shimmerBaseColor.withValues(alpha: 0.5)),
              ).paddingOnly(
                left: 10,
              ),
              Container(
                height: 38,
                width: 120,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.shimmerBaseColor.withValues(alpha: 0.5)),
              ).paddingOnly(left: 10),
              Container(
                height: 38,
                width: 90,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.shimmerBaseColor.withValues(alpha: 0.5)),
              ).paddingOnly(left: 10),
            ],
          ).paddingOnly(top: 12),
          Row(
            children: [
              Container(
                height: 38,
                width: 150,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.shimmerBaseColor.withValues(alpha: 0.5)),
              ).paddingOnly(left: 10),
              Container(
                height: 38,
                width: 100,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.shimmerBaseColor.withValues(alpha: 0.5)),
              ).paddingOnly(left: 10),
              Container(
                height: 38,
                width: 80,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.shimmerBaseColor.withValues(alpha: 0.5)),
              ).paddingOnly(left: 10),
            ],
          ).paddingOnly(top: 12),
          Container(
            height: 20,
            width: 90,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.shimmerBaseColor.withValues(alpha: 0.5)),
          ).paddingOnly(left: 10, top: 20),
        ],
      ),
    );
  }
}
