import 'package:figgy/utils/asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors_utils.dart';

class HostChatBgImageWidget extends StatelessWidget {
  const HostChatBgImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Image(
        image: const AssetImage(AppAsset.allBackgroundImage),
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          return Container(
            decoration: BoxDecoration(
              gradient: AppColors.incomingCallGradient,
            ),
            child: child,
          );
        },
        fit: BoxFit.cover,
      ),
    );
  }
}
class HostChatDetailBgImageWidget extends StatelessWidget {
  const HostChatDetailBgImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Image(
        image: const AssetImage(AppAsset.chatBackground),
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          return Container(
            decoration: BoxDecoration(
              gradient: AppColors.incomingCallGradient,
            ),
            child: child,
          );
        },
        fit: BoxFit.cover,
      ),
    );
  }
}
