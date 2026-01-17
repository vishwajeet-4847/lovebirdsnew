import 'package:figgy/utils/asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatBgImageWidget extends StatelessWidget {
  const ChatBgImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Image(
        image: const AssetImage(AppAsset.allBackgroundImage),
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          return Container(
            decoration: const BoxDecoration(),
            child: child,
          );
        },
        fit: BoxFit.cover,
      ),
    );
  }
}
