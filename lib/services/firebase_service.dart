import 'package:firebase_core/firebase_core.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import '../config/firebase_config.dart';

class FirebaseService {
  static Future<void>? _initializationFuture;
  static bool _initialized = false;

  static bool get isInitialized => _initialized;

  static Future<void> ensureInitialized() async {
    // If already initialized, return immediately
    if (_initialized) {
      print("Firebase already initialized");
      return;
    }

    // If initialization is in progress, wait for it
    if (_initializationFuture != null) {
      print("Firebase initialization in progress, waiting...");
      await _initializationFuture;
      return;
    }

    // Start initialization
    _initializationFuture = _performInitialization();
    await _initializationFuture;
  }

  static Future<void> _performInitialization() async {
    try {
      print("\n=== Starting Firebase Initialization ===");
      print("Platform: ${_getPlatformName()}");
      
      if (Firebase.apps.isEmpty) {
        print("No Firebase apps found, calling Firebase.initializeApp()...");
        
        // Get Firebase options based on platform
        final options = FirebaseConfig.getOptions();
        print("Firebase options loaded for ${_getPlatformName()}");
        
        await Firebase.initializeApp(options: options);
        print("Firebase.initializeApp() completed");
      } else {
        print("Firebase already initialized, skipping Firebase.initializeApp()");
      }
      
      // Verify Firebase is ready
      await Future.delayed(const Duration(milliseconds: 200));
      
      if (Firebase.apps.isNotEmpty) {
        _initialized = true;
        print("✓ Firebase service initialized successfully");
        print("Firebase apps count: ${Firebase.apps.length}");
        print("Default app name: ${Firebase.app().name}");
        print("=== Firebase Initialization Complete ===\n");
      } else {
        throw Exception("Firebase apps is empty after initialization");
      }
    } catch (e) {
      print("✗ Error initializing Firebase service: $e");
      print("=== Firebase Initialization Failed ===\n");
      _initialized = false;
      rethrow;
    }
  }

  static String _getPlatformName() {
    if (kIsWeb) return "Web";
    if (Platform.isAndroid) return "Android";
    if (Platform.isIOS) return "iOS";
    if (Platform.isWindows) return "Windows";
    if (Platform.isMacOS) return "macOS";
    if (Platform.isLinux) return "Linux";
    return "Unknown";
  }

  static Future<bool> initialize() async {
    try {
      await ensureInitialized();
      return true;
    } catch (e) {
      print("Failed to initialize Firebase: $e");
      return false;
    }
  }
}
