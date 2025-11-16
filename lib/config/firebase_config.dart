import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class FirebaseConfig {
  /// Get Firebase options based on platform
  static FirebaseOptions getOptions() {
    if (kIsWeb) {
      return FirebaseOptions(
        apiKey: "AIzaSyDRZKfF3Nl-Rw9u8d5d8d8d8d8d8d8d8d8",
        appId: "1:000000000000:web:0000000000000000000000",
        messagingSenderId: "000000000000",
        projectId: "flutter-movieapp",
        authDomain: "flutter-movieapp.firebaseapp.com",
        databaseURL: "https://flutter-movieapp.firebaseio.com",
        storageBucket: "flutter-movieapp.appspot.com",
      );
    } else if (Platform.isAndroid) {
      return FirebaseOptions(
        apiKey: "AIzaSyDRZKfF3Nl-Rw9u8d5d8d8d8d8d8d8d8d8",
        appId: "1:000000000000:android:0000000000000000000000",
        messagingSenderId: "000000000000",
        projectId: "flutter-movieapp",
        databaseURL: "https://flutter-movieapp.firebaseio.com",
        storageBucket: "flutter-movieapp.appspot.com",
      );
    } else if (Platform.isIOS) {
      return FirebaseOptions(
        apiKey: "AIzaSyDRZKfF3Nl-Rw9u8d5d8d8d8d8d8d8d8d8",
        appId: "1:000000000000:ios:0000000000000000000000",
        messagingSenderId: "000000000000",
        projectId: "flutter-movieapp",
        databaseURL: "https://flutter-movieapp.firebaseio.com",
        storageBucket: "flutter-movieapp.appspot.com",
      );
    }
    
    // Default fallback
    return FirebaseOptions(
      apiKey: "AIzaSyDRZKfF3Nl-Rw9u8d5d8d8d8d8d8d8d8d8",
      appId: "1:000000000000:web:0000000000000000000000",
      messagingSenderId: "000000000000",
      projectId: "flutter-movieapp",
      authDomain: "flutter-movieapp.firebaseapp.com",
      databaseURL: "https://flutter-movieapp.firebaseio.com",
      storageBucket: "flutter-movieapp.appspot.com",
    );
  }
}
