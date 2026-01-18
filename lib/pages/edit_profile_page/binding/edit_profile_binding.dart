import 'package:LoveBirds/custom/cupertino_date_picker/controller/date_picker_controller.dart';
import 'package:LoveBirds/pages/edit_profile_page/controller/edit_profile_controller.dart';
import 'package:get/get.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(() => EditProfileController());
    Get.put(DatePickerController());
  }
}
