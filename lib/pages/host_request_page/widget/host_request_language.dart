import 'dart:developer';

import 'package:LoveBirds/pages/host_request_page/controller/host_request_controller.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostRequestLanguagePicker {
  static void pickLanguageForHostRequest(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      clipBehavior: Clip.antiAlias,
      builder: (context) {
        return GetBuilder<HostRequestController>(builder: (logic) {
          return Container(
            height: Get.height * 0.68,
            width: Get.width,
            decoration: BoxDecoration(
              gradient: AppColors.callOptionBottomSheet,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).viewPadding.top + 60,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).viewPadding.top),
                  alignment: Alignment.center,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor.withValues(alpha: 0.1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        28.width,
                        Text(
                          EnumLocale.txtSelectLanguage.name.tr,
                          style:
                              AppFontStyle.styleW700(AppColors.whiteColor, 18),
                        ),
                        GestureDetector(
                          onTap: Get.back,
                          child: Container(
                            height: 25,
                            width: 25,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color:
                                  AppColors.whiteColor.withValues(alpha: 0.5),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              AppAsset.icCloseDialog,
                              width: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                15.height,
                TextFormField(
                  controller: logic.languageSearchController,
                  onChanged: (value) {
                    logic.onLanguageSearch(value);
                    logic.update();
                  },
                  style: AppFontStyle.styleW400(AppColors.whiteColor, 17),
                  decoration: InputDecoration(
                    fillColor: AppColors.whiteColor,
                    contentPadding: EdgeInsets.zero,
                    labelStyle: AppFontStyle.styleW400(AppColors.colorGry, 14),
                    hintText: EnumLocale.txtTypingSomething.name.tr,
                    hintStyle: AppFontStyle.styleW400(
                        AppColors.colorGry.withValues(alpha: 0.5), 14),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.colorGry.withValues(alpha: 0.3),
                    ),
                    suffixIcon: logic.languageSearchController.text.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              logic.languageSearchController.clear();
                              logic.onLanguageSearch('');
                              logic.update();
                            },
                            child: Icon(
                              Icons.clear,
                              color: AppColors.colorGry.withValues(alpha: 0.3),
                            ),
                          )
                        : null,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: AppColors.colorGry.withValues(alpha: 0.3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.whiteColor),
                    ),
                  ),
                ).paddingOnly(left: 12, right: 12),
                5.height,
                Expanded(
                  child: ListView.builder(
                    itemCount: logic.filteredLanguages.length,
                    itemBuilder: (context, index) {
                      final language = logic.filteredLanguages[index];
                      final isSelected =
                          logic.selectedLanguages.contains(language);

                      return GestureDetector(
                        onTap: () {
                          if (isSelected) {
                            logic.selectedLanguages.remove(language);
                          } else {
                            logic.selectedLanguages.add(language);
                          }
                          log("selectedLanguages: ${logic.selectedLanguages}");
                          logic.update();
                        },
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              width: 1,
                              color: isSelected
                                  ? AppColors.googleButtonColor
                                      .withValues(alpha: 0.8)
                                  : AppColors.colorUnSelectedImpression,
                            ),
                            color: AppColors.colorUnSelectedImpression
                                .withValues(alpha: 0.2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 10), // for left padding
                              Expanded(
                                child: Text(
                                  language,
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (isSelected)
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Image.asset(
                                    AppAsset.icCheck,
                                    height: 20,
                                    color: AppColors.googleButtonColor
                                        .withValues(alpha: 0.8),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).paddingOnly(left: 12, right: 12),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
