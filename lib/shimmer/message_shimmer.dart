import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MessageContainerShimmer extends StatelessWidget {
  const MessageContainerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: 60,
      child: Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.shimmerHighlightColor,
        child: Row(
          children: [
            // Profile shimmer circle
            ClipRRect(
              borderRadius: BorderRadius.circular(27.5),
              child: Container(
                height: 55,
                width: 55,
                color: AppColors.whiteColor,
              ),
            ),
            const SizedBox(width: 10),
            // Name and message shimmer lines
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 15,
                      width: 120,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 12,
                      width: 200,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
