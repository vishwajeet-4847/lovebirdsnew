import 'dart:io';

import 'package:figgy/common/loading_widget.dart';
import 'package:figgy/custom/cupertino_date_picker/controller/date_picker_controller.dart';
import 'package:figgy/custom/cupertino_date_picker/date_picker.dart';
import 'package:figgy/custom/custom_image/custom_profile_image.dart';
import 'package:figgy/custom/text_field/custom_text_field.dart';
import 'package:figgy/pages/host_edit_profile_page/controller/host_edit_profile_controller.dart';
import 'package:figgy/pages/host_edit_profile_page/view/edit_call_rate.dart';
import 'package:figgy/pages/host_edit_profile_page/widget/host_edit_view.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostEditProfileView extends StatelessWidget {
  const HostEditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HostEditProfileController>(
        builder: (logic) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAsset.allBackgroundImage),
                    fit: BoxFit.cover,
                  ),
                ),
                height: Get.height,
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            color: AppColors.blackColor.withValues(alpha: 0.40),
                            offset: const Offset(0, -6),
                            blurRadius: 34,
                            spreadRadius: 0,
                          )
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
                            EnumLocale.txtEnterYourDetails.name.tr,
                            style: AppFontStyle.styleW700(AppColors.whiteColor, 20),
                          ),
                          const SizedBox(width: 45),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            20.height,
                            GetBuilder<HostEditProfileController>(
                              builder: (logic) {
                                return GestureDetector(
                                  onTap: () => logic.onProfileImage(context),
                                  child: Center(
                                    child: Container(
                                      height: 140,
                                      width: 140,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: AppColors.gradientButtonColor,
                                      ),
                                      child: Stack(
                                        children: [
                                          ClipOval(
                                            child: logic.pickImages.isEmpty == true
                                                ? SizedBox(
                                                    height: 140,
                                                    width: 140,
                                                    child: CustomImage(
                                                      image: logic.profileImage,
                                                    ),
                                                  )
                                                : Image.file(
                                                    File(logic.pickImages),
                                                    height: 140,
                                                    width: 140,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            bottom: 5,
                                            child: Container(
                                              height: 38,
                                              width: 38,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: AppColors.profileBorderColor, width: 2),
                                                shape: BoxShape.circle,
                                                // color: Colors.red,
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    AppColors.pinkColor,
                                                    AppColors.blueColor,
                                                  ],
                                                ),
                                              ),
                                              child: Image.asset(
                                                AppAsset.cameraIcon,
                                                width: 26,
                                                height: 26,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            20.height,
                            buildLabel(EnumLocale.txtEnterYourName.name.tr),
                            GetBuilder<HostEditProfileController>(
                              builder: (logic) => CustomTextField(
                                filled: true,
                                controller: logic.nameController,
                                fillColor: AppColors.settingColor,
                                cursorColor: AppColors.whiteColor,
                                hintText: EnumLocale.txtEnterUserName.name.tr,
                                hintTextSize: 17,
                                hintTextColor: AppColors.colorGry,
                                fontColor: AppColors.whiteColor,
                                fontSize: 17,
                                maxLines: 1,
                                keyboardType: TextInputType.name,
                              ),
                            ),
                            20.height,
                            Database.isHost
                                ? const Offstage()
                                : Column(
                                    children: [
                                      buildLabel(EnumLocale.txtEmail.name.tr),
                                      GetBuilder<HostEditProfileController>(
                                        builder: (logic) => CustomTextField(
                                          enabled: false,
                                          filled: true,
                                          controller: logic.emailController,
                                          keyboardType: TextInputType.emailAddress,
                                          fillColor: AppColors.settingColor,
                                          cursorColor: AppColors.whiteColor,
                                          hintText: EnumLocale.txtEnterEmail.name.tr,
                                          hintTextSize: 17,
                                          hintTextColor: AppColors.colorGry,
                                          fontColor: AppColors.whiteColor,
                                          fontSize: 17,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                            buildLabel(EnumLocale.txtEnterYourDOB.name.tr),
                            GetBuilder<DatePickerController>(
                              id: AppConstant.idUpdateDate,
                              builder: (logic) {
                                return GestureDetector(
                                  onTap: () => showCupertinoDatePicker(context: context),
                                  child: Container(
                                    height: 55,
                                    width: Get.width,
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: AppColors.settingColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      logic.selectedDateString,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppFontStyle.styleW700(AppColors.whiteColor, 17),
                                    ),
                                  ),
                                );
                              },
                            ),
                            20.height,
                            buildLabel(EnumLocale.txtSelfIntroduction.name.tr),
                            GetBuilder<HostEditProfileController>(
                              builder: (logic) => CustomTextField(
                                filled: true,
                                controller: logic.bioDetailsController,
                                fillColor: AppColors.settingColor,
                                cursorColor: AppColors.whiteColor,
                                hintText: EnumLocale.txtSelfIntroduction.name.tr,
                                hintTextSize: 17,
                                hintTextColor: AppColors.colorGry,
                                fontColor: AppColors.whiteColor,
                                fontSize: 17,
                                maxLines: 5,
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            const HostEditView(buildLabel: buildLabel)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 99,
                      decoration: BoxDecoration(
                        color: AppColors.bottomBarColor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(18),
                          topLeft: Radius.circular(18),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blackColor.withValues(alpha: 0.40),
                            offset: const Offset(0, -6),
                            spreadRadius: 0,
                            blurRadius: 34,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.to(const EditCallRate());
                              },
                              child: Container(
                                height: 52,
                                decoration: BoxDecoration(
                                  gradient: AppColors.editCallRate,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text(
                                    EnumLocale.txtEditCallRate.name.tr,
                                    style: AppFontStyle.styleW700(AppColors.whiteColor, 18),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          14.width,
                          GetBuilder<HostEditProfileController>(
                            builder: (logic) {
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    if (Database.isDemoLogin) {
                                      Utils.showToast("Oops! you don't have permission.This is demo login");
                                    } else {
                                      logic.onSaveProfile();
                                    }
                                  },
                                  child: Container(
                                    height: 52,
                                    decoration: BoxDecoration(
                                      gradient: AppColors.saveButton,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Center(
                                      child: Text(
                                        EnumLocale.txtSaveChanges.name.tr,
                                        style: AppFontStyle.styleW700(AppColors.whiteColor, 18),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ).paddingSymmetric(horizontal: 13),
                    ),
                  ],
                ),
              ),
              if (logic.isLoading)
                Container(
                  height: Get.height,
                  width: Get.width,
                  color: Colors.black26,
                  child: const LoadingWidget(),
                )
            ],
          );
        },
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
