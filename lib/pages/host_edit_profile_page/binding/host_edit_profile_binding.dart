import 'package:figgy/custom/cupertino_date_picker/controller/date_picker_controller.dart';
import 'package:figgy/pages/host_edit_profile_page/controller/host_edit_profile_controller.dart';
import 'package:get/get.dart';

class HostEditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HostEditProfileController>(() => HostEditProfileController());
    Get.put(DatePickerController());
  }
}
