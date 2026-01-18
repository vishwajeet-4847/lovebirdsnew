import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/pages/host_message_page/api/get_chat_thumb_list_host.dart';
import 'package:LoveBirds/pages/host_message_page/controller/host_message_controller.dart';
import 'package:LoveBirds/pages/host_message_page/model/get_chat_thumb_list_host_model.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostMessageContainer extends StatelessWidget {
  const HostMessageContainer({
    super.key,
    required this.hostChatList,
  });
  final HostChatList hostChatList;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostMessageController>(
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.chatPage, arguments: {
              "hostId": hostChatList.senderId,
              "receiverId": hostChatList.id,
              "hostName": hostChatList.name,
              "profileImage": hostChatList.image,
              "isOnline": hostChatList.isOnline,
              "isFake": false,
            })?.then((_) async {
              GetChatThumbListHostApi.startPagination = 1;
              logic.getHostMessage(isLoadingThen: true);
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
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      image: hostChatList.image ?? "",
                      fit: BoxFit.cover,
                      padding: 8,
                    ),
                  ),
                ),
                10.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hostChatList.name ?? "",
                      style: AppFontStyle.styleW700(AppColors.whiteColor, 19),
                      maxLines: 1,
                    ),
                    2.height,
                    SizedBox(
                      width: Get.width * 0.55,
                      child: Text(
                        hostChatList.message ?? "",
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
                    hostChatList.unreadCount == 0
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
                              hostChatList.unreadCount == 0
                                  ? ""
                                  : hostChatList.unreadCount?.toString() ?? "",
                              style: AppFontStyle.styleW700(
                                  AppColors.whiteColor, 16),
                            ),
                          ),
                    10.height,
                    Text(
                      hostChatList.time ?? "",
                      style:
                          AppFontStyle.styleW600(AppColors.chatDetailColor, 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
