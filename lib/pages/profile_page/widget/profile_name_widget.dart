import 'package:figgy/pages/profile_page/controller/profile_controller.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class ProfileNameWidget extends StatelessWidget {
  const ProfileNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: Get.width,
          child: Text(
            Database.userName,
            maxLines: 1,
            style: AppFontStyle.styleW700(AppColors.whiteColor, 20),
          ),
        ),
        4.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Database.uniqueId,
              maxLines: 1,
              style: AppFontStyle.styleW500(AppColors.colorGry, 16),
            ),
            5.width,
            GestureDetector(
              onTap: () {
                Utils.copyText(Database.uniqueId);
              },
              child: Container(
                color: Colors.transparent,
                child: Image.asset(
                  AppAsset.copy,
                  height: 20,
                  width: 20,
                  color: AppColors.colorGry,
                ),
              ),
            ),
          ],
        ),
        13.height,
        GetBuilder<ProfileViewController>(
          builder: (logic) {
            return GestureDetector(
              onTap: () => Database.isHost
                  ? Get.toNamed(AppRoutes.hostEditProfilePage)?.then(
                      (value) async {
                        logic.onGetHostProfile();
                      },
                    )
                  : Get.toNamed(AppRoutes.editProfilePage)?.then(
                      (value) async {
                        logic.onGetUserProfile();
                      },
                    ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(
                    color: AppColors.whiteColor.withValues(alpha: 0.28),
                  ),
                  color: AppColors.editColor,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      AppAsset.editProfileIcon,
                      height: 20,
                      width: 20,
                    ),
                    5.width,
                    Text(
                      EnumLocale.txtEditProfile.name.tr,
                      style: AppFontStyle.styleW700(AppColors.whiteColor, 13),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 9, vertical: 6),
              ),
            );
          },
        ),
      ],
    );
  }
}
