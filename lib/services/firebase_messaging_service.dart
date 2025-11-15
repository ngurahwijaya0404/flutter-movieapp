import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  static Future<void> initialize() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission();

    FirebaseMessaging.onMessage.listen((message) {
      print("Notifikasi diterima: ${message.notification?.title}");
    });

    // optional: get token for debugging
    final token = await messaging.getToken();
    print("FCM token: $token");
  }
}
