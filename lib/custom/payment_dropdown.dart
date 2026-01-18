import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentDropdown extends StatefulWidget {
  const PaymentDropdown({super.key});

  @override
  State<PaymentDropdown> createState() => _PaymentDropdownState();
}

class _PaymentDropdownState extends State<PaymentDropdown> {
  bool isExpanded = false;

  final paymentMethodList = [
    {"icon": AppAsset.icRazorPayLogo, "title": "Razor Pay", "size": "35.0"},
    {"icon": AppAsset.icStripeLogo, "title": "Stripe", "size": "35.0"},
    {"icon": AppAsset.icFlutterWaveLogo, "title": "Flutter Wave", "size": "30"},
  ];

  Map<String, String> selectedMethod = {
    "icon": AppAsset.icRazorPayLogo,
    "title": "Razor Pay",
    "size": "35.0",
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Dropdown button
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            height: 56,
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.settingColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Image.asset(
                  selectedMethod["icon"]!,
                  height: double.parse(selectedMethod["size"]!),
                  width: double.parse(selectedMethod["size"]!),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    selectedMethod["title"]!,
                    style: AppFontStyle.styleW600(AppColors.whiteColor, 17),
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
              ],
            ),
          ).paddingSymmetric(horizontal: 16),
        ),

        /// Dropdown menu
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          height: isExpanded ? paymentMethodList.length * 56.0 : 0,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: paymentMethodList.map((method) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedMethod = method;
                    isExpanded = false;
                  });
                },
                child: Container(
                  height: 56,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.settingColor,
                    border: Border(
                      top: BorderSide(
                          color: Colors.white.withValues(alpha: 0.1)),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        method["icon"]!,
                        height: double.parse(method["size"]!),
                        width: double.parse(method["size"]!),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        method["title"]!,
                        style: AppFontStyle.styleW600(AppColors.whiteColor, 17),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }
}
