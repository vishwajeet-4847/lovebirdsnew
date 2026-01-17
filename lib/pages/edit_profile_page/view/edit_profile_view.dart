import 'dart:io';

import 'package:figgy/common/loading_widget.dart';
import 'package:figgy/custom/cupertino_date_picker/controller/date_picker_controller.dart';
import 'package:figgy/custom/cupertino_date_picker/date_picker.dart';
import 'package:figgy/custom/custom_image/custom_profile_image.dart';
import 'package:figgy/custom/text_field/custom_text_field.dart';
import 'package:figgy/pages/edit_profile_page/controller/edit_profile_controller.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<EditProfileController>(
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
                            EnumLocale.txtEnterYourDetails.name.tr,
                            style: AppFontStyle.styleW700(AppColors.whiteColor, 20),
                          ),
                          const SizedBox(width: 45),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GetBuilder<EditProfileController>(
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
                                                ? GetBuilder<EditProfileController>(
                                                    builder: (controller) {
                                                      return SizedBox(
                                                        height: 140,
                                                        width: 140,
                                                        child: CustomImage(
                                                          padding: 20,
                                                          image: logic.profileImage,
                                                        ),
                                                      );
                                                    },
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
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(color: AppColors.profileBorderColor, shape: BoxShape.circle),
                                              child: Container(
                                                height: 36,
                                                width: 36,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  gradient: AppColors.gradientButtonColor,
                                                ),
                                                child: Center(
                                                    child: Image.asset(
                                                  AppAsset.cameraIcon,
                                                  width: 26,
                                                  height: 26,
                                                )),
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
                            30.height,
                            Text(
                              EnumLocale.txtEditProfileDetails.name.tr,
                              style: AppFontStyle.styleW700(AppColors.whiteColor, 18),
                            ),
                            20.height,
                            customLabel(EnumLocale.txtName.name.tr),
                            GetBuilder<EditProfileController>(
                              builder: (logic) => CustomTextField(
                                filled: true,
                                controller: logic.nameController,
                                fillColor: AppColors.settingColor,
                                cursorColor: AppColors.whiteColor,
                                hintText: EnumLocale.txtEnterUserName.name.tr,
                                hintTextSize: 16,
                                hintTextColor: AppColors.colorGry,
                                fontColor: AppColors.whiteColor,
                                fontSize: 16,
                                maxLines: 1,
                                keyboardType: TextInputType.name,
                              ),
                            ),
                            Database.loginType == 3 ? const SizedBox() : 20.height,
                            Database.loginType == 3 ? const SizedBox() : customLabel(EnumLocale.txtEmail.name.tr),
                            Database.loginType == 3
                                ? const SizedBox()
                                : GetBuilder<EditProfileController>(
                                    builder: (logic) => CustomTextField(
                                      enabled: false,
                                      filled: true,
                                      controller: logic.emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      fillColor: AppColors.settingColor,
                                      cursorColor: AppColors.whiteColor,
                                      hintText: EnumLocale.txtEnterEmail.name.tr,
                                      hintTextSize: 16,
                                      hintTextColor: AppColors.colorGry,
                                      fontColor: AppColors.whiteColor,
                                      fontSize: 16,
                                      maxLines: 1,
                                    ),
                                  ),
                            20.height,
                            customLabel(EnumLocale.txtDob.name.tr),
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
                                      style: AppFontStyle.styleW400(AppColors.whiteColor, 16),
                                    ),
                                  ),
                                );
                              },
                            ),
                            20.height,
                            customLabel(EnumLocale.txtSelectCountry.name.tr),
                            GetBuilder<EditProfileController>(
                              id: AppConstant.idChangeCountry,
                              builder: (logic) {
                                return GestureDetector(
                                  onTap: () {
                                    logic.onChangeCountry(context);
                                  },
                                  child: Container(
                                    height: 55,
                                    width: Get.width,
                                    padding: const EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                      color: AppColors.settingColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          logic.flagController.text,
                                          style: AppFontStyle.styleW500(AppColors.whiteColor, 20),
                                        ),
                                        10.width,
                                        Text(
                                          logic.countryController.text,
                                          style: AppFontStyle.styleW600(AppColors.whiteColor, 15),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: AppColors.whiteColor,
                                          ),
                                        ),
                                        10.width,
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            20.height,
                            customLabel("${EnumLocale.txtBio.name.tr} (${EnumLocale.txtOptional.name.tr})"),
                            GetBuilder<EditProfileController>(
                              builder: (logic) => CustomTextField(
                                filled: true,
                                controller: logic.bioDetailsController,
                                fillColor: AppColors.settingColor,
                                cursorColor: AppColors.whiteColor,
                                hintText: EnumLocale.txtEnterBio.name.tr,
                                hintTextSize: 16,
                                hintTextColor: AppColors.colorGry,
                                fontColor: AppColors.whiteColor,
                                fontSize: 16,
                                maxLines: 4,
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GetBuilder<EditProfileController>(
                      builder: (logic) {
                        return GestureDetector(
                          onTap: () {
                            logic.onSaveProfile();
                          },
                          child: Container(
                            height: 56,
                            width: Get.width,
                            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: AppColors.hostNextButton,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              EnumLocale.txtNext.name.tr,
                              style: AppFontStyle.styleW400(AppColors.whiteColor, 19),
                            ),
                          ),
                        );
                      },
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

Widget customLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: AppFontStyle.styleW500(AppColors.walletTxtColor, 14),
      ),
    ),
  );
}
