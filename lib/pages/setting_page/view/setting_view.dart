// ignore_for_file: must_be_immutable

import 'package:figgy/custom/dialog/delete_account_dialog.dart';
import 'package:figgy/custom/dialog/log_out_dialog.dart';
import 'package:figgy/pages/profile_page/widget/setting_option_widget.dart';
import 'package:figgy/pages/setting_page/controller/setting_controller.dart';
import 'package:figgy/routes/app_routes.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingView extends StatelessWidget {
  SettingView({super.key});

  SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorChat.withValues(alpha: 0.3),
      body: Stack(
        children: [
          Image.asset(
            AppAsset.allBackgroundImage,
            fit: BoxFit.cover,
            height: Get.height,
            width: Get.width,
          ),
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).viewPadding.top + 72,
                padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
                alignment: Alignment.center,
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColors.chatDetailTopColor,
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
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          AppAsset.icLeftArrow,
                          width: 10,
                        ),
                      ),
                    ),
                    Text(
                      EnumLocale.txtSetting.name.tr,
                      style: AppFontStyle.styleW700(AppColors.whiteColor, 20),
                    ),
                    45.width,
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingsOptionItemWidget(
                    color: AppColors.darkGreenColor,
                    icon: AppAsset.privacyPolicyIcon,
                    text: EnumLocale.txtPrivacyPolicy.name.tr,
                    onTap: () {
                      Get.toNamed(AppRoutes.privacyPolicy);
                    },
                  ),
                  SettingsOptionItemWidget(
                    color: AppColors.darkBlue,
                    icon: AppAsset.agreementIcon,
                    text: EnumLocale.txtTermsAndConditions.name.tr,
                    onTap: () {
                      Get.toNamed(AppRoutes.termsAndConditionView);
                    },
                  ),
                ],
              ),
              const Spacer(),
              Database.isDemoLogin
                  ? const Offstage()
                  : GetBuilder<SettingController>(builder: (controller) {
                      return GestureDetector(
                        onTap: () {
                          Get.dialog(
                            barrierColor: AppColors.blackColor.withValues(alpha: 0.8),
                            Dialog(
                              backgroundColor: AppColors.transparent,
                              shadowColor: Colors.transparent,
                              surfaceTintColor: Colors.transparent,
                              elevation: 0,
                              child: DeleteAccountDialog(
                                deleteAccountOnTap: () {
                                  Utils.showLog('is host delete account  :: ${Database.isHost}');
                                  Database.isHost == false ? controller.onDeleteAccount() : controller.onHostDeleteAccount();
                                },
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 60,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: AppColors.redColor,
                            borderRadius: BorderRadius.circular(60),
                            gradient: const LinearGradient(
                              colors: [Color(0xffFF0A37), Color(0xffF81C1F)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppAsset.icDeleteAccount,
                                height: 24,
                                width: 24,
                              ),
                              12.width,
                              Text(
                                EnumLocale.txtDeleteAccount.name.tr,
                                style: AppFontStyle.styleW800(AppColors.whiteColor, 18),
                              ),
                            ],
                          ),
                        ).paddingSymmetric(horizontal: 30),
                      );
                    }),
              19.height,
              GestureDetector(
                onTap: () {
                  Get.dialog(
                    barrierColor: AppColors.blackColor.withValues(alpha: 0.8),
                    Dialog(
                      backgroundColor: AppColors.transparent,
                      shadowColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      elevation: 0,
                      child: const LogoutUserDialogUi(),
                    ),
                  );
                },
                child: Container(
                  height: 60,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.redColor,
                    borderRadius: BorderRadius.circular(60),
                    gradient: const LinearGradient(
                      colors: [Color(0xffFF0A37), Color(0xffF81C1F)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAsset.logOutIcon,
                        height: 24,
                        width: 24,
                      ),
                      12.width,
                      Text(
                        EnumLocale.txtLogOut.name.tr,
                        style: AppFontStyle.styleW800(AppColors.whiteColor, 18),
                      ),
                    ],
                  ),
                ).paddingSymmetric(horizontal: 30),
              ),
              19.height,
            ],
          ),
        ],
      ),
    );
  }
}
