// ignore_for_file: must_be_immutable

import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  TextStyle? textStyle;
  Color? textColor;
  double? textSize;
  double? padding;

  CustomTitle({
    super.key,
    required this.title,
    this.textStyle,
    this.textColor,
    this.textSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textStyle ??
          AppFontStyle.styleW700(
            textColor ?? AppColors.whiteColor,
            textSize ?? 17,
          ),
    ).paddingOnly(bottom: padding ?? 10);
  }
}

class CustomTitle1 extends StatelessWidget {
  final String title;
  TextStyle? textStyle;
  Color? textColor;
  double? textSize;
  double? padding;

  CustomTitle1({
    super.key,
    required this.title,
    this.textStyle,
    this.textColor,
    this.textSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textStyle ??
          AppFontStyle.styleW500(
            textColor ?? AppColors.walletTxtColor,
            textSize ?? 14,
          ),
    ).paddingOnly(bottom: padding ?? 10);
  }
}

class HostDetailTitle extends StatelessWidget {
  final String title;

  const HostDetailTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppFontStyle.styleW600(AppColors.colorHostTitle, 15),
    );
  }
}
