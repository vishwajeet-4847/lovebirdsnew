import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoinBadge extends StatelessWidget {
  final double top;
  final double right;
  final String getBuilderId;
  final VoidCallback onTap;
  final int coin;

  const CoinBadge({
    super.key,
    required this.top,
    required this.right,
    required this.getBuilderId,
    required this.onTap,
    required this.coin,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      child: GetBuilder(
        id: getBuilderId,
        builder: (_) {
          return GestureDetector(
            onTap: onTap,
            child: Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.colorDimButton),
                borderRadius: BorderRadius.circular(50),
                gradient: AppColors.gradientButtonColor,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppAsset.coinIcon2,
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    coin.toString(),
                    style: AppFontStyle.styleW800(
                      AppColors.whiteColor,
                      16,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
