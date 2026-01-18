// import 'package:LoveBirds/custom/custom_image/custom_image.dart';
// import 'package:LoveBirds/pages/profile_page/controller/profile_controller.dart';
// import 'package:LoveBirds/routes/app_routes.dart';
// import 'package:LoveBirds/utils/api.dart';
// import 'package:LoveBirds/utils/asset.dart';
// import 'package:LoveBirds/utils/colors_utils.dart';
// import 'package:LoveBirds/utils/database.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ProfilePictureWidget extends StatelessWidget {
//   const ProfilePictureWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProfileViewController>(
//       builder: (logic) {
//         return GestureDetector(
//           onTap: () => Database.isHost ? Get.toNamed(AppRoutes.hostEditProfilePage) : Get.toNamed(AppRoutes.editProfilePage),
//           child: Center(
//             child: SizedBox(
//               width: 124, // Total container size
//               height: 124,
//               child: Stack(
//                 clipBehavior: Clip.none,
//                 alignment: Alignment.center,
//                 children: [
//                   //************** Profile picture
//                   Container(
//                     width: 100,
//                     height: 100,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                     ),
//                     child: ClipOval(
//                       child: Database.profileImage.isEmpty
//                           ? Image.asset(
//                               AppAsset.imgEmptyImg,
//                               fit: BoxFit.cover,
//                             )
//                           : CustomProfileImage(
//                               image: Database.profileImage,
//                               fit: BoxFit.cover,
//                             ),
//                     ),
//                   ),
//
//                   //************** VIP Frame
//                   if (Database.isVip)
//                     Positioned(
//                       top: -12, // Adjust these values to perfectly align
//                       left: -12,
//                       right: -12,
//                       bottom: -12,
//                       child: Image.network(
//                         Api.baseUrl + Database.isVipFrameBadge,
//                         width: 124,
//                         height: 124,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//
//                   //************** Edit Button
//                   Positioned(
//                     right: -0,
//                     bottom: -0,
//                     child: Container(
//                       height: 32,
//                       width: 32,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: AppColors.colorDimButton,
//                         border: Border.all(color: AppColors.whiteColor, width: 2),
//                       ),
//                       child: Center(
//                         child: Image.asset(
//                           AppAsset.icEdit,
//                           width: 18,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ).paddingOnly(top: 60),
//         );
//       },
//     );
//   }
// }

import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/pages/profile_page/controller/profile_controller.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewController>(
      builder: (logic) {
        return SizedBox(
          width: 150,
          height: 150,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: Colors.transparent,
                  ),
                  gradient: const LinearGradient(
                    colors: [AppColors.blueColor, AppColors.pinkColor],
                  ),
                ),
                child: ClipOval(
                  child: Database.profileImage.isEmpty
                      ? Image.asset(
                          AppAsset.imgEmptyImg,
                          fit: BoxFit.cover,
                        )
                      : CustomImage(
                          image: Database.profileImage,
                          fit: BoxFit.cover,
                        ),
                ),
              ),

              //************* VIP Frame
              if (!Database.isHost)
                if (Database.isVip)
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    bottom: 0,
                    child: Transform.scale(
                      scale: 1.1,
                      child: IgnorePointer(
                        ignoring: true,
                        child: Image.network(
                          Api.baseUrl + Database.isVipFrameBadge,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ).paddingOnly(top: 50);
      },
    );
  }
}
