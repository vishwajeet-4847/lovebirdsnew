import 'dart:io';

import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppMaintenanceDialog extends StatelessWidget {
  const AppMaintenanceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 422,
      width: 330,
      padding: const EdgeInsets.all(15),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          Image.asset(
            AppAsset.icAppMaintenance,
            height: 200,
          ),
          Text(
            EnumLocale.txtUnderMaintenance.name.tr,
            textAlign: TextAlign.center,
            style: AppFontStyle.styleW700(
              AppColors.maintenance,
              22,
            ),
          ).paddingOnly(top: 8),
          Text(
            EnumLocale.desEnterUnderAppMaintenance.name.tr,
            textAlign: TextAlign.center,
            style: AppFontStyle.styleW400(
              AppColors.dialogDes,
              15,
            ),
          ).paddingOnly(top: 8, bottom: 13, left: 15, right: 15),
          const Spacer(),
          GestureDetector(
            onTap: () {
              exit(0);
            },
            child: Container(
              alignment: Alignment.center,
              height: 48,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.redColor2,
              ),
              child: Text(
                EnumLocale.txtCloseAPP.name.tr,
                style: AppFontStyle.styleW700(AppColors.whiteColor, 16),
              ),
            ),
          ),
        ],
      ).paddingAll(15),
    );
  }
}
