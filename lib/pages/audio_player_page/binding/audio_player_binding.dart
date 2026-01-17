import 'package:figgy/pages/audio_player_page/controller/audio_player_controller.dart';
import 'package:get/get.dart';

class AudioPlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AudioPlayerController>(() => AudioPlayerController());
  }
}
