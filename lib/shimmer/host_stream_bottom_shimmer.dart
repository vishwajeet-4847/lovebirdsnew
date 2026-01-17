import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DiscoverHostForUserShimmer extends StatelessWidget {
  const DiscoverHostForUserShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.shimmerBaseColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 15,
                      width: 80,
                      decoration: BoxDecoration(color: AppColors.shimmerHighlightColor, borderRadius: BorderRadius.circular(20)),
                    ),
                    8.height,
                    Row(
                      children: [
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(color: AppColors.shimmerHighlightColor, shape: BoxShape.circle),
                        ),
                        5.width,
                        Container(
                          height: 14,
                          width: 80,
                          decoration: BoxDecoration(color: AppColors.shimmerHighlightColor, borderRadius: BorderRadius.circular(20)),
                        ),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(color: AppColors.shimmerHighlightColor, shape: BoxShape.circle),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
