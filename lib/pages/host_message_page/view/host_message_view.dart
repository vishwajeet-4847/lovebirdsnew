import 'package:figgy/pages/host_bottom_bar/controller/host_bottom_controller.dart';
import 'package:figgy/pages/host_message_page/controller/host_message_controller.dart';
import 'package:figgy/pages/host_message_page/widget/host_message_view_widget.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../message_page/widget/chat_top_widget.dart';

class HostMessageView extends StatelessWidget {
  const HostMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    Database.isAutoRefreshEnabled == false
        ? Get.put(HostMessageController(), permanent: true)
        : Get.lazyPut<HostMessageController>(() => HostMessageController(), fenix: true);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        Get.find<HostBottomBarController>().changeTab(0);
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Container(
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
              ChatTopWidget(),
              Expanded(child: HostMessageViewWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
