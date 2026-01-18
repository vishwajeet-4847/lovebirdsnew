import 'package:LoveBirds/pages/fake_live_page/controller/fake_live_controller.dart';
import 'package:get/get.dart';

class FakeLiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FakeLiveController>(() => FakeLiveController());
  }
}
