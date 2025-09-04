import 'package:flutter/material.dart';
import 'package:flutter_youtube/models/video.dart';
import 'package:flutter_youtube/services/firestore_service.dart';

class ManageVideoProvider with ChangeNotifier {
  final FirestoreService _firestoreService;
  final String _userId;

  ManageVideoProvider(this._firestoreService, this._userId) {
    fetchUserVideos();
  }

  List<Video> _videos = [];
  List<Video> get videos => _videos;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchUserVideos() async {
    _isLoading = true;
    notifyListeners();

    _videos = await _firestoreService.getUserVideos(userId: _userId);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteVideo(String videoId) async {
    try {
      await _firestoreService.deleteVideo(videoId);
      _videos.removeWhere((video) => video.id == videoId);
      notifyListeners();
    } catch (e) {
      print('Error deleting video in provider: $e');
      rethrow;
    }
  }
}
