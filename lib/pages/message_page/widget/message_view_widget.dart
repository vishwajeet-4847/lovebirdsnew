import 'package:figgy/custom/no_data_found/no_data_found.dart';
import 'package:figgy/pages/message_page/api/get_chat_thumb_list_user.dart';
import 'package:figgy/pages/message_page/controller/message_controller.dart';
import 'package:figgy/pages/message_page/widget/message_container.dart';
import 'package:figgy/shimmer/message_shimmer.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageViewWidget extends StatelessWidget {
  const MessageViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      builder: (logic) {
        return logic.isLoading
            ? ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 5),
                itemBuilder: (context, index) => const MessageContainerShimmer(),
                itemCount: 6,
              )
            : LayoutBuilder(
                builder: (context, box) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      GetChatThumbListUser.startPagination = 1;
                      await logic.getUserMessage(isPagination: false);
                    },
                    child: logic.userThumbList.isEmpty
                        ? SingleChildScrollView(
                            child: SizedBox(
                              height: box.maxHeight + 1,
                              child: NoDataFoundWidget(),
                            ),
                          )
                        : SingleChildScrollView(
                            child: SizedBox(
                              height: box.maxHeight + 1,
                              child: SingleChildScrollView(
                                controller: logic.scrollController,
                                child: ListView.builder(
                                  controller: logic.scrollController,
                                  padding: EdgeInsets.zero,
                                  itemCount: logic.userThumbList.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    if (index < logic.userThumbList.length) {
                                      return MessageContainer(
                                        chatList: logic.userThumbList[index],
                                      );
                                    } else {
                                      return Visibility(
                                        visible: logic.isPaginationLoading,
                                        child: SizedBox(
                                          height: 2.5,
                                          child: LinearProgressIndicator(
                                            color: AppColors.chatDetailTopColor,
                                            backgroundColor: Colors.grey[300],
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                  );
                },
              );
      },
    ).paddingOnly(bottom: 75);
  }
}
