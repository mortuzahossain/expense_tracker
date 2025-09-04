import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_youtube/providers/feed_provider.dart';
import 'package:flutter_youtube/services/auth_service.dart';
import 'package:flutter_youtube/services/firestore_service.dart';
import 'package:flutter_youtube/screens/video_detail_screen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final firestoreService = Provider.of<FirestoreService>(context, listen: false);

    return ChangeNotifierProvider(
      create: (_) => FeedProvider(firestoreService, authService.firebaseUser!.uid),
      child: Consumer<FeedProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.videos.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.videos.isEmpty) {
            return const Center(child: Text('No videos in your feed.'));
          }

          return ListView.builder(
            itemCount: provider.videos.length + (provider.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == provider.videos.length) {
                // Trigger fetch more and show loader
                provider.fetchMoreVideos();
                return const Center(child: CircularProgressIndicator());
              }

              final video = provider.videos[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VideoDetailScreen(
                      video: video,
                      nextVideos: provider.videos.where((v) => v.id != video.id).toList(),
                    ),
                  ));
                },
                child: Card(
                  child: Column(
                    children: [
                      Image.network(video.thumbnailUrl, fit: BoxFit.cover, height: 200, width: double.infinity),
                      ListTile(
                        title: Text(video.title),
                        subtitle: Text('Uploaded on ${video.createdAt.toDate()}'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
