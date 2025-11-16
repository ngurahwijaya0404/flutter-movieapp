import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthProvider with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? user;
  bool _firebaseReady = false;

  AuthProvider() {
    _checkFirebaseReady();
  }

  Future<void> _checkFirebaseReady() async {
    _firebaseReady = Firebase.apps.isNotEmpty;
  }

  FirebaseAuth get _auth {
    if (!_firebaseReady) {
      throw Exception("Firebase not initialized");
    }
    return FirebaseAuth.instance;
  }

  Future<void> signInWithGoogle() async {
    try {
      // Ensure Firebase is ready
      await _checkFirebaseReady();
      if (!_firebaseReady) {
        throw Exception("Firebase is not initialized. Please restart the app.");
      }

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      // Get tokens
      final tokens = await googleUser.authentication;
      
      // Create Firebase credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: tokens.idToken,
        accessToken: tokens.accessToken,
      );

      // Sign in to Firebase
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      user = userCredential.user;
      notifyListeners();
    } catch (e) {
      print("Google login error: $e");
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      if (_firebaseReady) {
        await _auth.signOut();
      }
      user = null;
      notifyListeners();
    } catch (e) {
      print("Logout error: $e");
    }
  }
}
