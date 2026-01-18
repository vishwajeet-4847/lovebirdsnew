import 'package:LoveBirds/pages/random_match_page/controller/random_match_controller.dart';
import 'package:get/get.dart';

class RandomMatchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RandomMatchController>(() => RandomMatchController());
  }
}
