import 'package:country_picker/country_picker.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCountryPicker {
  static String? name;

  static void pickCountry(
    final BuildContext context,
    final bool showWorldWide,
    final Function(Country) onSelect,
  ) {
    showCountryPicker(
      context: context,
      showWorldWide: showWorldWide,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: AppColors.colorChat,
        textStyle: AppFontStyle.styleW500(AppColors.whiteColor, 15),
        searchTextStyle: AppFontStyle.styleW500(AppColors.whiteColor, 15),
        bottomSheetHeight: Get.height / 1.5,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        inputDecoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          labelText: EnumLocale.txtCountry.name.tr,
          labelStyle: AppFontStyle.styleW400(AppColors.whiteColor, 14),
          hintText: EnumLocale.txtSearchCountry.name.tr,
          hintStyle: AppFontStyle.styleW400(AppColors.whiteColor, 14),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.whiteColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: AppColors.whiteColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: AppColors.whiteColor),
          ),
        ),
      ),
      onSelect: (Country country) {
        Utils.showLog("country :: ${country.countryCode}");
        Utils.showLog("country :: ${country.flagEmoji}");
        onSelect(country);
      },
    );
  }
}
