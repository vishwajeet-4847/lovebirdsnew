import 'package:LoveBirds/custom/app_background/custom_app_image_background.dart';
import 'package:LoveBirds/custom/custom_range_picker.dart';
import 'package:LoveBirds/custom/no_data_found/no_data_found.dart';
import 'package:LoveBirds/pages/host_withdraw_history_page/api/get_host_withdraw_history_api.dart';
import 'package:LoveBirds/pages/host_withdraw_history_page/controller/host_withdraw_history_controller.dart';
import 'package:LoveBirds/shimmer/coin_history_shimmer_ui.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HostWithdrawHistoryView extends StatelessWidget {
  const HostWithdrawHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAppImageBackground(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).viewPadding.top + 72,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top,
                  left: 15,
                  right: 15),
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
                  const Spacer(),
                  Text(
                    EnumLocale.txtWithdrawHistory.name.tr,
                    style: AppFontStyle.styleW700(AppColors.whiteColor, 18),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            GetBuilder<HostWithdrawHistoryController>(
              id: AppConstant.onGetWithdrawHistory,
              builder: (controller) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Text(
                        EnumLocale.txtWithdrawHistory.name.tr,
                        style: AppFontStyle.styleW700(AppColors.whiteColor, 20),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          DateTimeRange? initialRange;
                          if (controller.startDate != "All" &&
                              controller.endDate != "All") {
                            initialRange = DateTimeRange(
                              start: DateFormat('yyyy-MM-dd')
                                  .parse(controller.startDate),
                              end: DateFormat('yyyy-MM-dd')
                                  .parse(controller.endDate),
                            );
                          }

                          DateTimeRange? dateTimeRange =
                              await CustomRangePicker.onShow(
                            context,
                            initialRange,
                          );

                          if (dateTimeRange != null) {
                            String startDate = DateFormat('yyyy-MM-dd')
                                .format(dateTimeRange.start);
                            String endDate = DateFormat('yyyy-MM-dd')
                                .format(dateTimeRange.end);

                            final range =
                                "${DateFormat('dd MMM').format(dateTimeRange.start)} - ${DateFormat('dd MMM').format(dateTimeRange.end)}";

                            Utils.showLog("Selected Date Range => $range");

                            controller.onChangeDate(
                                startDate: startDate,
                                endDate: endDate,
                                rangeDate: range);
                            controller.onGetWithdrawHistory();
                          }
                        },
                        child: Container(
                          height: 35,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColors.allHistoryColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.allHistoryColor,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GetBuilder<HostWithdrawHistoryController>(
                                id: AppConstant.idOnChangeDate,
                                builder: (logic) => Text(
                                  logic.rangeDate,
                                  style: AppFontStyle.styleW500(
                                      AppColors.whiteColor, 12),
                                ),
                              ),
                              8.width,
                              const SizedBox(
                                height: 35,
                                width: 12,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                        top: 12.5,
                                        child: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            size: 19,
                                            color: Colors.white)),
                                    Positioned(
                                        top: 3.5,
                                        child: Icon(
                                            Icons.keyboard_arrow_up_rounded,
                                            size: 20,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      8.width,
                      controller.startDate == "All" ||
                              controller.endDate == "All"
                          ? const SizedBox()
                          : GestureDetector(
                              onTap: () async {
                                controller.withdrawHistory.clear();

                                controller.startDate = "All";
                                controller.endDate = "All";
                                controller.rangeDate = "All";
                                GeHostWithdrawHistoryApi.startPagination = 1;

                                await controller.init();
                              },
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: AppColors.darkRedColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child:
                                    Image.asset(AppAsset.icClear).paddingAll(8),
                              ),
                            ),
                    ],
                  ),
                );
              },
            ),
            GetBuilder<HostWithdrawHistoryController>(
              id: AppConstant.onGetWithdrawHistory,
              builder: (controller) {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      controller.withdrawHistory.clear();
                      GeHostWithdrawHistoryApi.startPagination = 1;

                      await controller.init();
                    },
                    color: AppColors.primaryColor,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: Get.height + 1,
                        child: GetBuilder<HostWithdrawHistoryController>(
                          id: AppConstant.onGetWithdrawHistory,
                          builder: (controller) {
                            return controller.isLoading
                                ? const CoinHistoryShimmerUi()
                                : controller.withdrawHistory.isEmpty
                                    ? NoDataFoundWidget()
                                        .paddingOnly(bottom: 150)
                                    : RefreshIndicator(
                                        onRefresh: () async {
                                          controller.withdrawHistory.clear();
                                          GeHostWithdrawHistoryApi
                                              .startPagination = 1;

                                          await controller.init();
                                        },
                                        color: AppColors.primaryColor,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          itemCount:
                                              controller.withdrawHistory.length,
                                          controller:
                                              controller.scrollController,
                                          itemBuilder: (context, index) {
                                            final hostData = controller
                                                .withdrawHistory[index];

                                            return Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              width: Get.width,
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              decoration: BoxDecoration(
                                                color: AppColors.settingColor,
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                              child: Row(
                                                children: [
                                                  10.width,
                                                  Container(
                                                    height: 66,
                                                    width: 66,
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .whiteColor
                                                          .withValues(
                                                              alpha: 0.05),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .whiteColor
                                                              .withValues(
                                                                  alpha: 0.08)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    child: Center(
                                                      child: Image.asset(
                                                          AppAsset.icCoin,
                                                          width: 35),
                                                    ),
                                                  ),
                                                  10.width,
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          hostData.status == 1
                                                              ? "Pending Withdraw"
                                                              : hostData.status ==
                                                                      2
                                                                  ? "Withdraw"
                                                                  : "Cancel Withdraw",
                                                          style: hostData
                                                                      .status ==
                                                                  1
                                                              ? AppFontStyle
                                                                  .styleW700(
                                                                      AppColors
                                                                          .colorLightYellow,
                                                                      15)
                                                              : hostData.status ==
                                                                      2
                                                                  ? AppFontStyle
                                                                      .styleW700(
                                                                          AppColors
                                                                              .redColor,
                                                                          15)
                                                                  : AppFontStyle
                                                                      .styleW700(
                                                                          AppColors
                                                                              .colorOrangeWithdraw,
                                                                          15),
                                                          maxLines: 1,
                                                        ),
                                                        Text(
                                                          hostData.requestDate ??
                                                              "",
                                                          style: AppFontStyle
                                                              .styleW500(
                                                                  AppColors
                                                                      .historyTextColor,
                                                                  10),
                                                        ),
                                                        2.height,
                                                        Text(
                                                          "ID :${hostData.uniqueId}",
                                                          style: AppFontStyle
                                                              .styleW500(
                                                                  AppColors
                                                                      .historyTextColor,
                                                                  10),
                                                        ),
                                                        2.height,
                                                        Text(
                                                          "Amount : ${Database.currencyCode} ${hostData.amount}",
                                                          style: AppFontStyle
                                                              .styleW500(
                                                                  AppColors
                                                                      .historyTextColor,
                                                                  10),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  10.width,
                                                  Container(
                                                    height: 34,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15),
                                                    decoration: BoxDecoration(
                                                      color: hostData.status ==
                                                              1
                                                          ? AppColors
                                                              .colorLightYellow
                                                          : hostData.status == 2
                                                              ? AppColors
                                                                  .redColor
                                                              : AppColors
                                                                  .colorOrangeWithdraw,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              60),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          hostData.status ==
                                                                      1 ||
                                                                  hostData.status ==
                                                                      3
                                                              ? ""
                                                              : "-",
                                                          style: AppFontStyle
                                                              .styleW700(
                                                            hostData.status == 1
                                                                ? AppColors
                                                                    .colorLightYellowBg
                                                                : hostData.status ==
                                                                        2
                                                                    ? AppColors
                                                                        .colorRedBg
                                                                    : AppColors
                                                                        .colorOrangeWithdrawBg,
                                                            15,
                                                          ),
                                                        ),
                                                        Text(
                                                          " ${hostData.coin}",
                                                          style: AppFontStyle
                                                              .styleW700(
                                                            hostData.status == 1
                                                                ? AppColors
                                                                    .colorLightYellowBg
                                                                : hostData.status ==
                                                                        2
                                                                    ? AppColors
                                                                        .colorRedBg
                                                                    : AppColors
                                                                        .colorOrangeWithdrawBg,
                                                            15,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  10.width,
                                                ],
                                              ),
                                            );
                                          },
                                        ).paddingOnly(top: 15),
                                      );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
