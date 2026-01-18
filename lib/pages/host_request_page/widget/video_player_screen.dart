import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ChewiePlayerScreen extends StatefulWidget {
  final File file;

  const ChewiePlayerScreen({super.key, required this.file});

  @override
  State<ChewiePlayerScreen> createState() => _ChewiePlayerScreenState();
}

class _ChewiePlayerScreenState extends State<ChewiePlayerScreen> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        _chewieController = ChewieController(
          videoPlayerController: _videoController,
          autoPlay: true,
          looping: false,
          allowFullScreen: true,
          allowPlaybackSpeedChanging: true,
          showControls: true,
        );
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? Stack(
                children: [
                  Chewie(controller: _chewieController!),
                  Positioned(
                    top: 40,
                    left: 5,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        color: Colors.transparent,
                        child: Image.asset(AppAsset.icLeftArrow,
                                color: Colors.white)
                            .paddingAll(10),
                      ),
                    ),
                  )
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
