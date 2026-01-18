import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class ReportBottomSheetUi {
  static RxInt selectedReportType = 0.obs;

  static RxBool isLoading = false.obs;

  // static List<Data> reportTypes = [];
  static List reportTypes = [
    EnumLocale.txtItIsSpam.name.tr,
    EnumLocale.txtNudityOrSexualActivity.name.tr,
    EnumLocale.txtHateSpeechOrSymbols.name.tr,
    EnumLocale.txtViolenceOrDangerousOrganization.name.tr,
    EnumLocale.txtFalseInformation.name.tr,
    EnumLocale.txtBullyingOrHarassment.name.tr,
    EnumLocale.txtScamOrFraud.name.tr,
    EnumLocale.txtIntellectualPropertyViolation.name.tr,
    EnumLocale.txtSuicideOrSelfInjury.name.tr,
    EnumLocale.txtDrugs.name.tr,
    EnumLocale.txtEatingDisorders.name.tr,
    EnumLocale.txtSomethingElse.name.tr,
    EnumLocale.txtChildAbuse.name.tr,
    EnumLocale.txtOthers.name.tr,
  ];

  static Future<void> onSendReport() async {
    // Utils.showToast(EnumLocale.txtReportSending.name.tr);
    Get.back();
    //
    // final response = await CreateReportApi.callApi(
    //   loginUserId: Database.loginUserId,
    //   reportReason: reportTypes[selectedReportType.value].title ?? "",
    //   eventType: eventType,
    //   eventId: eventId,
    // );
    //
    // if (response != null && response) {
    //   Utils.showToast(EnumLocale.txtReportSendSuccess.name.tr);
    // } else {
    //   Utils.showToast(EnumLocale.txtSomeThingWentWrong.name.tr);
    // }
    Utils.showToast(EnumLocale.txtReportSendSuccess.name.tr);
  }

  static void show({
    required BuildContext context,
    Callback? onComplete,
  }) async {
    ReportBottomSheetUi.selectedReportType.value = 0;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: AppColors.transparent,
      builder: (context) => Container(
        height: 500,
        width: Get.width,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.receiveGiftBg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 65,
              color: AppColors.receiveGiftBg,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 4,
                        width: 35,
                        decoration: BoxDecoration(
                          color: AppColors.dailyCheckInPastBg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      10.height,
                      Text(
                        EnumLocale.txtReport.name.tr,
                        style: AppFontStyle.styleW700(AppColors.whiteColor, 17),
                      ),
                    ],
                  ).paddingOnly(left: 50),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.transparent,
                        border: Border.all(color: AppColors.blackColor),
                      ),
                      child: Center(
                        child: Image.asset(
                          width: 18,
                          AppAsset.icClose,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  itemCount: reportTypes.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => selectedReportType.value = index,
                      child: Container(
                        height: 46,
                        color: AppColors.transparent,
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            Obx(() => ReportRadioButtonUi(
                                isSelected: selectedReportType.value == index)),
                            12.width,
                            Text(
                              reportTypes[index] ?? "",
                              style: AppFontStyle.styleW500(
                                  AppColors.whiteColor, 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: !isLoading.value,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.dayColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            EnumLocale.txtCancel.name.tr,
                            style: AppFontStyle.styleW700(
                                AppColors.blackColor, 16),
                          ),
                        ),
                      ),
                      15.width,
                      GestureDetector(
                        onTap: () async {
                          await onSendReport();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 12),
                          decoration: BoxDecoration(
                            gradient: AppColors.hostLiveInnerButton,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            EnumLocale.txtReport.name.tr,
                            style: AppFontStyle.styleW700(
                                AppColors.whiteColor, 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ).whenComplete(() => onComplete?.call());
  }
}

class ReportRadioButtonUi extends StatelessWidget {
  const ReportRadioButtonUi({super.key, required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      color: AppColors.receiveGiftBg,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? null : AppColors.receiveGiftBg,
              gradient: isSelected ? AppColors.hostLiveInnerButton : null,
            ),
            child: Container(
              height: 20,
              width: 20,
              margin: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? null : AppColors.colorGreyBg,
                border: Border.all(
                    color: isSelected
                        ? AppColors.whiteColor
                        : AppColors.primaryColor.withValues(alpha: 0.5),
                    width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
