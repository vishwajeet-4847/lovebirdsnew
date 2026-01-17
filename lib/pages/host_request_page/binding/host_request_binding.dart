import 'package:figgy/custom/cupertino_date_picker/controller/date_picker_controller.dart';
import 'package:figgy/pages/host_request_page/controller/host_request_controller.dart';
import 'package:get/get.dart';

class HostRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HostRequestController>(() => HostRequestController());
    Get.put(DatePickerController());
  }
}
