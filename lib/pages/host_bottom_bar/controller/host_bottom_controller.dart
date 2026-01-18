import 'package:LoveBirds/pages/host_live_streamers_page/view/host_live_streamers_view.dart';
import 'package:LoveBirds/pages/host_message_page/view/host_message_view.dart';
import 'package:LoveBirds/pages/profile_page/view/profile_view.dart';
import 'package:LoveBirds/socket/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HostBottomBarController extends GetxController {
  int currentIndex = 0;

  @override
  Future<void> onInit() async {
    await SocketServices.onConnect();
    super.onInit();
  }

  final List<Widget> pages = [
    const HostLiveStreamersView(),
    const HostMessageView(),
    const ProfileView(),
  ];

  void changeTab(int index) {
    currentIndex = index;

    update();
  }
}
