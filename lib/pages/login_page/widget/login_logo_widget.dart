import 'package:figgy/utils/asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginLogoWidget extends StatelessWidget {
  const LoginLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Get.height * 0.3,
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: Get.width,
          height: 100,
          child: const Image(
            image: AssetImage(AppAsset.icLogo),
          ),
        ),
      ),
    );
  }
}
