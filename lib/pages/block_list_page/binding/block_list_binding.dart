import 'package:LoveBirds/pages/block_list_page/controller/block_list_controller.dart';
import 'package:get/get.dart';

class BlockBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlockController>(() => BlockController());
  }
}
