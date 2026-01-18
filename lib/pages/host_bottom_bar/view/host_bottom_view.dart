import 'package:LoveBirds/pages/host_bottom_bar/controller/host_bottom_controller.dart';
import 'package:LoveBirds/pages/host_bottom_bar/widget/host_bottom_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostBottomView extends StatelessWidget {
  const HostBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: GetBuilder<HostBottomBarController>(
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
      bottomNavigationBar: const HostBottomViewUi(),
    );
  }
}
