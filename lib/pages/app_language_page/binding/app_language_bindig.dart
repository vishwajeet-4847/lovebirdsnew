import 'package:LoveBirds/pages/app_language_page/controller/app_language_controller.dart';
import 'package:get/get.dart';

class AppLanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppLanguageController>(() => AppLanguageController());
  }
}
