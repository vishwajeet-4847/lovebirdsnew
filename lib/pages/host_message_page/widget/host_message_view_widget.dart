import 'package:figgy/custom/no_data_found/no_data_found.dart';
import 'package:figgy/pages/host_message_page/controller/host_message_controller.dart';
import 'package:figgy/pages/host_message_page/widget/host_message_container.dart';
import 'package:figgy/shimmer/message_shimmer.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostMessageViewWidget extends StatelessWidget {
  const HostMessageViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostMessageController>(
      builder: (logic) {
        return logic.isLoading
            ? ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 5),
                itemCount: 6,
                itemBuilder: (context, index) => const MessageContainerShimmer(),
              )
            : LayoutBuilder(
                builder: (context, box) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      await logic.getHostMessage(isPagination: false);
                    },
                    child: logic.hostThumbList.isEmpty
                        ? SingleChildScrollView(
                            child: SizedBox(
                              height: box.maxHeight + 1,
                              child: NoDataFoundWidget(),
                            ),
                          )
                        : ListView.builder(
                            controller: logic.scrollController,
                            padding: EdgeInsets.zero,
                            itemCount: logic.hostThumbList.length + (logic.hasMoreData ? 1 : 0),
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (index < logic.hostThumbList.length) {
                                return HostMessageContainer(
                                  hostChatList: logic.hostThumbList[index],
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
                  );
                },
              );
      },
    ).paddingOnly(bottom: 75);
  }
}
