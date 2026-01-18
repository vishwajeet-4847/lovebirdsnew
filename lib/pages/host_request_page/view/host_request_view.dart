import 'package:LoveBirds/common/step_progress_indicator.dart';
import 'package:LoveBirds/pages/host_request_page/controller/host_request_controller.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostRequestView extends StatelessWidget {
  const HostRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostRequestController>(
      builder: (logic) {
        return WillPopScope(
          onWillPop: () async {
            logic.previousStep();
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).viewPadding.top + 72,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GetBuilder<HostRequestController>(
                          builder: (controller) {
                            return GestureDetector(
                              onTap: () {
                                controller.previousStep();
                              },
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
                            );
                          },
                        ),
                        Text(
                          EnumLocale.txtHostRequest.name.tr,
                          style:
                              AppFontStyle.styleW700(AppColors.whiteColor, 20),
                        ),
                        45.width,
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: GetBuilder<HostRequestController>(
                        init: HostRequestController(),
                        builder: (logic) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                EnumLocale.txtRequestProgress.name.tr,
                                style: AppFontStyle.styleW700(
                                    AppColors.whiteColor, 18),
                              ),
                              18.height,
                              StepProgressIndicator(
                                  currentStep: logic.currentStep),
                              Container(
                                constraints: BoxConstraints(
                                  minHeight: Get.height * 0.6,
                                ),
                                child: logic.getCurrentStepView(),
                              ),
                              20.height,
                              GestureDetector(
                                onTap: () {
                                  logic.nextStep();
                                },
                                child: Container(
                                  height: 50,
                                  width: Get.width,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    gradient: AppColors.hostNextButton,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: Text(
                                      logic.currentStep == 3
                                          ? EnumLocale.txtSendRequest.name.tr
                                          : EnumLocale.txtNext.name.tr,
                                      style: AppFontStyle.styleW600(
                                          AppColors.whiteColor, 17),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
