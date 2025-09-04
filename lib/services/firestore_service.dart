import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_youtube/models/video.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
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

  Future<void> deleteVideo(String videoId) async {
    try {
      await _firestore.collection(_videosCollection).doc(videoId).delete();
    } catch (e) {
      print('Error deleting video: $e');
      rethrow;
    }
  }

  Future<String> uploadProfileImage(String userId, File imageFile) async {
    try {
      final storageRef = _storage.ref().child('profile_images').child('$userId.jpg');
      final uploadTask = storageRef.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() => {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading profile image: $e');
      rethrow;
    }
  }

  Future<void> updateUserProfile({
    required String userId,
    String? name,
    String? profileImageUrl,
  }) async {
    try {
      final Map<String, dynamic> dataToUpdate = {};
      if (name != null) {
        dataToUpdate['name'] = name;
      }
      if (profileImageUrl != null) {
        dataToUpdate['profileImageUrl'] = profileImageUrl;
      }

      if (dataToUpdate.isNotEmpty) {
        await _firestore.collection('users').doc(userId).update(dataToUpdate);
      }
    } catch (e) {
      print('Error updating user profile: $e');
      rethrow;
    }
  }

  Future<void> deleteAllUserData(String userId) async {
    try {
      // Delete all videos by the user
      final videosQuery = await _firestore.collection(_videosCollection).where('userId', isEqualTo: userId).get();
      final WriteBatch batch = _firestore.batch();
      for (final doc in videosQuery.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      // Delete the user document
      await _firestore.collection('users').doc(userId).delete();

    } catch (e) {
      print('Error deleting all user data: $e');
      rethrow;
    }
  }
}
