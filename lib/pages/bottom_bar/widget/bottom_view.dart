import 'dart:io';

import 'package:LoveBirds/pages/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:LoveBirds/pages/bottom_bar/widget/custom_bottom_bar_widget.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomViewUi extends StatelessWidget {
  const BottomViewUi({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(
      builder: (controller) {
        return Container(
          height: Platform.isIOS ? 90 : 75,
          width: Get.width,
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
                  blurRadius: 34,
                  spreadRadius: 0),
            ],
          ),
          child: Row(
            children: [
              customBottomBar(
                  index: 0,
                  selectIcon: AppAsset.icNaviMatchSelect,
                  unSelectIcon: AppAsset.icNaviMatchUnSelect),
              customBottomBar(
                  index: 1,
                  selectIcon: AppAsset.icNaviMessageSelect,
                  unSelectIcon: AppAsset.icNaviMessageUnSelect),
              customBottomBar(
                  index: 2,
                  selectIcon: AppAsset.icNaviExploreSelect,
                  unSelectIcon: AppAsset.icNaviExploreUnSelect),
              customBottomBar(
                  index: 3,
                  selectIcon: AppAsset.icNaviMineSelect,
                  unSelectIcon: AppAsset.icNaviMineUnSelect),
            ],
          ),
        );
      },
    );
  }
}
