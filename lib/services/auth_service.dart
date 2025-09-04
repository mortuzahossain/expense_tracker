import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_youtube/models/app_user.dart';

class AuthService with ChangeNotifier {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AppUser? _appUser;
  AppUser? get appUser => _appUser;

  auth.User? get firebaseUser => _firebaseAuth.currentUser;

  AuthService() {
    _firebaseAuth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(auth.User? firebaseUser) async {
    if (firebaseUser == null) {
      _appUser = null;
    } else {
      _appUser = await _getAppUser(firebaseUser.uid);
    }
    notifyListeners();
  }

  Future<AppUser?> _getAppUser(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return AppUser.fromMap(doc.data()!, doc.id);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<auth.User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<auth.User?> createUserWithEmailAndPassword(String name, String email, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        await _firestore.collection('users').doc(credential.user!.uid).set({
          'name': name,
          'email': email,
        });
        // a newly created user is automatically signed in
      }
      return credential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> refreshUser() async {
    if (firebaseUser != null) {
      await _onAuthStateChanged(firebaseUser);
    }
  }

  Future<void> reauthenticate(String password) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw Exception('No user is currently signed in.');
      }
      final cred = auth.EmailAuthProvider.credential(email: user.email!, password: password);
      await user.reauthenticateWithCredential(cred);
    } catch (e) {
      print('Reauthentication failed: $e');
      rethrow;
    }
  }

  Future<void> deleteCurrentUser() async {
    try {
      await _firebaseAuth.currentUser?.delete();
    } catch (e) {
      print('Failed to delete user from auth: $e');
      rethrow;
    }
  }
}
