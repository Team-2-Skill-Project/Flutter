import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:MatchIn/core/services/local_notifications_service.dart';

/// [PushNotificationsService] is a class that handles push notifications
/// It will send the FCM token to the server
/// It will show a local notification when a notification is received
class PushNotificationsService {
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;

  ///! initialize the push notifications
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

  ///! handle notifications received while the app is in background
  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
  }

  ///! handle notifications received while the app is in foreground
  static void handleForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // show a local notification because Firebase doesn't show it automatically
      // when the app is in foreground
      LocalNotificationService.showBasicNotification(message);
    });
  }

  ///! send the FCM token to the server
  static void sendTokenToServer(String token) {
    // option 1 => send the token through the API
    // option 2 => save the token in Firebase
  }
}
