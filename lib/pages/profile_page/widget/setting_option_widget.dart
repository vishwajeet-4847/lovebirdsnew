// import 'package:LoveBirds/utils/asset.dart';
// import 'package:LoveBirds/utils/colors_utils.dart';
// import 'package:LoveBirds/utils/font_style.dart';
// import 'package:LoveBirds/utils/utils.dart';
// import 'package:flutter/material.dart';
//
// class SettingsOptionItemWidget extends StatelessWidget {
//   final String text;
//   final String icon;
//   final void Function() onTap;
//
//   const SettingsOptionItemWidget({
//     super.key,
//     required this.text,
//     required this.icon,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Row(
//           children: [
//             SizedBox(
//               height: 25,
//               child: Image.asset(
//                 icon,
//                 color: AppColors.whiteColor,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             15.width,
//             Expanded(
//               child: Text(
//                 text,
//                 style: AppFontStyle.styleW500(AppColors.whiteColor, 18),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//               child: Image.asset(
//                 AppAsset.icRightBackArrow,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsOptionItemWidget extends StatelessWidget {
  final String text;
  final String icon;
  final void Function() onTap;
  final Color color;

  const SettingsOptionItemWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.settingColor,
        border: Border.all(color: AppColors.whiteColor.withValues(alpha: 0.14)),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              height: 54,
              width: 54,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(14)),
              child: Center(
                child: SizedBox(
                  height: 30,
                  child: Image.asset(
                    icon,
                    color: AppColors.whiteColor,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            15.width,
            Expanded(
              child: Text(
                text,
                style: AppFontStyle.styleW700(AppColors.whiteColor, 18),
              ),
            ),
            SizedBox(
              height: 24,
              child: Image.asset(
                AppAsset.purpleForward,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    ).paddingOnly(left: 14, right: 14, top: 20);
  }
}
