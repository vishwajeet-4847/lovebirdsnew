import 'package:figgy/pages/host_detail_page/widget/gift_widget.dart';
import 'package:figgy/pages/host_detail_page/widget/user_information_widget.dart';
import 'package:figgy/pages/host_detail_page/widget/user_photos_widget.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';

class UserBottomViewWidget extends StatelessWidget {
  const UserBottomViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          19.height,
          const HostDetailLanguageWidget(),
          const HostDetailMediaView(),
          19.height,
          const HostDetailsGiftWidget(),
          100.height,
        ],
      ),
    );
  }
}
