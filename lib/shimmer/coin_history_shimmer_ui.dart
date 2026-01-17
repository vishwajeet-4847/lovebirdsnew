import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class CoinHistoryShimmerUi extends StatelessWidget {
  const CoinHistoryShimmerUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: ListView.builder(
        itemCount: 15,
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
            height: 70,
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.blackColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                10.width,
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.colorGry.withValues(alpha: 0.4),
                    ),
                  ),
                ),
                10.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 12,
                        margin: const EdgeInsets.only(bottom: 3),
                        decoration: BoxDecoration(color: AppColors.blackColor, borderRadius: BorderRadius.circular(5)),
                      ),
                      Container(
                        height: 12,
                        margin: const EdgeInsets.only(bottom: 3),
                        decoration: BoxDecoration(color: AppColors.blackColor, borderRadius: BorderRadius.circular(5)),
                      ),
                      Container(
                        height: 12,
                        decoration: BoxDecoration(color: AppColors.blackColor, borderRadius: BorderRadius.circular(5)),
                      ),
                    ],
                  ),
                ),
                10.width,
                Container(
                  height: 32,
                  width: 70,
                  decoration: BoxDecoration(
                    color: AppColors.blackColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                10.width,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
