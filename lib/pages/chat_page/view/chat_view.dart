import 'package:LoveBirds/custom/custom_format_audio_time.dart';
import 'package:LoveBirds/pages/chat_page/controller/chat_controller.dart';
import 'package:LoveBirds/pages/chat_page/widget/chat_bottom_widget.dart';
import 'package:LoveBirds/pages/chat_page/widget/chat_center_widget.dart';
import 'package:LoveBirds/pages/chat_page/widget/chat_top_widget.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColors.settingColor,
          image: const DecorationImage(
            image: AssetImage(AppAsset.chatBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const ChatTopWidget(),
            GetBuilder<ChatController>(
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
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Stack(
                        children: [
                          const ChatCenterWidget(),
                          Positioned(
                            top: Get.height * 0.03,
                            left: Get.width / 2 - 40,
                            child: GetBuilder<ChatController>(
                              id: AppConstant.idOnChangeAudioRecordingEvent,
                              builder: (logic) {
                                return Visibility(
                                  visible: logic.isRecordingAudio,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColors.redColor
                                          .withValues(alpha: 0.7),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    height: 20,
                                    width: 70,
                                    child: Text(
                                      CustomFormatAudioTime.convert(
                                          controller.countTime),
                                      style: TextStyle(
                                          color: AppColors.whiteColor),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const ChatBottomViewWidget(),
          ],
        ),
      ),
    );
  }
}
