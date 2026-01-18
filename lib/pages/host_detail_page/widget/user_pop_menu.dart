import 'package:LoveBirds/custom/dialog/block_dialog.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/host_detail_controller.dart';

class TopView extends StatelessWidget {
  const TopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: Container(
        height: MediaQuery.of(context).viewPadding.top + 60,
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top, left: 15, right: 15),
        alignment: Alignment.center,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColors.transparent,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: GetBuilder<HostDetailController>(
          builder: (logic) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: Get.back,
                      child: Image.asset(
                        AppAsset.icLeftArrow,
                        width: 10,
                        fit: BoxFit.cover,
                      ),
                    ),
                    10.width,
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Get.dialog(
                      barrierColor: AppColors.blackColor.withValues(alpha: 0.8),
                      Dialog(
                        backgroundColor: AppColors.transparent,
                        shadowColor: Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        elevation: 0,
                        child: BlockDialog(
                          hostId: logic.hostDetailModel?.host?.id ?? "",
                          isHost: true,
                          userId: "",
                        ),
                      ),
                    );
                  },
                  child: Image.asset(
                    AppAsset.icMore,
                    height: 20,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
