import 'package:figgy/pages/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:figgy/pages/bottom_bar/widget/bottom_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBarView extends StatelessWidget {
  const BottomBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: GetBuilder<BottomBarController>(
        builder: (logic) {
          return PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: logic.pages.length,
            itemBuilder: (context, index) {
              return logic.pages[logic.currentIndex];
            },
          );
        },
      ),
      bottomNavigationBar: const BottomViewUi(),
    );
  }
}
