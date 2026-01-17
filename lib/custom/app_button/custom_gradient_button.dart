// ignore_for_file: must_be_immutable

import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomGradientButton extends StatelessWidget {
  double? height;
  double? width;
  double? borderRadius;
  double? textSize;
  double? vertical;
  double? horizontal;
  Gradient? gradient;
  String? text;
  TextStyle? textStyle;
  Color? textColor;
  void Function()? onTap;
  Widget? child;
  Widget? widget;
  BoxBorder? border;

  CustomGradientButton({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.textSize,
    this.vertical,
    this.horizontal,
    this.gradient,
    this.text,
    this.textStyle,
    this.textColor,
    this.onTap,
    this.child,
    this.widget,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: child ??
          Container(
            height: height ?? 50,
            width: width ?? Get.width,
            margin: EdgeInsets.symmetric(vertical: vertical ?? 10, horizontal: horizontal ?? 10),
            decoration: BoxDecoration(
              gradient: gradient ?? AppColors.hostNextButton,
              borderRadius: BorderRadius.circular(borderRadius ?? 50),
              border: border,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget ?? const Offstage(),
                  Text(
                    text ?? EnumLocale.txtNext.name.tr,
                    style: textStyle ?? AppFontStyle.styleW700(textColor ?? AppColors.whiteColor, textSize ?? 17),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
