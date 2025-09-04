import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  final String id;
  final String userId;
  final String title;
  final String videoUrl;
  final String thumbnailUrl;
  final String type;
  final Timestamp createdAt;

  Video({
    required this.id,
    required this.userId,
    required this.title,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.type,
    required this.createdAt,
  });

  factory Video.fromMap(Map<String, dynamic> data, String documentId) {
    return Video(
      id: documentId,
      userId: data['userId'],
      title: data['title'],
      videoUrl: data['videoUrl'],
      thumbnailUrl: data['thumbnailUrl'],
      type: data['type'],
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'videoUrl': videoUrl,
      'thumbnailUrl': thumbnailUrl,
      'type': type,
      'createdAt': createdAt,
    };
  }
}
