import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:flutter/material.dart';

class CustomRadioButtonWidget extends StatelessWidget {
  const CustomRadioButtonWidget(
      {super.key,
      required this.isSelected,
      required this.size,
      required this.borderColor,
      required this.activeColor});

  final bool isSelected;
  final double size;
  final Color borderColor;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: AppColors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor),
      ),
      child: Visibility(
        visible: isSelected,
        child: Container(
          margin: const EdgeInsets.all(1.2),
          decoration: BoxDecoration(
            color: AppColors.selectGender,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
