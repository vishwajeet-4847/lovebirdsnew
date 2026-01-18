import 'package:LoveBirds/pages/vip_page/controller/vip_controller.dart';
import 'package:LoveBirds/pages/vip_page/widget/main_vip_view_widget.dart';
import 'package:LoveBirds/pages/vip_page/widget/vip_app_bar_widget.dart';
import 'package:LoveBirds/pages/vip_page/widget/vip_user_detail_widget.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VipScreen extends StatefulWidget {
  const VipScreen({super.key});

  @override
  State<VipScreen> createState() => _VipScreenState();
}

class _VipScreenState extends State<VipScreen> {
  final _image = const AssetImage(AppAsset.imgPopVip1);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(_image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: _image,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            25.height,
            const VipAppBarWidget(),
            GetBuilder<VipController>(
              id: AppConstant.idOnCarouselTap1,
              builder: (logic) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const VipUserDetailWidget(),
                    Database.isVip ? 10.height : 20.height,
                    const MainVIPViewWidget(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
