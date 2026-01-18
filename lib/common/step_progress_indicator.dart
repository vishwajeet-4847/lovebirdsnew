import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepProgressIndicator extends StatelessWidget {
  final int currentStep;

  const StepProgressIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    List<String> steps = [
      EnumLocale.txtUploadImage.name.tr,
      EnumLocale.txtSelectImpLan.name.tr,
      EnumLocale.txtUploadDocument.name.tr,
    ];

    return SizedBox(
      height: 90,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            top: 15,
            left: 0,
            right: 0,
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.whiteColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          if (currentStep > 0)
            Positioned(
              top: 15,
              left: 0,
              right: (3 - currentStep) / 3 * Get.width,
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.pinkColor, AppColors.blueColor],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(steps.length, (index) {
              bool isCompleted = index < currentStep;
              bool isCurrent = index == currentStep;

              Color? circleColor;
              Gradient? circleGradient;

              if (isCurrent) {
                if (index == 0) {
                  circleColor = Colors.transparent; // solid red if first step
                } else {
                  circleColor = AppColors.indicatorCircleColor;
                }
              } else if (isCompleted) {
                circleGradient = const LinearGradient(
                  colors: [AppColors.pinkColor, AppColors.blueColor],
                );
              } else {
                circleColor = AppColors.indicatorCircleColor;
              }

              return Column(
                children: [
                  Container(
                    height: 34,
                    width: 34,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: circleGradient == null ? circleColor : null,
                      gradient: circleGradient,
                      border: Border.all(
                          color: AppColors.indicatorBorderColor, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: AppFontStyle.styleW700(AppColors.whiteColor, 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    steps[index],
                    style: AppFontStyle.styleW700(
                        isCompleted
                            ? AppColors.whiteColor
                            : AppColors.indicatorTxtColor,
                        11),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
