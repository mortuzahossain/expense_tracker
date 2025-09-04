import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_youtube/models/video.dart';
import 'package:flutter_youtube/services/firestore_service.dart';

class FeedProvider with ChangeNotifier {
  final FirestoreService _firestoreService;
  final String _userId;

  FeedProvider(this._firestoreService, this._userId) {
    fetchInitialVideos();
  }

  List<Video> _videos = [];
  List<Video> get videos => _videos;

  DocumentSnapshot? _lastDocument;
  bool _isLoading = false;
  bool _hasMore = true;

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchInitialVideos() async {
    _isLoading = true;
    notifyListeners();

    final newVideos = await _firestoreService.getFeedVideos(userId: _userId, limit: 5);
    _videos = newVideos;
    if (newVideos.isNotEmpty) {
      _lastDocument = await _firestoreService.getVideoDocumentSnapshot(newVideos.last.id);
    }
    _hasMore = newVideos.length == 5;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMoreVideos() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    final newVideos = await _firestoreService.getFeedVideos(
        userId: _userId, lastDocument: _lastDocument, limit: 5);
    if (newVideos.isNotEmpty) {
      _lastDocument = await _firestoreService.getVideoDocumentSnapshot(newVideos.last.id);
    }
    _videos.addAll(newVideos);
    _hasMore = newVideos.length == 5;
    _isLoading = false;
    notifyListeners();
  }
}
