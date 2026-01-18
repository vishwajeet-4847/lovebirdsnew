import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:flutter/material.dart';

class PaymentRadioButtonUi extends StatelessWidget {
  const PaymentRadioButtonUi({super.key, required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      color: AppColors.transparent,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? null : AppColors.transparent,
              gradient: isSelected ? AppColors.hostNextButton : null,
            ),
            child: Container(
              height: 24,
              width: 24,
              margin: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? null : AppColors.transparent,
                border: Border.all(
                  color: isSelected
                      ? AppColors.whiteColor
                      : AppColors.primaryColor.withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
