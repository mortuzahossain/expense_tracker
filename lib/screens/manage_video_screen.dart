import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_youtube/providers/manage_video_provider.dart';
import 'package:flutter_youtube/services/auth_service.dart';
import 'package:flutter_youtube/services/firestore_service.dart';

class ManageVideoScreen extends StatelessWidget {
  const ManageVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final firestoreService = Provider.of<FirestoreService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Videos')),
      body: ChangeNotifierProvider(
        create: (_) => ManageVideoProvider(firestoreService, authService.firebaseUser!.uid),
        child: Consumer<ManageVideoProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.videos.isEmpty) {
              return const Center(child: Text('You have not uploaded any videos.'));
            }

            return ListView.builder(
              itemCount: provider.videos.length,
              itemBuilder: (context, index) {
                final video = provider.videos[index];
                return ListTile(
                  leading: Image.network(video.thumbnailUrl, width: 100, fit: BoxFit.cover),
                  title: Text(video.title),
                  subtitle: Text('Type: ${video.type}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      // Show a confirmation dialog before deleting
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Video?'),
                          content: const Text('Are you sure you want to delete this video?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        try {
                          await provider.deleteVideo(video.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Video deleted successfully')),
                          );
                        } catch (e) {
                           ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to delete video: $e')),
                          );
                        }
                      }
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
