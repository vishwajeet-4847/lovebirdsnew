import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class TermsAndConditionView extends StatelessWidget {
  const TermsAndConditionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAsset.allBackgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).viewPadding.top + 72,
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
              alignment: Alignment.center,
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.chatDetailTopColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blackColor.withValues(alpha: 0.40),
                    offset: const Offset(0, -6),
                    blurRadius: 34,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Text(
                    EnumLocale.txtTermsAndConditions.name.tr,
                    style: AppFontStyle.styleW700(AppColors.whiteColor, 20),
                  ),
                  45.width,
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Html(
                  data: Database.termsAndConditions,
                  style: {
                    "body": Style(
                      fontSize: FontSize(18),
                      color: AppColors.whiteColor,
                      margin: Margins.zero,
                      padding: HtmlPaddings.only(top: 25),
                    ),
                    "h4": Style(
                      fontSize: FontSize(24),
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                      margin: Margins.zero,
                      padding: HtmlPaddings.only(top: 25),
                    ),
                    "h5": Style(
                      fontSize: FontSize(22),
                      color: AppColors.whiteColor,
                      margin: Margins.zero,
                      padding: HtmlPaddings.only(top: 25),
                    ),
                    "h6": Style(
                      fontSize: FontSize(20),
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor,
                      margin: Margins.zero,
                      padding: HtmlPaddings.only(top: 25),
                    ),
                    "p": Style(
                      fontSize: FontSize(18),
                      color: AppColors.whiteColor,
                      lineHeight: const LineHeight(1.5),
                      margin:
                          Margins.zero, // You can keep a little bottom margin
                      padding: HtmlPaddings.only(top: 25),
                    ),
                  },
                ).paddingOnly(left: 25, right: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
