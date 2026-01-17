import 'package:figgy/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReelsPlayerView extends StatefulWidget {
  final List<String> videoUrls;
  final int initialIndex;

  const ReelsPlayerView({
    super.key,
    required this.videoUrls,
    this.initialIndex = 0,
  });

  @override
  State<ReelsPlayerView> createState() => _ReelsPlayerViewState();
}

class _ReelsPlayerViewState extends State<ReelsPlayerView> {
  late PageController _pageController;
  late VideoPlayerController _controller;
  late List<String> reorderedUrls;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    reorderedUrls = [
      widget.videoUrls[widget.initialIndex],
      ...widget.videoUrls.where((
        _,
      ) =>
          widget.videoUrls.indexOf(_) != widget.initialIndex)
    ];

    currentIndex = 0;
    _pageController = PageController(initialPage: currentIndex);
    _initVideo("${Api.baseUrl}${reorderedUrls[currentIndex]}");
  }

  void _initVideo(String url) {
    _controller = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
    _controller.addListener(() {
      setState(() {});
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
    _controller.pause();
    _controller.dispose();
    _initVideo("${Api.baseUrl}${reorderedUrls[index]}");
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: reorderedUrls.length,
            onPageChanged: _onPageChanged,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return _controller.value.isInitialized
                  ? GestureDetector(
                      onTap: () {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                        setState(() {});
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                            child: AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            ),
                          ),
                          if (!_controller.value.isPlaying)
                            const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 80,
                            ),
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
                                  max: _controller.value.duration.inSeconds.toDouble(),
                                  value: _controller.value.position.inSeconds.clamp(0, _controller.value.duration.inSeconds).toDouble(),
                                  onChanged: (value) {
                                    _controller.seekTo(Duration(seconds: value.toInt()));
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _formatDuration(_controller.value.position),
                                      style: const TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                                    Text(
                                      _formatDuration(_controller.value.duration),
                                      style: const TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Center(child: CircularProgressIndicator(color: Colors.white));
            },
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
