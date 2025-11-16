import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

class FCMService {
  static Future<void> initialize() async {
    try {
      // Check if Firebase is initialized
      if (Firebase.apps.isEmpty) {
        print("⚠ Firebase not initialized yet, skipping FCM");
        return;
      }

      final messaging = FirebaseMessaging.instance;

      // Request permission
      final settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      print("User granted notification permission: ${settings.authorizationStatus}");

      // Listen for foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("Notifikasi diterima: ${message.notification?.title}");
      });

      // Get token
      final token = await messaging.getToken();
      print("FCM token: $token");
    } catch (e) {
      print("Error initializing FCM: $e");
      // Don't rethrow - let the app continue
    }
  }
}
