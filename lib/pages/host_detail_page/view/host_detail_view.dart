import 'package:LoveBirds/custom/app_background/custom_app_background.dart';
import 'package:LoveBirds/custom/bottom_sheet/video_bottom_sheet.dart';
import 'package:LoveBirds/pages/host_detail_page/controller/host_detail_controller.dart';
import 'package:LoveBirds/pages/host_detail_page/widget/multi_img.dart';
import 'package:LoveBirds/pages/host_detail_page/widget/user_information_widget.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/shimmer/host_view_shimmer.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostDetailView extends StatelessWidget {
  const HostDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.primaryColor1,
      bottomNavigationBar: GetBuilder<HostDetailController>(
        builder: (controller) {
          return controller.isLoading
              ? const SizedBox()
              : Database.isHost
                  ? const Offstage()
                  : Container(
                      decoration: BoxDecoration(
                        color: AppColors.chatBottomColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                        ),
                      ),
                      padding: const EdgeInsets.only(top: 17, bottom: 17),
                      child: GetBuilder<HostDetailController>(
                        id: AppConstant.idFollowToggle,
                        builder: (logic) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              8.width,
                              Expanded(
                                child: CustomButton(
                                  onTap: () {
                                    bool isOnlineBool =
                                        logic.isOnline?.toLowerCase() ==
                                                "online"
                                            ? true
                                            : false;

                                    bool isChatHostDetail = false;

                                    Utils.showLog(
                                        "isChatHostDetail :: $isChatHostDetail");
                                    Utils.showLog(
                                        "isOnlineBool :: $isOnlineBool");
                                    Utils.showLog(
                                        "isOnlineBool :: ${logic.isOnline}");

                                    Get.toNamed(
                                      AppRoutes.chatPage,
                                      arguments: {
                                        "hostId":
                                            logic.hostDetailModel?.host?.id ??
                                                "",
                                        "hostName":
                                            logic.hostDetailModel?.host?.name ??
                                                "",
                                        "profileImage": logic
                                                .hostDetailModel?.host?.image ??
                                            "",
                                        "isOnline": isOnlineBool,
                                        "isChatHostDetail": true,
                                        "isFake":
                                            logic.hostDetailModel?.host?.isFake,
                                      },
                                    );
                                  },
                                  text: EnumLocale.txtMessage.name.tr,
                                  icon: AppAsset.messageIcon2,
                                  rate:
                                      "${logic.hostDetailModel?.host?.chatRate ?? 0}/Message",
                                  gradient: AppColors.message,
                                ),
                              ),
                              8.width,
                              Expanded(
                                child: CustomButton(
                                  onTap: () {
                                    showVideoBottomSheet(
                                      context: context,
                                      receiverId:
                                          logic.hostDetailModel?.host?.id ?? "",
                                      receiverImage:
                                          logic.hostDetailModel?.host?.image ??
                                              "",
                                      receiverName:
                                          logic.hostDetailModel?.host?.name ??
                                              "",
                                      audioCallCharge: logic.hostDetailModel
                                              ?.host?.audioCallRate ??
                                          0,
                                      videoCallCharge: logic.hostDetailModel
                                              ?.host?.privateCallRate ??
                                          0,
                                      isFake:
                                          logic.hostDetailModel?.host?.isFake ==
                                                  true
                                              ? true
                                              : false,
                                      videoList:
                                          logic.hostDetailModel?.host?.video,
                                    );
                                  },
                                  text: EnumLocale.txtCall.name.tr,
                                  icon: AppAsset.icInlineCall,
                                  color: AppColors.whiteColor,
                                  rate:
                                      "${logic.hostDetailModel?.host?.privateCallRate ?? 0}/Min",
                                  gradient: AppColors.call,
                                ),
                              ),
                              8.width,
                            ],
                          ).paddingOnly(bottom: 0);
                        },
                      ),
                    );
        },
      ),
      body: GetBuilder<HostDetailController>(
        builder: (logic) {
          return CustomBackground(
            child: logic.isLoading ? const HostViewShimmer() : const MultiImg(),
          );
        },
      ),
    );
  }
}
