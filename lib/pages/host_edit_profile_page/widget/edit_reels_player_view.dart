import 'dart:io';

import 'package:LoveBirds/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class EditReelsPlayerView extends StatefulWidget {
  final List<String> videoUrls;
  final int initialIndex;

  const EditReelsPlayerView({
    super.key,
    required this.videoUrls,
    this.initialIndex = 0,
  });

  @override
  State<EditReelsPlayerView> createState() => _EditReelsPlayerViewState();
}

class _EditReelsPlayerViewState extends State<EditReelsPlayerView> {
  late PageController _pageController;
  VideoPlayerController? _controller;
  late List<String> reordered;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    reordered = [
      widget.videoUrls[widget.initialIndex],
      ...List.generate(widget.videoUrls.length, (i) => i)
          .where((i) => i != widget.initialIndex)
          .map((i) => widget.videoUrls[i]),
    ];

    currentIndex = 0;
    _pageController = PageController(initialPage: currentIndex);
    _initFor(reordered[currentIndex]);
  }

  VideoPlayerController _buildController(String src) {
    try {
      if (File(src).existsSync()) {
        return VideoPlayerController.file(File(src));
      }
    } catch (_) {}

    final String full = src.startsWith('http') ? src : "${Api.baseUrl}$src";
    return VideoPlayerController.networkUrl(Uri.parse(full));
  }

  Future<void> _initFor(String src) async {
    await _controller?.pause();
    await _controller?.dispose();

    final ctl = _buildController(src);
    _controller = ctl;

    await ctl.initialize();
    if (!mounted) return;
    setState(() {});
    await ctl.play();

    ctl.addListener(() {
      if (mounted) setState(() {});
    });
  }

  Future<void> _onPageChanged(int index) async {
    setState(() => currentIndex = index);
    await _controller?.pause();
    await _initFor(reordered[index]);
  }

  @override
  void dispose() {
    _controller?.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isReady = _controller?.value.isInitialized ?? false;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: reordered.length,
            scrollDirection: Axis.vertical,
            onPageChanged: _onPageChanged,
            itemBuilder: (_, __) {
              if (!isReady) {
                return const Center(
                    child: CircularProgressIndicator(color: Colors.white));
              }
              return GestureDetector(
                onTap: () {
                  final v = _controller!;
                  v.value.isPlaying ? v.pause() : v.play();
                  setState(() {});
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: VideoPlayer(_controller!),
                      ),
                    ),
                    if (!(_controller!.value.isPlaying))
                      const Icon(Icons.play_arrow,
                          color: Colors.white, size: 80),
                    Positioned(
                      top: 40,
                      left: 16,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 10,
                      right: 10,
                      child: Column(
                        children: [
                          Slider(
                            activeColor: Colors.red,
                            inactiveColor: Colors.white24,
                            min: 0,
                            max: _controller!.value.duration.inSeconds
                                .toDouble(),
                            value: _controller!.value.position.inSeconds
                                .clamp(0, _controller!.value.duration.inSeconds)
                                .toDouble(),
                            onChanged: (value) {
                              _controller!
                                  .seekTo(Duration(seconds: value.toInt()));
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_fmt(_controller!.value.position),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12)),
                              Text(_fmt(_controller!.value.duration),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _fmt(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return "${two(d.inMinutes.remainder(60))}:${two(d.inSeconds.remainder(60))}";
  }
}
