import 'dart:io';

import 'package:LoveBirds/custom/app_title/custom_title.dart';
import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/custom/custom_image/host_photo_gallery.dart';
import 'package:LoveBirds/pages/host_detail_page/controller/host_detail_controller.dart';
import 'package:LoveBirds/pages/host_detail_page/widget/reels_player_view.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostDetailMediaView extends StatelessWidget {
  const HostDetailMediaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HostDetailTitle(title: EnumLocale.txtGallery.name.tr)
            .paddingOnly(left: 14),
        10.height,
        GetBuilder<HostDetailController>(
          id: AppConstant.idShowThumbnail,
          builder: (logic) {
            if (logic.mixedMedia.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("No media found",
                    style: TextStyle(color: Colors.white)),
              );
            }
            return SizedBox(
              height: 190,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: logic.mixedMedia.length,
                itemBuilder: (context, index) {
                  final item = logic.mixedMedia[index];

                  return Container(
                    width: 145,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black12,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: item.isVideo
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ReelsPlayerView(
                                    videoUrls: logic.videoUrls,
                                    initialIndex:
                                        logic.videoUrls.indexOf(item.url),
                                  ),
                                ),
                              );
                            },
                            child: _buildVideoItem(logic, item))
                        : GestureDetector(
                            onTap: () {
                              Get.to(FullScreenImageView(
                                  imageUrl: logic.hostDetailModel?.host
                                          ?.photoGallery?[index] ??
                                      ""));
                            },
                            child: _buildPhotoItem(item),
                          ),
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }

  /// --- Build Photo ---
  Widget _buildPhotoItem(MediaItem item) {
    return CustomImage(
      image: item.url,
      fit: BoxFit.cover,
      // width: double.infinity,
      // height: double.infinity,
    );
  }

  /// --- Build Video ---
  Widget _buildVideoItem(HostDetailController logic, MediaItem item) {
    final videoIndex = logic.videoUrls.indexOf(item.url);
    final thumbPath = (videoIndex != -1 && videoIndex < logic.thumbnails.length)
        ? logic.thumbnails[videoIndex]
        : null;

    return Stack(
      fit: StackFit.expand,
      children: [
        thumbPath != null && thumbPath.isNotEmpty
            ? Image.file(
                File(thumbPath),
                fit: BoxFit.cover,
              )
            : Center(
                child:
                    Image.asset(AppAsset.icPlaceHolder, width: 80, height: 80),
              ),
        Align(
          alignment: Alignment.center,
          child: Image.asset(AppAsset.icPlay, height: 50, width: 50),
        )
      ],
    );
  }
}

class MediaItem {
  final String url;
  final bool isVideo;

  MediaItem({required this.url, required this.isVideo});
}
