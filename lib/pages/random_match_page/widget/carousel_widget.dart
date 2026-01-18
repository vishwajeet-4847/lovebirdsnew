import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget(
      {super.key,
      required this.title,
      this.textSpan1,
      this.textSpan2,
      this.textSpan3,
      this.image});

  final String title;
  final String? textSpan1;
  final String? textSpan2;
  final String? textSpan3;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: AppColors.whiteColor.withValues(alpha: 0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          10.height,
          Image.network(
            image ?? "",
            height: 70,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                textAlign: TextAlign.end,
                style: AppFontStyle.styleW400(AppColors.colorGoldButton, 20),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: textSpan1,
                      style: AppFontStyle.styleW400(AppColors.colorGry, 12),
                    ),
                    TextSpan(
                      text: textSpan2,
                      style:
                          AppFontStyle.styleW400(AppColors.colorGoldButton, 12),
                    ),
                    TextSpan(
                      text: textSpan3,
                      style: AppFontStyle.styleW400(AppColors.colorGry, 12),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
