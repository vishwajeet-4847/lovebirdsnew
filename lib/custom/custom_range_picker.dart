import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:flutter/material.dart';

class CustomRangePicker {
  static Future<DateTimeRange?> onShow(
    BuildContext context,
    DateTimeRange? initialDateRange,
  ) async {
    return await showRangePickerDialog(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      context: context,
      slidersColor: AppColors.blackColor,
      maxDate: DateTime.now(),
      selectedRange: initialDateRange,
      minDate: DateTime(1900, 1, 1),
      barrierColor: AppColors.blackColor.withValues(alpha: 0.8),
      selectedCellsTextStyle: AppFontStyle.styleW500(AppColors.blackColor, 16),
      enabledCellsTextStyle: AppFontStyle.styleW500(AppColors.blackColor, 16),
      disabledCellsTextStyle: AppFontStyle.styleW500(AppColors.colorGry, 16),
      singleSelectedCellTextStyle:
          AppFontStyle.styleW500(AppColors.whiteColor, 14),
      singleSelectedCellDecoration:
          BoxDecoration(color: AppColors.primaryColor, shape: BoxShape.circle),
      currentDateTextStyle: AppFontStyle.styleW500(
        initialDateRange == null ? AppColors.whiteColor : AppColors.blackColor,
        16,
      ),
      currentDateDecoration: BoxDecoration(
        color: initialDateRange == null
            ? AppColors.secondaryColor
            : AppColors.transparent,
        shape: BoxShape.circle,
      ),
      daysOfTheWeekTextStyle: AppFontStyle.styleW500(
          AppColors.blackColor.withValues(alpha: 0.6), 14),
      leadingDateTextStyle: AppFontStyle.styleW500(AppColors.blackColor, 20),
      centerLeadingDate: true,
    );
  }
}
