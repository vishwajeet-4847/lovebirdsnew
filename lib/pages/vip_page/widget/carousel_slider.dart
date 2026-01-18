import 'package:carousel_slider/carousel_slider.dart';
import 'package:LoveBirds/pages/vip_page/controller/vip_controller.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'carousel_widget.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VipController>(
      id: AppConstant.idOnCarouselTap1,
      builder: (logic) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (logic.carouselIndex == 0 && logic.vipPrivilegeList.isNotEmpty) {
            logic.carouselController.animateToPage(
              0,
              duration: const Duration(milliseconds: 100),
              curve: Curves.fastOutSlowIn,
            );
          }
        });
        return CarouselSlider(
          items: logic.vipPrivilegeList.map((item) {
            final vipItem = item;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 19),
              decoration: BoxDecoration(
                color: AppColors.whiteColor.withValues(alpha: 0.06),
                border: Border.all(
                  color: AppColors.pinkColor.withValues(alpha: 0.50),
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: VipCarouselWidget(
                title: vipItem.title,
                textSpan1: vipItem.textSpan1,
                textSpan2: vipItem.textSpan2,
                textSpan3: vipItem.textSpan3,
                image: vipItem.image,
              ),
            );
          }).toList(),
          carouselController: logic.carouselController,
          options: CarouselOptions(
            onPageChanged: (index, reason) => logic.onCarouselTap(id: index),
            height: 190,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
  }
}
