import 'package:flutter/material.dart';
import 'package:flutter_youtube/models/video.dart';
import 'package:flutter_youtube/services/firestore_service.dart';

class ReelsProvider with ChangeNotifier {
  final FirestoreService _firestoreService;
  final String _userId;

  ReelsProvider(this._firestoreService, this._userId) {
    fetchReels();
  }

  List<Video> _reels = [];
  List<Video> get reels => _reels;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchReels() async {
    _isLoading = true;
    notifyListeners();

    _reels = await _firestoreService.getReels(userId: _userId);
    _isLoading = false;
    notifyListeners();
  }
}
