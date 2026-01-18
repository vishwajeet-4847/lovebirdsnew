import 'dart:io';

import 'package:LoveBirds/custom/app_button/custom_gradient_button.dart';
import 'package:LoveBirds/custom/app_title/custom_title.dart';
import 'package:LoveBirds/custom/cupertino_date_picker/controller/date_picker_controller.dart';
import 'package:LoveBirds/custom/cupertino_date_picker/date_picker.dart';
import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/custom/text_field/custom_text_field.dart';
import 'package:LoveBirds/pages/fill_profile_page/controller/fill_profile_controller.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FillProfileView extends GetView<FillProfileController> {
  const FillProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAsset.allBackgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).viewPadding.top + 60,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).viewPadding.top),
                  alignment: Alignment.center,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.chatDetailTopColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    EnumLocale.txtEnterYourDetails.name.tr,
                    style: AppFontStyle.styleW700(AppColors.whiteColor, 18),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.height,
                    GetBuilder<FillProfileController>(
                      builder: (logic) {
                        return GestureDetector(
                          onTap: () => logic.onProfileImage(context),
                          child: Center(
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppColors.gradientButtonColor,
                              ),
                              child: Stack(
                                children: [
                                  ClipOval(
                                    child: logic.pickImage.isEmpty == true
                                        ? Container(
                                            color: AppColors.colorTextGrey
                                                .withValues(alpha: 0.22),
                                            height: 150,
                                            width: 150,
                                            child: CustomImage(
                                              image: logic.profileImage,
                                            ),
                                          )
                                        : Image.file(
                                            File(logic.pickImage),
                                            height: 210,
                                            width: Get.width,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 5,
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.whiteColor),
                                        shape: BoxShape.circle,
                                        color: Colors.transparent,
                                      ),
                                      child: Image.asset(AppAsset.icEdit,
                                          width: 30),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTitle(title: EnumLocale.txtName.name.tr),
                          GetBuilder<FillProfileController>(
                            builder: (logic) {
                              return CustomTextField(
                                filled: true,
                                controller: logic.nameController,
                                fillColor:
                                    AppColors.whiteColor.withValues(alpha: 0.2),
                                cursorColor: AppColors.whiteColor,
                                hintText: EnumLocale.txtEnterUserName.name.tr,
                                hintTextSize: 16,
                                hintTextColor: AppColors.colorGry,
                                fontColor: AppColors.whiteColor,
                                fontSize: 16,
                                maxLines: 1,
                                keyboardType: TextInputType.name,
                              );
                            },
                          ),
                          20.height,
                          GetBuilder<FillProfileController>(
                            builder: (logic) {
                              return logic.loginType == 3
                                  ? const SizedBox()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTitle(
                                            title: EnumLocale.txtEmail.name.tr),
                                        CustomTextField(
                                          enabled: false,
                                          filled: true,
                                          controller: logic.emailController,
                                          fillColor: AppColors.whiteColor
                                              .withValues(alpha: 0.2),
                                          cursorColor: AppColors.whiteColor,
                                          hintText:
                                              EnumLocale.txtEnterEmail.name.tr,
                                          hintTextSize: 16,
                                          hintTextColor: AppColors.colorGry,
                                          fontColor: AppColors.whiteColor,
                                          fontSize: 16,
                                          maxLines: 1,
                                          keyboardType: TextInputType.name,
                                        ),
                                        20.height,
                                      ],
                                    );
                            },
                          ),
                          CustomTitle(title: EnumLocale.txtDob.name.tr),
                          GetBuilder<DatePickerController>(
                            id: AppConstant.idUpdateDate,
                            builder: (logic) {
                              return GestureDetector(
                                onTap: () {
                                  showCupertinoDatePicker(context: context);
                                },
                                child: Container(
                                  height: 55,
                                  width: Get.width,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: AppColors.whiteColor
                                          .withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Text(
                                    logic.date.split(" ")[0],
                                    style: AppFontStyle.styleW400(
                                        AppColors.whiteColor, 16),
                                  ),
                                ),
                              );
                            },
                          ),
                          20.height,
                          CustomTitle(title: EnumLocale.txtCountry.name.tr),
                          GetBuilder<FillProfileController>(
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
                                    color: AppColors.whiteColor
                                        .withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        logic.flagController.text,
                                        style: AppFontStyle.styleW500(
                                            AppColors.whiteColor, 20),
                                      ),
                                      10.width,
                                      Text(
                                        logic.countryController.text,
                                        style: AppFontStyle.styleW600(
                                            AppColors.whiteColor, 15),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
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
                          CustomTitle(
                              title:
                                  "${EnumLocale.txtBio.name.tr} (${EnumLocale.txtOptional.name.tr})"),
                          GetBuilder<FillProfileController>(
                            builder: (logic) {
                              return CustomTextField(
                                filled: true,
                                controller: logic.bioDetailsController,
                                fillColor:
                                    AppColors.whiteColor.withValues(alpha: 0.2),
                                cursorColor: AppColors.whiteColor,
                                hintText: EnumLocale.txtEnterBio.name.tr,
                                hintTextSize: 16,
                                hintTextColor: AppColors.colorGry,
                                fontColor: AppColors.whiteColor,
                                fontSize: 16,
                                maxLines: 5,
                                keyboardType: TextInputType.text,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                GetBuilder<FillProfileController>(
                  builder: (logic) {
                    return GestureDetector(
                      onTap: () => logic.onSaveProfile(),
                      // onTap: () {
                      //   print("date:::::::::::${logic.datePickerController.date.split(" ")[0]}");
                      // },
                      child: CustomGradientButton(),
                    );
                  },
                ),
                10.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
