import 'package:LoveBirds/pages/host_detail_page/controller/host_detail_controller.dart';
import 'package:get/get.dart';

class HostDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HostDetailController>(() => HostDetailController());
  }
}
