import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_youtube/models/video.dart';

class ReelPlayerWidget extends StatefulWidget {
  final Video video;

  const ReelPlayerWidget({super.key, required this.video});

  @override
  _ReelPlayerWidgetState createState() => _ReelPlayerWidgetState();
}

class _ReelPlayerWidgetState extends State<ReelPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? GestureDetector(
            onTap: () {
              setState(() {
                _controller.value.isPlaying ? _controller.pause() : _controller.play();
              });
            },
            child: Stack(
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Text(
                    widget.video.title,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
