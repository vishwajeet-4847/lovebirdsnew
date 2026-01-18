import 'dart:io';

import 'package:LoveBirds/pages/host_detail_page/widget/reels_player_view.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewAllHostVideoScreen extends StatelessWidget {
  final List<String> videoUrls;
  final List<String> thumbnail;
  const ViewAllHostVideoScreen(
      {super.key, required this.videoUrls, required this.thumbnail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAsset.allBackgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).viewPadding.top + 72,
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
              alignment: Alignment.center,
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.chatDetailTopColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        AppAsset.icLeftArrow,
                        width: 10,
                      ),
                    ),
                  ),
                  Text(
                    EnumLocale.txtMyVideo.name.tr,
                    style: AppFontStyle.styleW700(AppColors.whiteColor, 20),
                  ),
                  45.width,
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.80,
                ),
                itemCount: videoUrls.length,
                itemBuilder: (context, index) {
                  final thumbPath =
                      thumbnail.isNotEmpty ? thumbnail[index] : null;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ReelsPlayerView(
                            videoUrls: videoUrls,
                            initialIndex: index,
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: Colors.black12,
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: thumbPath != null
                              ? Image.file(
                                  File(thumbPath),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                )
                              : Center(
                                  child: Image.asset(
                                    AppAsset.icPlaceHolder,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                        ),
                        Center(
                          child: Image.asset(
                            AppAsset.icPlay,
                            height: 60,
                            width: 60,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).paddingOnly(left: 15, right: 15),
            ),
          ],
        ),
      ),
    );
  }
}
