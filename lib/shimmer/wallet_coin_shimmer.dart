import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class WalletCoinShimmer extends StatelessWidget {
  const WalletCoinShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade600,
      child: Container(
        height: 70,
        width: Get.width,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            10.width,
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            10.width,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 12, width: 120, color: Colors.grey),
                  const SizedBox(height: 5),
                  Container(height: 8, width: 80, color: Colors.grey),
                  const SizedBox(height: 5),
                  Container(height: 8, width: 100, color: Colors.grey),
                ],
              ),
            ),
            10.width,
            Container(
              height: 34,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(60),
              ),
            ),
            10.width,
          ],
        ),
      ),
    );
  }
}
