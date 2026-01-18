import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackgroundImageRandomPageWidget extends StatefulWidget {
  const BackgroundImageRandomPageWidget({super.key});

  @override
  State<BackgroundImageRandomPageWidget> createState() =>
      _BackgroundImageRandomPageWidgetState();
}

class _BackgroundImageRandomPageWidgetState
    extends State<BackgroundImageRandomPageWidget> {
  final _image = const AssetImage(AppAsset.imaRandomBg1);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(_image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        image: DecorationImage(image: _image, fit: BoxFit.cover),
        color: AppColors.bgColor,
      ),
    );
  }
}
