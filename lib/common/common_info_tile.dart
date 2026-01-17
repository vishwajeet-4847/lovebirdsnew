import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class CommonInfoTile extends StatelessWidget {
  final String? text;
  final String? imageAsset;
  final String? backgroundAsset;
  final double? width;
  final Gradient? gradient;
  final void Function()? onTap;

  const CommonInfoTile({
    super.key,
    this.text,
    this.imageAsset,
    this.backgroundAsset,
    this.onTap,
    this.width,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        width: width,
        decoration: BoxDecoration(
            color: const Color(0xff9B8B8B).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.whiteColor.withValues(alpha: 0.16))),
        child: Row(
          children: [
            Container(
              height: 54,
              width: 54,
              decoration: BoxDecoration(
                gradient: gradient,
                border: Border.all(
                  color: AppColors.whiteColor.withValues(alpha: 0.11),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.whiteColor.withValues(alpha: 0.10),
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: const Offset(0, 0),
                  ),
                ],
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Image.asset(
                  imageAsset ?? "",
                  height: 34,
                  width: 34,
                ),
              ),
            ).paddingOnly(left: 5),
            20.width,
            Text(
              text ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppFontStyle.styleW600(AppColors.whiteColor, 18),
            ),
            const Spacer(),
            Image.asset(
              AppAsset.purpleForward,
              height: 22,
              width: 22,
              color: AppColors.iconColor,
            ).paddingOnly(right: 12),
          ],
        ),
      ),
    );
  }
}
