import 'package:flutter/material.dart';
import 'package:flutter_youtube/models/video.dart';
import 'package:flutter_youtube/widgets/reel_player_widget.dart';

class ReelsViewerScreen extends StatefulWidget {
  final List<Video> reels;
  final int initialIndex;

  const ReelsViewerScreen({
    super.key,
    required this.reels,
    required this.initialIndex,
  });

  @override
  _ReelsViewerScreenState createState() => _ReelsViewerScreenState();
}

class _ReelsViewerScreenState extends State<ReelsViewerScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.reels.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return ReelPlayerWidget(video: widget.reels[index]);
        },
      ),
    );
  }
}
