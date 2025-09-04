import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_youtube/providers/reels_provider.dart';
import 'package:flutter_youtube/services/auth_service.dart';
import 'package:flutter_youtube/services/firestore_service.dart';
import 'package:flutter_youtube/screens/reels_viewer_screen.dart';

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final firestoreService = Provider.of<FirestoreService>(context, listen: false);

    return ChangeNotifierProvider(
      create: (_) => ReelsProvider(firestoreService, authService.firebaseUser!.uid),
      child: Consumer<ReelsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.reels.isEmpty) {
            return const Center(child: Text('No reels to show.'));
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 9 / 16, // Typical reel aspect ratio
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: provider.reels.length,
            itemBuilder: (context, index) {
              final reel = provider.reels[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReelsViewerScreen(
                      reels: provider.reels,
                      initialIndex: index,
                    ),
                  ));
                },
                child: Image.network(
                  reel.thumbnailUrl,
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
