import 'package:figgy/custom/radio_button/custom_radio_button.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class GenderButtonWidget extends StatelessWidget {
  const GenderButtonWidget({
    super.key,
    required this.title,
    required this.image,
    required this.isSelected,
    required this.callback,
  });

  final String title;
  final String image;
  final bool isSelected;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: callback,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: AppColors.settingColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(image, width: 38),
              18.width,
              Text(
                title,
                style: AppFontStyle.styleW700(AppColors.whiteColor, 16),
              ),
              const Spacer(),
              CustomRadioButtonWidget(
                isSelected: isSelected,
                size: 22,
                borderColor: isSelected ? AppColors.selectGender : AppColors.colorGry1,
                activeColor: AppColors.transparent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
