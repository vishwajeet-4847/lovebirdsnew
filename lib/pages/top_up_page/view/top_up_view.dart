import 'package:figgy/pages/top_up_page/widget/top_up_bg_widget.dart';
import 'package:figgy/pages/top_up_page/widget/top_up_bottom_widget.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopUpView extends StatelessWidget {
  const TopUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Stack(
        children: [
          const TopUpBgWidget(),
          Container(
            height: MediaQuery.of(context).viewPadding.top + 72,
            padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top, left: 15, right: 15),
            alignment: Alignment.center,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.topUpColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: Get.back,
                  child: Container(
                    height: 45,
                    width: 45,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      AppAsset.icLeftArrow,
                      width: 10,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  EnumLocale.txtMyWallet.name.tr,
                  style: AppFontStyle.styleW700(AppColors.whiteColor, 20),
                ).paddingOnly(right: 45),
                const Spacer(),
              ],
            ),
          ),
          const TopUpBottomWidget(),
        ],
      ),
    );
  }
}
