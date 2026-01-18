import 'package:LoveBirds/common/gradiant_text.dart';
import 'package:LoveBirds/pages/host_live_streamers_page/controller/host_live_streamers_controller.dart';
import 'package:LoveBirds/pages/host_live_streamers_page/widget/host_followed.dart';
import 'package:LoveBirds/pages/host_live_streamers_page/widget/host_main_stream_view.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostTabBar extends StatelessWidget {
  const HostTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostLiveStreamersController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            45.height,

            //====================== Custom Tab Bar ======================
            Row(
              children: List.generate(
                controller.tabName.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      controller.onTabChanged(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final text = controller.tabName[index];

                          final TextPainter textPainter = TextPainter(
                            text: TextSpan(
                              text: text,
                              style: AppFontStyle.styleW700(Colors.white, 20),
                            ),
                            maxLines: 1,
                            textDirection: TextDirection.ltr,
                          )..layout();

                          final double textWidth = textPainter.width;

                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              controller.selectedTabIndex == index
                                  ? GradientText(
                                      text: text,
                                      style: AppFontStyle.styleW700(
                                          Colors.white, 20),
                                      gradient: const LinearGradient(
                                        colors: [
                                          AppColors.pinkColor,
                                          AppColors.blueColor,
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    )
                                  : Text(
                                      text,
                                      style: AppFontStyle.styleW600(
                                          AppColors.whiteColor, 18),
                                    ),
                              if (controller.selectedTabIndex == index)
                                Positioned(
                                  bottom: index == 0 ? -6 : -14,
                                  right: 0,
                                  left: 0,
                                  child: SizedBox(
                                    width: textWidth,
                                    child: Image.asset(
                                      AppAsset.tabIndicator,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                )
                              else
                                const SizedBox(height: 4),
                              if (index == 0)
                                Positioned(
                                  right: -18,
                                  top: -7,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.redColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "New",
                                        style: AppFontStyle.styleW600(
                                            AppColors.whiteColor, 7),
                                      ).paddingSymmetric(
                                          vertical: 0, horizontal: 4),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

            15.height,

            //====================== Swipeable Tab Body ==========================
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: const [
                  HostMainStreamView(),
                  HostFollowed(),
                ],
              ),
            ),

            75.height
          ],
        );
      },
    );
  }
}
