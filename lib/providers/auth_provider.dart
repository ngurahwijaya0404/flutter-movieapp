import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? user;

  Future<void> signInWithGoogle() async {
    try {
      // 1. Trigger Google Sign-In
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      // 2. Get authentication
      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      // 3. Convert to Firebase credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      // 4. Sign in to Firebase
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      user = userCredential.user;
      notifyListeners();
    } catch (e) {
      print("Google login error: $e");
      rethrow;
    }
  }

  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
    user = null;
    notifyListeners();
  }
}
