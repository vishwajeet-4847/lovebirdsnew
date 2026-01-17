import 'package:figgy/utils/asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomAppBackground extends StatelessWidget {
  final Widget child;
  const CustomAppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                AppAsset.allBackgroundImage,
              ),
              fit: BoxFit.cover)),
      child: child,
    );
  }
}

class CustomBackground extends StatelessWidget {
  final Widget child;
  const CustomBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(AppAsset.allBackgroundImage), fit: BoxFit.cover)),
      child: child,
    );
  }
}
