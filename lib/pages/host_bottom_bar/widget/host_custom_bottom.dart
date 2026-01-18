import 'dart:io';

import 'package:LoveBirds/pages/host_bottom_bar/controller/host_bottom_controller.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget hostCustomBottomBar({
  required int index,
  required String selectIcon,
  required String unSelectIcon,
}) {
  return Expanded(
    child: GetBuilder<HostBottomBarController>(
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
                  const SizedBox(height: 5),
                ],
              ),
            ),
            if (isSelected && Platform.isAndroid)
              Positioned(
                bottom: -16,
                left: 55,
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
