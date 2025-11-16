import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  static bool _initialized = false;

  static bool get isInitialized => _initialized;

  static Future<bool> initialize() async {
    if (_initialized) return true;

    try {
      // Check if Firebase apps already exist
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }
      _initialized = true;
      print("✓ Firebase service initialized");
      return true;
    } catch (e) {
      print("✗ Error initializing Firebase service: $e");
      _initialized = false;
      return false;
    }
  }
}
