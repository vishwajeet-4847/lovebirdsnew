import 'package:LoveBirds/common/coin_badge.dart';
import 'package:LoveBirds/pages/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:LoveBirds/pages/host_message_page/widget/host_chat_top_widget.dart';
import 'package:LoveBirds/pages/message_page/controller/message_controller.dart';
import 'package:LoveBirds/pages/message_page/widget/message_view_widget.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    Database.isAutoRefreshEnabled == false
        ? Get.put(MessageController(), permanent: true)
        : Get.lazyPut<MessageController>(() => MessageController(),
            fenix: true);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        Get.find<BottomBarController>().changeTab(0);
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
          backgroundColor: AppColors.bgColor,
          body: Stack(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAsset.allBackgroundImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Column(
                  children: [
                    HostChatTopWidget(),
                    Expanded(child: MessageViewWidget()),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 10,
                right: 12,
                child: GetBuilder<MessageController>(
                  id: AppConstant.idUpdateCoin,
                  builder: (logic) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.topUpPage)?.then((_) async {
                          await logic.getUpdatedCoin();
                        });
                      },
                      child: Container(
                        height: 32,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.colorDimButton),
                          borderRadius: BorderRadius.circular(50),
                          gradient: AppColors.gradientButtonColor,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              AppAsset.coinIcon2,
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              Database.coin.toString().split('.')[0],
                              style: AppFontStyle.styleW800(
                                AppColors.whiteColor,
                                16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
