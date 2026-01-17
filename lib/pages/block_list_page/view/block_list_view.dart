import 'package:figgy/pages/block_list_page/view/demo_block_list_view.dart';
import 'package:figgy/pages/block_list_page/widget/host_block_view.dart';
import 'package:figgy/pages/block_list_page/widget/user_block_view.dart';
import 'package:figgy/utils/database.dart';
import 'package:flutter/material.dart';

class BlockListView extends StatelessWidget {
  const BlockListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Database.isDemoLogin == true
        ? const DemoBlockListView()
        : Database.isHost
            ? const HostBlockView()
            : const UserBlockView();
  }
}
