import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VipAppBarWidget extends StatelessWidget {
  const VipAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: Get.back,
          child: Container(
            height: 45,
            width: 45,
            alignment: Alignment.center,
            child: Image.asset(
              AppAsset.icLeftArrow,
              width: 10,
            ),
          ),
        ),
        Text(
          EnumLocale.txtVipMember.name.tr,
          style: AppFontStyle.styleW700(AppColors.whiteColor, 20),
        ),
        const SizedBox(width: 45),
      ],
    );
  }
}
