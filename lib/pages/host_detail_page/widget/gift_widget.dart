import 'package:cached_network_image/cached_network_image.dart';
import 'package:LoveBirds/custom/app_title/custom_title.dart';
import 'package:LoveBirds/pages/chat_page/widget/chat_center_widget.dart';
import 'package:LoveBirds/pages/host_detail_page/controller/host_detail_controller.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/host_detail_model.dart';

// ---------------- single gift tile using your ReceivedGift model ----------------
class _GiftTile extends StatelessWidget {
  final ReceivedGift gift;
  const _GiftTile({required this.gift});

  bool get _isSvga =>
      (gift.giftType == 3) && ((gift.giftImage ?? '').isNotEmpty);

  String get _svgaUrl => Api.baseUrl + (gift.giftImage ?? "");
  String get _thumbUrl {
    final t = gift.giftsvgaImage;
    if ((t ?? '').isNotEmpty) return Api.baseUrl + t!;
    return Api.baseUrl + (gift.giftImage ?? ""); // fallback
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 126,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.receiveGiftBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: _isSvga
                  ? GiftSvgaOnce(
                      svgaUrl: _svgaUrl,
                      thumbUrl: _thumbUrl,
                      // size: const Siz+e(70, 70),
                      autoPlayFirstTime: false, // first view par bhi manual
                      onTryPlay: () async {
                        // OPTIONAL: parent ni policy — true karo to play allow
                        // e.g. coins check, cooldown, etc.
                        return true;
                      },
                    )
                  : CachedNetworkImage(
                      imageUrl: Api.baseUrl + (gift.giftImage ?? ""),
                      width: 70,
                      height: 70,
                      fit: BoxFit.contain,
                      placeholder: (_, __) =>
                          Image.asset(AppAsset.icPlaceHolder),
                      errorWidget: (_, __, ___) =>
                          Image.asset(AppAsset.icPlaceHolder),
                    ),
            ),
          ),
          Container(
            height: 38,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xff462766),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            alignment: Alignment.center,
            child: Text(
              "x${gift.totalReceived ?? 0}",
              style: AppFontStyle.styleW700(AppColors.yellowColor1, 14),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- use it in your list ----------------
class HostDetailsGiftWidget extends StatelessWidget {
  const HostDetailsGiftWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostDetailController>(
      builder: (logic) {
        final gifts = logic.receivedGifts; // List<ReceivedGift>
        if (gifts.isEmpty) return const SizedBox();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HostDetailTitle(title: EnumLocale.txtReceivedGifts.name.tr)
                .paddingOnly(left: 14),
            10.height,
            SizedBox(
              height: Get.height * 0.17,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: gifts.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final gift = gifts[index];
                  // Key helps keep play/pause state stable while scrolling
                  return KeyedSubtree(
                    key: ValueKey(gift.giftId ?? gift.id ?? index),
                    child: _GiftTile(gift: gift),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
