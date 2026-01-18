import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopUpBgWidget extends StatefulWidget {
  const TopUpBgWidget({super.key});

  @override
  State<TopUpBgWidget> createState() => _TopUpBgWidgetState();
}

class _TopUpBgWidgetState extends State<TopUpBgWidget> {
  final _image = const AssetImage(AppAsset.imgBgTopUp1);

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
        gradient: AppColors.walletBg,
      ),
    );
  }
}
