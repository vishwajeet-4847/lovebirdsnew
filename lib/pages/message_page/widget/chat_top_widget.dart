import 'package:LoveBirds/common/gradiant_text.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatTopWidget extends StatelessWidget {
  const ChatTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 65,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final text = EnumLocale.txtMessages.name.tr;

              final TextPainter textPainter = TextPainter(
                text: TextSpan(
                  text: text,
                  style: AppFontStyle.styleW700(AppColors.whiteColor, 20),
                ),
                maxLines: 1,
                textDirection: TextDirection.ltr,
              )..layout();

              final double textWidth = textPainter.width;

              return Column(
                children: [
                  GradientText(
                    text: EnumLocale.txtMessages.name.tr,
                    style: AppFontStyle.styleW700(Colors.white, 20),
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.pinkColor,
                        AppColors.blueColor,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  SizedBox(
                    width: textWidth,
                    child: Image.asset(
                      AppAsset.tabIndicator,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    ).paddingOnly(top: 30, left: 16);
  }
}
