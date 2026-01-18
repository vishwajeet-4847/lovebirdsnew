import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VipButtonWidget extends StatelessWidget {
  const VipButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 56,
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            gradient: AppColors.payNowGradient,
          ),
          child: Center(
            child: Text(
              EnumLocale.txtContinue.name.tr,
              style: AppFontStyle.styleW600(AppColors.whiteColor, 18),
            ),
          ),
        ),
      ],
    );
  }
}
