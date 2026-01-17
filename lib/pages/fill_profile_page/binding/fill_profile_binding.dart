import 'package:figgy/custom/cupertino_date_picker/controller/date_picker_controller.dart';
import 'package:figgy/pages/fill_profile_page/controller/fill_profile_controller.dart';
import 'package:get/get.dart';

class FillProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FillProfileController>(() => FillProfileController());
    Get.put(DatePickerController());
  }
}
