import 'package:figgy/common/gradiant_text.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VipCarouselWidget extends StatelessWidget {
  const VipCarouselWidget({
    super.key,
    required this.title,
    this.textSpan1,
    this.textSpan2,
    this.textSpan3,
    required this.image,
  });

  final String title;
  final String? textSpan1;
  final String? textSpan2;
  final String? textSpan3;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        color: AppColors.whiteColor.withValues(alpha: 0.06),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 100,
            width: 100,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GradientText(
                  text: title,
                  style: AppFontStyle.styleW800(AppColors.whiteColor, 20),
                  gradient: const LinearGradient(colors: [AppColors.pinkColor, AppColors.blueColor])),
              2.height,
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: textSpan1,
                      style: AppFontStyle.styleW500(AppColors.whiteColor.withValues(alpha: 0.70), 14),
                    ),
                    TextSpan(
                      text: textSpan2,
                      style: AppFontStyle.styleW500(AppColors.whiteColor.withValues(alpha: 0.70), 14),
                    ),
                    TextSpan(
                      text: textSpan3,
                      style: AppFontStyle.styleW500(AppColors.whiteColor.withValues(alpha: 0.70), 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
