import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../services/firebase_service.dart';

class AuthProvider with ChangeNotifier {
  late GoogleSignIn _googleSignIn;

  User? user;

  AuthProvider() {
    print("AuthProvider initialized");
    _initializeGoogleSignIn();
  }

  void _initializeGoogleSignIn() {
    if (kIsWeb) {
      // For web, pass explicit clientId
      _googleSignIn = GoogleSignIn(
        clientId: "761253598752-s8uOmelqo8keq8vgj2jq4ttq2sp3oslg.apps.googleusercontent.com",
      );
      print("GoogleSignIn initialized for web with clientId");
    } else {
      // For mobile, GoogleSignIn will read from configuration files
      _googleSignIn = GoogleSignIn();
      print("GoogleSignIn initialized for mobile");
    }
  }

  FirebaseAuth get _auth {
    return FirebaseAuth.instance;
  }

  Future<void> signInWithGoogle() async {
    try {
      print("Starting Google Sign In...");
      
      // Ensure Firebase is fully initialized before proceeding
      print("Ensuring Firebase is initialized...");
      await FirebaseService.ensureInitialized();
      print("✓ Firebase ready for authentication");

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("Google sign in cancelled by user");
        return;
      }

      print("Google user signed in: ${googleUser.email}");

      // Get tokens
      final tokens = await googleUser.authentication;
      print("Got authentication tokens");
      
      // Create Firebase credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: tokens.idToken,
        accessToken: tokens.accessToken,
      );

      print("Creating Firebase credential...");

      // Sign in to Firebase
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      user = userCredential.user;
      print("Successfully signed in: ${user?.email}");
      notifyListeners();
    } catch (e) {
      print("Google login error: $e");
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      if (FirebaseService.isInitialized) {
        await FirebaseAuth.instance.signOut();
      }
      user = null;
      notifyListeners();
      print("Logged out successfully");
    } catch (e) {
      print("Logout error: $e");
    }
  }
}
