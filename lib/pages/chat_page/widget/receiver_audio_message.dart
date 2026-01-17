import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:figgy/pages/chat_page/controller/chat_controller.dart';
import 'package:figgy/utils/api.dart';
import 'package:figgy/utils/asset.dart';
import 'package:figgy/utils/colors_utils.dart';
import 'package:figgy/utils/font_style.dart';
import 'package:figgy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReceiverAudioMessageWidget extends StatefulWidget {
  final String audioUrl;
  final String time;
  final String id;
  final dynamic chat;
  const ReceiverAudioMessageWidget({
    super.key,
    required this.audioUrl,
    required this.time,
    required this.id,
    required this.chat,
  });

  @override
  State<ReceiverAudioMessageWidget> createState() => _ReceiverAudioMessageWidgetState();
}

class _ReceiverAudioMessageWidgetState extends State<ReceiverAudioMessageWidget> {
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    player.onDurationChanged.listen((newDuration) {
      setState(() => duration = newDuration);
    });

    player.onPositionChanged.listen((newPosition) {
      setState(() => position = newPosition);
    });

    player.onPlayerComplete.listen((_) {
      setState(() {
        isPlaying = false;
        position = Duration.zero;
      });
    });

    player.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
    });
  }

  void onPlayAudio() async {
    try {
      final sanitizedUrl = widget.audioUrl.replaceAll('\\', '/');
      final fullUrl = '${Api.baseUrl}$sanitizedUrl';

      log("Attempting to play audio: $fullUrl");

      if (!isPlaying) {
        await player.play(UrlSource(fullUrl));
      } else {
        await player.pause();
      }
    } catch (e) {
      log("Audio playback error: $e");
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: Get.width / 1.6,
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            color: AppColors.pinkMessageColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 70,
                width: Get.width / 1.6,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 75,
                      width: Get.width / 1.6,
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => onPlayAudio(),
                            child: Image.asset(isPlaying ? AppAsset.icPause1 : AppAsset.icPlay1, color: AppColors.pinkMessageColor, width: 24),
                          ),
                          5.width,
                          Expanded(
                            child: SliderTheme(
                              data: SliderThemeData(
                                overlayShape: SliderComponentShape.noOverlay,
                                activeTrackColor: AppColors.primaryColor,
                                thumbColor: AppColors.primaryColor,
                                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                                trackHeight: 5,
                              ),
                              child: Slider(
                                activeColor: AppColors.pinkMessageColor,
                                min: 0,
                                max: duration.inSeconds.toDouble() > 0 ? duration.inSeconds.toDouble() : 1,
                                value: position.inSeconds.toDouble().clamp(0, duration.inSeconds.toDouble()),
                                onChanged: (value) {
                                  player.seek(Duration(seconds: value.toInt()));
                                },
                              ),
                            ),
                          ),
                          3.width,
                          Container(
                            height: 44,
                            width: 44,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.pinkMessageColor),
                            child: Image.asset(
                              AppAsset.icMicrophone,
                              width: 20,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 70,
                      child: Text(
                        formatTime(position),
                        style: AppFontStyle.styleW600(AppColors.pinkMessageColor, 9),
                      ),
                    ),
                  ],
                ),
              ),
              GetBuilder<ChatController>(
                builder: (logic) {
                  return Text(
                    logic.formatTimeFromApi(widget.chat.date.toString()),
                    style: AppFontStyle.styleW600(AppColors.whiteColor, 8),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ).paddingOnly(bottom: 15);
  }
}
