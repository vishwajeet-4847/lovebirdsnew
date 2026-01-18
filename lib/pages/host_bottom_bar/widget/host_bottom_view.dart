import 'dart:io';

import 'package:LoveBirds/pages/host_bottom_bar/controller/host_bottom_controller.dart';
import 'package:LoveBirds/pages/host_bottom_bar/widget/host_custom_bottom.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostBottomViewUi extends StatelessWidget {
  const HostBottomViewUi({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostBottomBarController>(
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
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            children: [
              hostCustomBottomBar(
                  index: 0,
                  selectIcon: AppAsset.icNaviExploreSelect,
                  unSelectIcon: AppAsset.icNaviExploreUnSelect),
              hostCustomBottomBar(
                  index: 1,
                  selectIcon: AppAsset.icNaviMessageSelect,
                  unSelectIcon: AppAsset.icNaviMessageUnSelect),
              hostCustomBottomBar(
                  index: 2,
                  selectIcon: AppAsset.icNaviMineSelect,
                  unSelectIcon: AppAsset.icNaviMineUnSelect),
            ],
          ),
        );
      },
    );
  }
}
