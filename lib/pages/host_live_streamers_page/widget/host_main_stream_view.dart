import 'package:LoveBirds/pages/host_live_streamers_page/widget/host_country_view.dart';
import 'package:LoveBirds/pages/host_live_streamers_page/widget/host_stream_bottom_widget.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';

class HostMainStreamView extends StatelessWidget {
  const HostMainStreamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        7.height,

        //************** Country view
        const HostCountryView(),

        19.height,

        //************** Host stream bottom view
        const HostStreamBottomWidget(),

        // 80.height
      ],
    );
  }
}
