import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/// Diagnostic helper untuk debug Firebase issues
class FirebaseDiagnostics {
  static Future<void> printDiagnostics() async {
    print("\n=== Firebase Diagnostics ===");
    
    // Check if Firebase apps are initialized
    print("Firebase apps count: ${Firebase.apps.length}");
    if (Firebase.apps.isNotEmpty) {
      for (var i = 0; i < Firebase.apps.length; i++) {
        print("  App $i: ${Firebase.apps[i].name}");
      }
    }
    
    print("Platform: ${Theme.of(navigatorKey.currentContext!).platform}");
    print("=== End Diagnostics ===\n");
  }
  
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
