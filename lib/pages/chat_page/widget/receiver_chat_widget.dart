import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/pages/chat_page/controller/chat_controller.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReceiverChatWidget extends StatelessWidget {
  const ReceiverChatWidget({
    super.key,
    required this.message,
    required this.time,
  });

  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GetBuilder<ChatController>(
          builder: (logic) {
            return Container(
              padding: const EdgeInsets.all(1.2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Container(
                clipBehavior: Clip.antiAlias,
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorTextGrey.withAlpha(56),
                ),
                child: CustomImage(
                  padding: 8,
                  image: logic.profileImage,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 10),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Get.width / 2,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: const BoxDecoration(
              color: AppColors.pinkMessageColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message,
                  style: AppFontStyle.styleW600(AppColors.whiteColor, 16),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
                const SizedBox(height: 4),
                GetBuilder<ChatController>(
                  builder: (logic) {
                    return Text(
                      logic.formatTimeFromApi(time),
                      style: AppFontStyle.styleW700(AppColors.whiteColor, 8),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    ).paddingOnly(bottom: 15);
  }
}
