import 'package:LoveBirds/pages/top_up_page/controller/top_up_controller.dart';
import 'package:get/get.dart';

class TopUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopUpController>(() => TopUpController());
  }
}
