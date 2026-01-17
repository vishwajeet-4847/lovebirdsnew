import 'package:figgy/custom/app_title/custom_title.dart';
import 'package:figgy/pages/host_detail_page/controller/host_detail_controller.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostDetailLanguageWidget extends StatelessWidget {
  const HostDetailLanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HostDetailTitle(title: EnumLocale.txtLanguages.name.tr).paddingOnly(left: 14),
        10.height,
        GetBuilder<HostDetailController>(
          builder: (logic) {
            return Wrap(
              spacing: 12,
              runSpacing: 2,
              children: logic.language.map(
                (text) {
                  return Chip(
                    label: Text(
                      text,
                      style: AppFontStyle.styleW600(
                        AppColors.whiteColor,
                        15,
                      ),
                    ),
                    backgroundColor: AppColors.languageBgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: AppColors.whiteColor.withValues(alpha: 0.20), width: 0.6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    labelPadding: EdgeInsets.zero,
                  );
                },
              ).toList(),
            ).paddingOnly(right: 14, left: 14);
          },
        ),
        16.height,
        HostDetailTitle(title: EnumLocale.txtImpression.name.tr).paddingOnly(left: 14),
        10.height,
        GetBuilder<HostDetailController>(
          builder: (logic) {
            return Wrap(
              spacing: 12,
              runSpacing: 2,
              children: logic.impression.map(
                (text) {
                  return Chip(
                    label: Text(
                      text,
                      style: AppFontStyle.styleW600(
                        AppColors.whiteColor,
                        15,
                      ),
                    ),
                    backgroundColor: AppColors.impressionBgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: AppColors.whiteColor.withValues(alpha: 0.20), width: 0.6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                    labelPadding: EdgeInsets.zero,
                  );
                },
              ).toList(),
            ).paddingOnly(right: 14, left: 14);
          },
        ),
        18.height,
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String icon;
  final String? rate;
  final Color? bgColor;
  final Gradient gradient;
  final double? width;
  final Color? color;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.icon,
    this.rate,
    this.bgColor,
    this.width,
    required this.gradient,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: bgColor,
          gradient: gradient,
          border: Border.all(color: AppColors.whiteColor.withValues(alpha: 0.18)),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 28,
              height: 28,
              color: color,
            ),
            SizedBox(width: width ?? 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: AppFontStyle.styleW800(Colors.white, 14),
                ),
                if (rate != null)
                  Row(
                    children: [
                      Image.asset(
                        AppAsset.icCoin,
                        width: 12,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        rate!,
                        style: AppFontStyle.styleW800(Colors.white, 10),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
