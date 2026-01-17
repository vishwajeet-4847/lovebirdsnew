import 'package:figgy/custom/app_background/custom_app_background.dart';
import 'package:figgy/custom/custom_range_picker.dart';
import 'package:figgy/pages/my_wallet_page/api/get_coin_history_api.dart';
import 'package:figgy/pages/my_wallet_page/api/get_host_coin_history.dart';
import 'package:figgy/pages/my_wallet_page/controller/my_wallet_controller.dart';
import 'package:figgy/pages/my_wallet_page/widget/history_coin_widget.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyWalletController>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: CustomAppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).viewPadding.top + 72,
              padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top, left: 15, right: 15),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Text(
                    EnumLocale.txtHistory.name.tr,
                    style: AppFontStyle.styleW700(AppColors.whiteColor, 20),
                  ),
                  45.width,
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Image.asset(
                    AppAsset.walletHistoryIcon,
                    width: 24,
                    height: 24,
                  ),
                  8.width,
                  Text(
                    EnumLocale.txtCoinHistory.name.tr,
                    style: AppFontStyle.styleW700(AppColors.whiteColor, 18),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      DateTimeRange? initialRange;
                      if (controller.startDate != "All" && controller.endDate != "All") {
                        initialRange = DateTimeRange(
                          start: DateFormat('yyyy-MM-dd').parse(controller.startDate),
                          end: DateFormat('yyyy-MM-dd').parse(controller.endDate),
                        );
                      }

                      DateTimeRange? dateTimeRange = await CustomRangePicker.onShow(
                        context,
                        initialRange,
                      );

                      if (dateTimeRange != null) {
                        String startDate = DateFormat('yyyy-MM-dd').format(dateTimeRange.start);
                        String endDate = DateFormat('yyyy-MM-dd').format(dateTimeRange.end);

                        final range = "${DateFormat('dd MMM').format(dateTimeRange.start)} - ${DateFormat('dd MMM').format(dateTimeRange.end)}";

                        Utils.showLog("Selected Date Range => $range");

                        controller.onChangeDate(startDate: startDate, endDate: endDate, rangeDate: range);

                        Database.isHost ? await controller.onGetHostCoinHistory() : await controller.onGetUserCoinHistory();
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
                          GetBuilder<MyWalletController>(
                            id: AppConstant.idChangeDate,
                            builder: (logic) => Text(
                              logic.rangeDate,
                              style: AppFontStyle.styleW500(AppColors.whiteColor, 12),
                            ),
                          ),
                          8.width,
                          const SizedBox(
                            height: 35,
                            width: 12,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(top: 12.5, child: Icon(Icons.keyboard_arrow_down_outlined, size: 19, color: Colors.white)),
                                Positioned(top: 3.5, child: Icon(Icons.keyboard_arrow_up_rounded, size: 20, color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  8.width,
                  GetBuilder<MyWalletController>(
                    builder: (logic) {
                      return logic.startDate == "All" || logic.endDate == "All"
                          ? const SizedBox()
                          : GestureDetector(
                              onTap: () async {
                                if (Database.isHost) {
                                  logic.hostCoinHistory.clear();
                                  logic.startDate = "All";
                                  logic.endDate = "All";
                                  logic.rangeDate = "All";
                                  GetHostCoinHistoryApi.startPagination = 1;

                                  await logic.onGetHostCoinHistory();
                                } else {
                                  logic.userCoinHistory.clear();
                                  logic.startDate = "All";
                                  logic.endDate = "All";
                                  logic.rangeDate = "All";
                                  GetUserCoinHistoryApi.startPagination = 1;

                                  await logic.onGetUserCoinHistory();
                                }
                              },
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: AppColors.darkRedColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset(AppAsset.icClear).paddingAll(8),
                              ),
                            );
                    },
                  ),
                ],
              ),
            ),
            const Expanded(child: HistoryCoin()),
            GetBuilder<MyWalletController>(
              id: AppConstant.onPaginationLoader,
              builder: (logic) {
                return Visibility(
                  visible: logic.isPaginating,
                  child: SizedBox(
                    height: 2.5,
                    child: LinearProgressIndicator(
                      color: AppColors.chatDetailTopColor,
                      backgroundColor: Colors.grey[300],
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
