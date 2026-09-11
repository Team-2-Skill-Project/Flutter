import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:MatchIn/core/services/local_notifications_service.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future init() async {
    await messaging.requestPermission();
    await messaging.getToken().then((value) {
      sendTokenToServer(value!);
    });
    messaging.onTokenRefresh.listen((value) {
      sendTokenToServer(value);
    });
    FirebaseMessaging.onBackgroundMessage(handlebackgroundMessage);
    //foreground
    handleForegroundMessage();
    messaging.subscribeToTopic('all').then((val) {
      log('sub');
    });

    // messaging.unsubscribeFromTopic('all');
  }

  static Future<void> handlebackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    log(message.notification?.title ?? 'null');
  }

  static void handleForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // show local notification
      LocalNotificationService.showBasicNotification(message);
    });
  }

  static void sendTokenToServer(String token) {
    // option 1 => API
    // option 2 => Firebase
  }
}
