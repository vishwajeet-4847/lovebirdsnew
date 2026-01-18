import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/pages/incoming_audio_call_page/controller/audio_call_controller.dart';
import 'package:LoveBirds/socket/socket_emit.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class IncomingAudioCallView extends StatelessWidget {
  const IncomingAudioCallView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<IncomingAudioCallController>(builder: (logic) {
        return Stack(
          children: [
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: CustomImage(
                image: logic.senderImage ?? "",
                fit: BoxFit.cover,
              ),
            ),
            BlurryContainer(
              blur: 6,
              height: Get.height,
              width: Get.width,
              elevation: 0,
              color: AppColors.blackColor.withValues(alpha: 0.2),
              child: const SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  60.height,
                  Container(
                    alignment: Alignment.center,
                    width: Get.width,
                    child: Text(
                      logic.callType == 'video'
                          ? EnumLocale.txtIncomingVideoCall.name.tr
                          : EnumLocale.txtIncomingAudioCall.name.tr,
                      maxLines: 1,
                      style: AppFontStyle.styleW400(AppColors.whiteColor, 20),
                    ),
                  ),
                  50.height,
                  Container(
                    height: 114,
                    width: 114,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.gradientButtonColor,
                    ),
                    child: Container(
                      height: Get.height,
                      width: Get.width,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.shimmerHighlightColor,
                      ),
                      child: CustomImage(
                        image: logic.senderImage ?? "",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  15.height,
                  Container(
                    alignment: Alignment.center,
                    width: Get.width,
                    child: Text(
                      logic.senderName ?? "",
                      maxLines: 1,
                      style: AppFontStyle.styleW800(AppColors.whiteColor, 22),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          SocketEmit.onCallAcceptOrDecline(
                            callerId: logic.callerId ?? "",
                            receiverId: logic.receiverId ?? "",
                            callId: logic.callId ?? "",
                            isAccept: false,
                            callType: logic.callType ?? "",
                            callMode: logic.callMode ?? "",
                            receiverImage: logic.receiverImage ?? "",
                            receiverName: logic.receiverName ?? "",
                            senderImage: logic.senderImage ?? "",
                            senderName: logic.senderName ?? "",
                            token: logic.token ?? "",
                            channel: logic.channel ?? "",
                            gender: logic.gender ?? "",
                            callerUniqueId: logic.callerUniqueId ?? "",
                            receiverUniqueId: logic.receiverUniqueId ?? "",
                            callerRole: logic.callerRole ?? "",
                            receiverRole: logic.receiverRole ?? "",
                          );
                        },
                        child: Image.asset(
                          AppAsset.imgCallCancel,
                          height: 70,
                        ),
                      ),
                      10.width,
                      GestureDetector(
                        onTap: () {
                          SocketEmit.onCallAcceptOrDecline(
                            callerId: logic.callerId ?? "",
                            receiverId: logic.receiverId ?? "",
                            callId: logic.callId ?? "",
                            isAccept: true,
                            callType: logic.callType ?? "",
                            callMode: logic.callMode ?? "",
                            receiverImage: logic.receiverImage ?? "",
                            receiverName: logic.receiverName ?? "",
                            senderImage: logic.senderImage ?? "",
                            senderName: logic.senderName ?? "",
                            token: logic.token ?? "",
                            channel: logic.channel ?? "",
                            gender: logic.gender ?? "",
                            callerUniqueId: logic.callerUniqueId ?? "",
                            receiverUniqueId: logic.receiverUniqueId ?? "",
                            callerRole: logic.callerRole ?? "",
                            receiverRole: logic.receiverRole ?? "",
                          );
                        },
                        child: Lottie.asset(
                          AppAsset.lottieAnswer,
                          height: 70,
                        ),
                      ),
                    ],
                  ),
                  100.height,
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
