import 'package:figgy/common/gradiant_text.dart';
import 'package:figgy/pages/discover_host_for_user_page/controller/discover_host_for_user_controller.dart';
import 'package:figgy/pages/discover_host_for_user_page/widget/discover_host_for_user_following_tab.dart';
import 'package:figgy/pages/discover_host_for_user_page/widget/discover_host_for_user_live_host_tab.dart';
import 'package:figgy/pages/discover_host_for_user_page/widget/discover_host_for_user_tab.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/enum.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> tabName = [EnumLocale.txtLiveHost.name.tr, EnumLocale.txtHost.name.tr, EnumLocale.txtFollowing.name.tr];

    return GetBuilder<DiscoverHostForUserController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            60.height,
            Row(
              children: List.generate(
                tabName.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      controller.onTabChanged(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final text = tabName[index];

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
                                      style: AppFontStyle.styleW700(Colors.white, 20),
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
                                      style: AppFontStyle.styleW600(AppColors.whiteColor, 18),
                                    ),
                              if (controller.selectedTabIndex == index)
                                Positioned(
                                  bottom: index == 0 ? -15 : (index == 1 ? -6 : (index == 2 ? -17 : -15)),
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
                                    child: Text(
                                      "New",
                                      style: AppFontStyle.styleW600(AppColors.whiteColor, 7),
                                    ).paddingSymmetric(vertical: 0, horizontal: 4),
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
            21.height,
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: const [
                  DiscoverHostForUserLiveHostTab(),
                  DiscoverHostForUserTab(),
                  DiscoverHostForUserFollowingTab(),
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
