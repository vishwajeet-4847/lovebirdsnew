import 'package:figgy/utils/colors_utils.dart';
import 'package:flutter/material.dart';

class GradiantBorderContainer extends StatelessWidget {
  const GradiantBorderContainer({super.key, required this.height, this.width, required this.radius, this.child});

  final double height;
  final double? width;
  final double radius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.settingColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          // color: AppColors.colorWhite.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(radius - 1),
        ),
        child: child,
      ),
    );
  }
}
