import 'package:LoveBirds/pages/live_end_page/controller/live_end_controller.dart';
import 'package:get/get.dart';

class LiveEndBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveEndController>(() => LiveEndController());
  }
}
