import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custom/text_field/custom_text_field.dart';
import '../controller/host_edit_profile_controller.dart';

class EditCallRate extends StatelessWidget {
  const EditCallRate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAsset.allBackgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        width: Get.width,
        child: Column(
          children: [
            // Fixed Header
            Container(
              height: MediaQuery.of(context).viewPadding.top + 72,
              padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
              alignment: Alignment.center,
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.indicatorCircleColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blackColor.withValues(alpha: 0.4),
                    offset: const Offset(0, -6),
                    blurRadius: 34,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: Container(
                      height: 45,
                      width: 45,
                      alignment: Alignment.center,
                      child: Image.asset(AppAsset.icLeftArrow, width: 10),
                    ),
                  ),
                  Text(
                    EnumLocale.txtCallRate.name.tr,
                    style: AppFontStyle.styleW700(AppColors.whiteColor, 20),
                  ),
                  const SizedBox(width: 45),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            26.height,
                            Text(
                              EnumLocale.txtRandomCallRate.name.tr,
                              style: AppFontStyle.styleW700(AppColors.whiteColor, 18),
                            ).paddingSymmetric(horizontal: 16),
                            20.height,

                            // Random call rate inputs...
                            Row(
                              children: [
                                // Male
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        EnumLocale.txtMale.name.tr,
                                        style: AppFontStyle.styleW500(AppColors.walletTxtColor, 14),
                                      ),
                                      14.height,
                                      GetBuilder<HostEditProfileController>(
                                        builder: (logic) => CustomTextField(
                                          filled: true,
                                          controller: logic.randomCallRateForMaleController,
                                          fillColor: AppColors.settingColor,
                                          cursorColor: AppColors.whiteColor,
                                          hintText: EnumLocale.txtMale.name.tr,
                                          hintTextSize: 17,
                                          hintTextColor: AppColors.colorGry,
                                          fontColor: AppColors.whiteColor,
                                          fontSize: 17,
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                18.width,

                                // Female
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        EnumLocale.txtFemale.name.tr,
                                        style: AppFontStyle.styleW500(AppColors.walletTxtColor, 14),
                                      ),
                                      14.height,
                                      GetBuilder<HostEditProfileController>(
                                        builder: (logic) => CustomTextField(
                                          filled: true,
                                          controller: logic.randomCallRateForFeMaleController,
                                          fillColor: AppColors.settingColor,
                                          cursorColor: AppColors.whiteColor,
                                          hintText: EnumLocale.txtFemale.name.tr,
                                          hintTextSize: 17,
                                          hintTextColor: AppColors.colorGry,
                                          fontColor: AppColors.whiteColor,
                                          fontSize: 17,
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                18.width,

                                // Both
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        EnumLocale.txtBoth.name.tr,
                                        style: AppFontStyle.styleW500(AppColors.walletTxtColor, 14),
                                      ),
                                      14.height,
                                      GetBuilder<HostEditProfileController>(
                                        builder: (logic) => CustomTextField(
                                          filled: true,
                                          controller: logic.randomCallRateForBothController,
                                          fillColor: AppColors.settingColor,
                                          cursorColor: AppColors.whiteColor,
                                          hintText: EnumLocale.txtBoth.name.tr,
                                          hintTextSize: 17,
                                          hintTextColor: AppColors.colorGry,
                                          fontColor: AppColors.whiteColor,
                                          fontSize: 17,
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ).paddingSymmetric(horizontal: 16),
                            24.height,

                            // Private and Audio call rates
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        EnumLocale.txtPrivateCallRate.name.tr,
                                        style: AppFontStyle.styleW400(AppColors.walletTxtColor, 14),
                                      ),
                                      14.height,
                                      GetBuilder<HostEditProfileController>(
                                        builder: (logic) => CustomTextField(
                                          filled: true,
                                          controller: logic.privetCallRateController,
                                          fillColor: AppColors.settingColor,
                                          cursorColor: AppColors.whiteColor,
                                          hintText: EnumLocale.txtPrivateCallRate.name.tr,
                                          hintTextSize: 17,
                                          hintTextColor: AppColors.colorGry,
                                          fontColor: AppColors.whiteColor,
                                          fontSize: 17,
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                18.width,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        EnumLocale.txtAudioCallRate.name.tr,
                                        style: AppFontStyle.styleW400(AppColors.walletTxtColor, 14),
                                      ),
                                      14.height,
                                      GetBuilder<HostEditProfileController>(
                                        builder: (logic) => CustomTextField(
                                          filled: true,
                                          controller: logic.audioCallRateController,
                                          fillColor: AppColors.settingColor,
                                          cursorColor: AppColors.whiteColor,
                                          hintText: EnumLocale.txtAudioCallRate.name.tr,
                                          hintTextSize: 17,
                                          hintTextColor: AppColors.colorGry,
                                          fontColor: AppColors.whiteColor,
                                          fontSize: 17,
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ).paddingSymmetric(horizontal: 16),
                            24.height,

                            // Chat Rate
                            buildLabel(EnumLocale.txtChatRate.name.tr).paddingSymmetric(horizontal: 16),
                            GetBuilder<HostEditProfileController>(
                              builder: (logic) => CustomTextField(
                                filled: true,
                                controller: logic.chatRateController,
                                fillColor: AppColors.settingColor,
                                cursorColor: AppColors.whiteColor,
                                hintText: EnumLocale.txtChatRate.name.tr,
                                hintTextSize: 17,
                                hintTextColor: AppColors.colorGry,
                                fontColor: AppColors.whiteColor,
                                fontSize: 17,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                              ),
                            ).paddingSymmetric(horizontal: 16),

                            const Spacer(),

                            // Save Button
                            GetBuilder<HostEditProfileController>(
                              builder: (logic) {
                                return GestureDetector(
                                  onTap: () {
                                    if (Database.isDemoLogin) {
                                      Utils.showToast("Oops! you don't have permission.This is demo login");
                                    } else {
                                      logic.onSaveProfileWhenCallRate();
                                    }
                                  },
                                  child: Container(
                                    height: 58,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      gradient: const LinearGradient(
                                        colors: [
                                          AppColors.pinkColor,
                                          AppColors.blueColor,
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        EnumLocale.txtSaveCallRate.name.tr,
                                        style: AppFontStyle.styleW700(AppColors.whiteColor, 20),
                                      ),
                                    ),
                                  ).paddingOnly(right: 24, left: 24, bottom: 24, top: 15),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: AppFontStyle.styleW500(AppColors.walletTxtColor, 14),
      ),
    ),
  );
}
