import 'package:flutter/material.dart';
import 'package:flutter_youtube/models/video.dart';
import 'package:flutter_youtube/widgets/video_player_widget.dart';

class VideoDetailScreen extends StatelessWidget {
  final Video video;
  final List<Video> nextVideos;

  const VideoDetailScreen({
    super.key,
    required this.video,
    required this.nextVideos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(video.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VideoPlayerWidget(videoUrl: video.videoUrl),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(video.title, style: Theme.of(context).textTheme.headlineMedium),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('Next Videos', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: nextVideos.length,
              itemBuilder: (context, index) {
                final nextVideo = nextVideos[index];
                return ListTile(
                  leading: Image.network(nextVideo.thumbnailUrl, width: 100, fit: BoxFit.cover),
                  title: Text(nextVideo.title),
                  onTap: () {
                    // Navigate to the next video's detail screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoDetailScreen(
                          video: nextVideo,
                          // Pass the list of videos excluding the one being played
                          nextVideos: nextVideos.where((v) => v.id != nextVideo.id).toList(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
