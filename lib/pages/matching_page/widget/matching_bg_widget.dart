import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatchingBgWidget extends StatefulWidget {
  const MatchingBgWidget({super.key});

  @override
  State<MatchingBgWidget> createState() => _MatchingBgWidgetState();
}

class _MatchingBgWidgetState extends State<MatchingBgWidget> {
  final _image = const AssetImage(AppAsset.imgBgMine1);

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
