import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/services/auth_service.dart';
import 'package:flutter_youtube/services/firestore_service.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileProvider with ChangeNotifier {
  final AuthService _authService;
  final FirestoreService _firestoreService;

  MyProfileProvider(this._authService, this._firestoreService);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> updateProfile({String? name, XFile? imageFile}) async {
    _isLoading = true;
    notifyListeners();

    try {
      String? imageUrl;
      if (imageFile != null) {
        imageUrl = await _firestoreService.uploadProfileImage(
            _authService.firebaseUser!.uid, File(imageFile.path));
      }

      await _firestoreService.updateUserProfile(
        userId: _authService.firebaseUser!.uid,
        name: name,
        profileImageUrl: imageUrl,
      );

      // Refresh the user data in AuthService
      await _authService.refreshUser();

    } catch (e) {
      print('Error updating profile: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteAccount(String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final userId = _authService.firebaseUser!.uid;
      await _authService.reauthenticate(password);
      await _firestoreService.deleteAllUserData(userId);
      await _authService.deleteCurrentUser();
    } catch (e) {
      print('Error deleting account: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
