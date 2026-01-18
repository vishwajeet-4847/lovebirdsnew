import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:flutter/material.dart';

class ImpressionWidget extends StatelessWidget {
  const ImpressionWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.colorUnSelectedImpression,
        borderRadius: BorderRadius.circular(50),
      ),
      child:
          Text(text, style: AppFontStyle.styleW600(AppColors.whiteColor, 12)),
    );
  }
}
