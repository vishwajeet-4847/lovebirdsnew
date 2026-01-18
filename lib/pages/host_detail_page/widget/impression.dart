import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/host_detail_controller.dart';
import 'information_widget.dart';

class Impression extends StatelessWidget {
  const Impression({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          "Impression",
          style: AppFontStyle.styleW400(AppColors.colorGry, 16),
        ),
        const SizedBox(height: 20),
        GetBuilder<HostDetailController>(
          builder: (logic) {
            return SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 12,
                runSpacing: 15,
                children: logic.impression
                    .map((text) => ImpressionWidget(text: text))
                    .toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}
