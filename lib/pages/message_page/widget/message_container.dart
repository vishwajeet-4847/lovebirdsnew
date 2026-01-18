import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/custom/other/custom_fetch_user_coin.dart';
import 'package:LoveBirds/pages/message_page/controller/message_controller.dart';
import 'package:LoveBirds/pages/message_page/model/get_chat_thumb_list_user_model.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({super.key, this.chatList});
  final ChatList? chatList;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(
              AppRoutes.chatPage,
              arguments: {
                "senderId": chatList?.senderId ?? "",
                "hostId": chatList?.receiverId ?? "",
                "hostName": chatList?.name ?? "",
                "profileImage": chatList?.image ?? "",
                "isOnline": chatList?.isOnline ?? "",
                "isChatHostDetail": false,
                "isFake": chatList?.isFake ?? true,
              },
            )?.then((_) async {
              logic.getUserMessage(isLoadingThen: true);
              Database.isHost ? const Offstage() : CustomFetchUserCoin.init();
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.purpleColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.whiteColor.withValues(alpha: 0.10),
              ),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(1.5),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.whiteColor.withValues(alpha: 0.70),
                      ),
                      shape: BoxShape.circle),
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.colorTextGrey.withValues(alpha: 0.22),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: CustomImage(
                      padding: 8,
                      image: chatList?.image ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                10.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatList?.name ?? "",
                      style: AppFontStyle.styleW700(AppColors.whiteColor, 19),
                      maxLines: 1,
                    ),
                    2.height,
                    SizedBox(
                      width: Get.width * 0.55,
                      child: Text(
                        chatList?.message ?? "",
                        style: AppFontStyle.styleW500(
                            AppColors.chatDetailColor, 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    chatList?.unreadCount == 0
                        ? const SizedBox(
                            height: 28,
                            width: 28,
                          )
                        : Container(
                            alignment: Alignment.center,
                            height: 28,
                            width: 28,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.unReadColor,
                            ),
                            child: Text(
                              chatList?.unreadCount == 0
                                  ? ""
                                  : chatList?.unreadCount?.toString() ?? "",
                              style: AppFontStyle.styleW700(
                                  AppColors.whiteColor, 16),
                            ),
                          ),
                    10.height,
                    Text(
                      chatList?.time ?? "",
                      style:
                          AppFontStyle.styleW600(AppColors.chatDetailColor, 12),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
