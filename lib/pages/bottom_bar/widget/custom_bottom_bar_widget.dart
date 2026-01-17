import 'dart:io';

import 'package:figgy/pages/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:figgy/utils/asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customBottomBar({
  required int index,
  required String selectIcon,
  required String unSelectIcon,
}) {
  return Expanded(
    child: GetBuilder<BottomBarController>(
      builder: (logic) {
        final bool isSelected = logic.currentIndex == index;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => logic.changeTab(index),
                    child: Container(
                      height: 50,
                      width: 95,
                      color: Colors.transparent,
                      child: Center(
                        child: Image.asset(
                          isSelected ? selectIcon : unSelectIcon,
                          width: 32,
                          height: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected && Platform.isAndroid)
              Positioned(
                bottom: MediaQuery.of(Get.context!).padding.bottom - 15,
                left: MediaQuery.of(Get.context!).padding.left + 37,
                child: SizedBox(
                  height: 27,
                  width: 27,
                  child: Image.asset(AppAsset.bottomTabIcon),
                ),
              ),
          ],
        );
      },
    ),
  );
}
