import 'dart:math';

import 'package:LoveBirds/pages/random_match_page/model/get_available_host_model.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:get/get.dart';

class MatchingController extends GetxController {
  GetAvailableHost? getAvailableHost;
  String? selectedGender;

  @override
  Future<void> onInit() async {
    getAvailableHost = Get.arguments["getAvailableHost"];
    selectedGender = Get.arguments["gender"];
    Utils.showLog("getAvailableHost ************* $getAvailableHost");
    Utils.showLog("getAvailableHost ************* $selectedGender");

    super.onInit();
  }

  String onGenerateRandomNumber() {
    const String chars = 'abcdefghijklmnopqrstuvwxyz';
    Random random = Random();
    return List.generate(
      25,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
  }
}
