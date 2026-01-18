// import 'package:LoveBirds/pages/host_live_streamers_page/controller/host_live_streamers_controller.dart';
// import 'package:LoveBirds/pages/discover_host_for_user_page/model/live_streamers_dummy_model.dart';
// import 'package:LoveBirds/utils/colors_utils.dart';
// import 'package:LoveBirds/utils/constant.dart';
// import 'package:LoveBirds/utils/enum.dart';
// import 'package:LoveBirds/utils/font_style.dart';
// import 'package:LoveBirds/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class HostCountryDialogWidget extends StatelessWidget {
//   const HostCountryDialogWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SimpleDialog(
//       contentPadding: const EdgeInsets.all(10),
//       insetPadding: const EdgeInsets.only(left: 10, right: 10, top: 55),
//       backgroundColor: Colors.transparent,
//       alignment: Alignment.topLeft,
//       clipBehavior: Clip.antiAlias,
//       elevation: 0,
//       children: [
//         Container(
//           height: 250,
//           width: Get.width,
//           decoration: BoxDecoration(
//             color: Colors.black.withValues(alpha: 0.8),
//             borderRadius: const BorderRadius.all(
//               Radius.circular(10),
//             ),
//           ),
//           padding: const EdgeInsets.only(
//             left: 9,
//             top: 20,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: AppColors.googleButtonColor),
//                   color: AppColors.googleButtonColor.withValues(alpha: 0.3),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Text(
//                   EnumLocale.txtAll.name.tr,
//                   style: AppFontStyle.styleW400(AppColors.googleButtonColor, 11),
//                 ),
//               ),
//               15.height,
//               Text(
//                 EnumLocale.txtCountriesAndRegions.name.tr,
//                 style: AppFontStyle.styleW400(AppColors.colorGry, 15),
//               ),
//               20.height,
//               const Wrap(
//                 spacing: 12,
//                 runSpacing: 15,
//                 children: [
//                   HostCountryContainer(index: 0),
//                   HostCountryContainer(index: 1),
//                   HostCountryContainer(index: 2),
//                   HostCountryContainer(index: 3),
//                   HostCountryContainer(index: 4),
//                   HostCountryContainer(index: 3),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class HostCountryContainer extends StatelessWidget {
//   const HostCountryContainer({super.key, required this.index});
//   final int index;
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HostLiveStreamersController>(
//         id: AppConstant.idUserChangeCountry,
//         builder: (logic) {
//           return Container(
//             height: 30,
//             padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
//             decoration: BoxDecoration(
//               border: logic.countryIndex == index ? Border.all(color: AppColors.colorChatPage) : Border.all(color: Colors.transparent),
//               borderRadius: BorderRadius.circular(20),
//               color: logic.countryIndex == index ? AppColors.colorChatPage.withValues(alpha: 0.5) : AppColors.colorGry.withValues(alpha: 0.2),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   height: 15,
//                   width: 15,
//                   clipBehavior: Clip.antiAlias,
//                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
//                   child: Image.network(HostLiveStreamersController.countryImages[index], fit: BoxFit.cover, height: 20),
//                 ),
//                 10.width,
//                 Text(
//                   HostLiveStreamersController.userCountry[index],
//                   style: const TextStyle(color: Colors.white),
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }
