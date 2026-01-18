import 'package:LoveBirds/custom/no_data_found/no_data_found.dart';
import 'package:LoveBirds/pages/my_wallet_page/api/get_coin_history_api.dart';
import 'package:LoveBirds/pages/my_wallet_page/api/get_host_coin_history.dart';
import 'package:LoveBirds/pages/my_wallet_page/controller/my_wallet_controller.dart';
import 'package:LoveBirds/shimmer/block_list_shimmer.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryCoin extends StatelessWidget {
  const HistoryCoin({super.key});

  @override
  Widget build(BuildContext context) {
    return Database.isHost
        ? GetBuilder<MyWalletController>(
            id: AppConstant.idGetCoinHistory,
            builder: (logic) {
              return logic.isLoading
                  ? const BlockListShimmer()
                  : LayoutBuilder(
                      builder: (context, box) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            logic.hostCoinHistory.clear();
                            GetHostCoinHistoryApi.startPagination = 1;

                            await logic.onGetHostCoinHistory();
                          },
                          child: logic.hostCoinHistory.isEmpty
                              ? SingleChildScrollView(
                                  child: SizedBox(
                                    height: box.maxHeight + 1,
                                    child: NoDataFoundWidget(),
                                  ),
                                )
                              : SingleChildScrollView(
                                  child: SizedBox(
                                    height: box.maxHeight + 1,
                                    child: RefreshIndicator(
                                      onRefresh: () async {
                                        logic.hostCoinHistory.clear();
                                        GetHostCoinHistoryApi.startPagination =
                                            1;

                                        await logic.onGetHostCoinHistory();
                                      },
                                      child: SingleChildScrollView(
                                        controller: logic.scrollController,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          itemCount:
                                              logic.hostCoinHistory.length,
                                          itemBuilder: (context, index) {
                                            final hostData =
                                                logic.hostCoinHistory[index];

                                            return Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
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
                                                  7.width,
                                                  Container(
                                                    height: 60,
                                                    width: 60,
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
                                                              10),
                                                    ),
                                                    child: Image.asset(
                                                            AppAsset.icCoin)
                                                        .paddingAll(10),
                                                  ),
                                                  10.width,
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: Get.width * 0.53,
                                                        color:
                                                            Colors.transparent,
                                                        child:
                                                            SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Text(
                                                            logic
                                                                .getHostTitleFromType(
                                                              hostData.type
                                                                      ?.toInt() ??
                                                                  0,
                                                              hostData.senderName ??
                                                                  "",
                                                              hostData.typeDescription ??
                                                                  "",
                                                            ),
                                                            style: AppFontStyle
                                                                .styleW700(
                                                                    AppColors
                                                                        .whiteColor,
                                                                    15),
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        logic.dateFormat(
                                                            hostData.createdAt ??
                                                                ""),
                                                        style: AppFontStyle
                                                            .styleW500(
                                                                AppColors
                                                                    .historyTextColor,
                                                                11),
                                                      ),
                                                      2.height,
                                                      Text(
                                                        "ID : ${logic.getDisplayUniqueId(index, hostData.uniqueId)}",
                                                        style: AppFontStyle
                                                            .styleW700(
                                                                AppColors
                                                                    .historyTextColor,
                                                                11),
                                                      ),
                                                    ],
                                                  ),
                                                  10.width,
                                                  Container(
                                                    height: 30,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12),
                                                    decoration: BoxDecoration(
                                                      color: hostData.type == 5
                                                          ? hostData.payoutStatus ==
                                                                  1
                                                              ? AppColors
                                                                  .colorLightYellow
                                                              : hostData.payoutStatus ==
                                                                      2
                                                                  ? AppColors
                                                                      .redColor2
                                                                  : AppColors
                                                                      .colorOrangeWithdraw
                                                          : hostData.payoutStatus ==
                                                                  1
                                                              ? AppColors
                                                                  .redColor2
                                                              : AppColors
                                                                  .darkGreenColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              60),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          hostData.type == 5
                                                              ? hostData.payoutStatus ==
                                                                          1 ||
                                                                      hostData.payoutStatus ==
                                                                          3
                                                                  ? ""
                                                                  : "-"
                                                              : hostData.payoutStatus ==
                                                                      1
                                                                  ? "-"
                                                                  : "+",
                                                          style: hostData
                                                                      .payoutStatus ==
                                                                  1
                                                              ? AppFontStyle
                                                                  .styleW700(
                                                                      AppColors
                                                                          .colorRedBg,
                                                                      15)
                                                              : AppFontStyle
                                                                  .styleW700(
                                                                      AppColors
                                                                          .whiteColor,
                                                                      15),
                                                        ),
                                                        Text(
                                                          "${hostData.hostCoin}",
                                                          style: hostData
                                                                      .type ==
                                                                  5
                                                              ? hostData.payoutStatus ==
                                                                      1
                                                                  ? AppFontStyle
                                                                      .styleW700(
                                                                          AppColors
                                                                              .colorLightYellowBg,
                                                                          15)
                                                                  : hostData.payoutStatus ==
                                                                          2
                                                                      ? AppFontStyle.styleW700(
                                                                          AppColors
                                                                              .colorRedBg,
                                                                          15)
                                                                      : AppFontStyle.styleW700(
                                                                          AppColors
                                                                              .colorOrangeWithdrawBg,
                                                                          15)
                                                              : hostData.payoutStatus ==
                                                                      1
                                                                  ? AppFontStyle
                                                                      .styleW700(
                                                                          AppColors
                                                                              .colorRedBg,
                                                                          15)
                                                                  : AppFontStyle
                                                                      .styleW700(
                                                                          AppColors
                                                                              .whiteColor,
                                                                          15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ).paddingOnly(top: 15),
                                      ),
                                    ),
                                  ),
                                ),
                        );
                      },
                    );
            },
          )
        : GetBuilder<MyWalletController>(
            id: AppConstant.idGetCoinHistory,
            builder: (logic) {
              return logic.isLoading
                  ? const BlockListShimmer()
                  : RefreshIndicator(
                      onRefresh: () async {
                        logic.userCoinHistory.clear();
                        GetUserCoinHistoryApi.startPagination = 1;

                        await logic.onGetUserCoinHistory();
                      },
                      child: LayoutBuilder(
                        builder: (context, box) {
                          return logic.userCoinHistory.isEmpty
                              ? SingleChildScrollView(
                                  child: SizedBox(
                                    height: box.maxHeight + 1,
                                    child: NoDataFoundWidget(),
                                  ),
                                )
                              : SingleChildScrollView(
                                  child: SizedBox(
                                    height: box.maxHeight + 1,
                                    child: RefreshIndicator(
                                      onRefresh: () async {
                                        logic.userCoinHistory.clear();
                                        GetUserCoinHistoryApi.startPagination =
                                            1;

                                        await logic.onGetUserCoinHistory();
                                      },
                                      child: SingleChildScrollView(
                                        controller: logic.scrollController,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          itemCount:
                                              logic.userCoinHistory.length,
                                          itemBuilder: (context, index) {
                                            final data =
                                                logic.userCoinHistory[index];
                                            return Container(
                                              height: 70,
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
                                                    height: 55,
                                                    width: 55,
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .whiteColor
                                                          .withValues(
                                                              alpha: 0.05),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      border: Border.all(
                                                        color: AppColors
                                                            .whiteColor
                                                            .withValues(
                                                                alpha: 0.06),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Image.asset(
                                                              AppAsset.icCoin)
                                                          .paddingAll(10),
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
                                                        Container(
                                                          width:
                                                              Get.width * 0.50,
                                                          color: Colors
                                                              .transparent,
                                                          child:
                                                              SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: Text(
                                                              logic
                                                                  .getTitleFromType(
                                                                data.type
                                                                        ?.toInt() ??
                                                                    0,
                                                                data.receiverName ??
                                                                    "",
                                                                data.typeDescription ??
                                                                    "",
                                                              ),
                                                              style: AppFontStyle
                                                                  .styleW700(
                                                                      AppColors
                                                                          .whiteColor,
                                                                      15),
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                              softWrap: false,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          logic.dateFormat(
                                                              data.createdAt ??
                                                                  ""),
                                                          style: AppFontStyle
                                                              .styleW700(
                                                                  AppColors
                                                                      .historyTextColor,
                                                                  11),
                                                        ),
                                                        2.height,
                                                        Text(
                                                          "ID : ${logic.getDisplayUniqueId(index, data.uniqueId)}",
                                                          style: AppFontStyle
                                                              .styleW700(
                                                                  AppColors
                                                                      .historyTextColor,
                                                                  11),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  10.width,
                                                  Container(
                                                    height: 30,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12),
                                                    decoration: BoxDecoration(
                                                      color: data.isIncome ==
                                                              false
                                                          ? AppColors.redColor
                                                          : AppColors
                                                              .greenColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              60),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          data.isIncome == false
                                                              ? "-"
                                                              : "+",
                                                          style: AppFontStyle
                                                              .styleW700(
                                                                  AppColors
                                                                      .whiteColor,
                                                                  15),
                                                        ),
                                                        Text(
                                                          "${data.userCoin}",
                                                          style: AppFontStyle
                                                              .styleW800(
                                                                  AppColors
                                                                      .whiteColor,
                                                                  17),
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
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
                    );
            },
          );
  }
}
