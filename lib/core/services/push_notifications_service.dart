import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:MatchIn/core/services/local_notifications_service.dart';

class PushNotificationsService {
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    // request notification permission from the user
    await messaging.requestPermission();

    // get the current FCM token and send it to the server
    final String? token = await messaging.getToken();

    if (token != null) {
      sendTokenToServer(token);
    }

    // send the new token to the server whenever Firebase refreshes it
    messaging.onTokenRefresh.listen(sendTokenToServer);

    // handle notifications received while the app is in background
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // handle notifications received while the app is in foreground
    handleForegroundMessage();

    // subscribe all users to the default topic
    await messaging.subscribeToTopic('all');
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
  }

  static void handleForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // show a local notification because Firebase doesn't show it automatically
      // when the app is in foreground
      LocalNotificationService.showBasicNotification(message);
    });
  }

  static void sendTokenToServer(String token) {
    // option 1 => send the token through the API
    // option 2 => save the token in Firebase
  }
}
