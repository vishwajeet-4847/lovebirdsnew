import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomAppImageBackground extends StatelessWidget {
  final Widget child;
  const CustomAppImageBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        gradient: AppColors.bgGradient,
        image: const DecorationImage(
          image: AssetImage(AppAsset.allBackgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
