import 'package:figgy/pages/host_live_streamers_page/controller/host_live_streamers_controller.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/constant.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostCountryView extends StatelessWidget {
  const HostCountryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      alignment: Alignment.center,
      child: GetBuilder<HostLiveStreamersController>(
        id: AppConstant.idHostStreamPage1,
        builder: (logic) {
          return Row(
            children: [
              logic.filterCountry.isEmpty
                  ? Container()
                  : logic.filterCountry == 'World Wide'
                      ? const SizedBox()
                      : GestureDetector(
                          onTap: () {
                            logic.filterData();
                          },
                          child: Container(
                            height: 30,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              gradient: AppColors.hostNextButton,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.whiteColor),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  logic.filterCountry,
                                  style: AppFontStyle.styleW600(AppColors.whiteColor, 12),
                                ),
                                3.width,
                                Image.asset(
                                  AppAsset.icClose,
                                  color: AppColors.whiteColor,
                                  height: 12,
                                )
                              ],
                            ),
                          ),
                        ).paddingOnly(left: 15),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  scrollDirection: Axis.horizontal,
                  itemCount: logic.userCountry.length,
                  itemBuilder: (context, index) {
                    final indexData = logic.userCountry[index];
                    final bool isSelected = logic.selectedCountry.trim().toLowerCase() == indexData.trim().toLowerCase();

                    return isSelected
                        ? GestureDetector(
                            onTap: () => logic.countryTab(index: index),
                            child: Container(
                              // margin: const EdgeInsets.symmetric(horizontal: 8),
                              // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                  // color:AppColors.colorTextGrey.withValues(alpha: 0.22),
                                  border: Border.all(color: AppColors.whiteColor),
                                  gradient: AppColors.hostNextButton),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // index==0?SizedBox():Container(
                                  //   height: 20,
                                  //   width: 20,
                                  //   decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: AppColors.whiteColor)),
                                  // ),index==0?SizedBox():10.width,
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: index == 0 ? 16 : 9,
                                    ),
                                    child: index == 0
                                        ? const Offstage()
                                        : Container(
                                            decoration: BoxDecoration(border: Border.all(color: AppColors.whiteColor), shape: BoxShape.circle),
                                            child: Image.asset(
                                              logic.userCountryFlag[index],
                                              width: 18,
                                              height: 18,
                                            ),
                                          ),
                                  ),
                                  index == 0 ? const SizedBox() : 7.width,
                                  Padding(
                                    padding: EdgeInsets.only(right: index == 0 ? 16 : 9),
                                    child: Text(
                                      logic.userCountry[index],
                                      style: AppFontStyle.styleW600(AppColors.whiteColor, 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).paddingOnly(left: 8)
                        : GestureDetector(
                            onTap: () => logic.countryTab(index: index),
                            child: Container(
                              // margin: const EdgeInsets.symmetric(horizontal: 8),
                              // padding: const EdgeInsets.only(left: 16, bottom: 8, right: 16),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                color: AppColors.colorTextGrey.withValues(alpha: 0.22),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: index == 0 ? 16 : 9,
                                    ),
                                    child: index == 0
                                        ? const Offstage()
                                        : Container(
                                            decoration: BoxDecoration(border: Border.all(color: AppColors.whiteColor), shape: BoxShape.circle),
                                            child: Image.asset(
                                              logic.userCountryFlag[index],
                                              width: 18,
                                              height: 18,
                                            ),
                                          ),
                                  ),
                                  index == 0 ? const SizedBox() : 7.width,
                                  Padding(
                                    padding: EdgeInsets.only(right: index == 0 ? 16 : 9),
                                    child: Text(
                                      logic.userCountry[index],
                                      style: AppFontStyle.styleW600(AppColors.whiteColor, 12),
                                    ),
                                  ),
                                ],
                              ),
                            ).paddingOnly(left: 8),
                          );
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  logic.onChangeCountry(context);
                },
                child: Container(
                  width: Get.width * 0.13,
                  decoration: const BoxDecoration(
                      color: AppColors.globalColor,
                      boxShadow: [BoxShadow(color: AppColors.globalColor, spreadRadius: 10, blurRadius: 10, offset: Offset(0, 0))]),
                  child: Center(
                    child: Image.asset(
                      AppAsset.globalIcon,
                      height: 25,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
