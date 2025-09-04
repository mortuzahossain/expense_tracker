import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_youtube/models/video.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _videosCollection = 'videos';

  Future<void> uploadVideo({
    required String userId,
    required String title,
    required String videoUrl,
    required String thumbnailUrl,
    required String type,
  }) async {
    try {
      await _firestore.collection(_videosCollection).add({
        'userId': userId,
        'title': title,
        'videoUrl': videoUrl,
        'thumbnailUrl': thumbnailUrl,
        'type': type,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error uploading video: $e');
      rethrow;
    }
  }

  Future<List<Video>> getFeedVideos(
      {required String userId, DocumentSnapshot? lastDocument, int limit = 10}) async {
    try {
      Query query = _firestore
          .collection(_videosCollection)
          .where('userId', isEqualTo: userId)
          .where('type', isEqualTo: 'feed')
          .orderBy('createdAt', descending: true);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      final querySnapshot = await query.limit(limit).get();

      return querySnapshot.docs.map((doc) {
        return Video.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching feed videos: $e');
      return [];
    }
  }

  Future<List<Video>> getReels({required String userId}) async {
    try {
      final querySnapshot = await _firestore
          .collection(_videosCollection)
          .where('userId', isEqualTo: userId)
          .where('type', isEqualTo: 'reel')
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        return Video.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching reels: $e');
      return [];
    }
  }

  Future<List<Video>> getUserVideos({required String userId}) async {
    try {
      final querySnapshot = await _firestore
          .collection(_videosCollection)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        return Video.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching user videos: $e');
      return [];
    }
  }

  Future<DocumentSnapshot> getVideoDocumentSnapshot(String videoId) async {
    return _firestore.collection(_videosCollection).doc(videoId).get();
  }
}
