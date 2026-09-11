import 'package:MatchIn/core/services/local_notifications_service.dart';
import 'package:MatchIn/core/services/services_locator.dart';
import 'package:MatchIn/core/services/shared_preferences_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
      await sendTokenToServer(token);
    }

    // send the new token to the server whenever Firebase refreshes it
    messaging.onTokenRefresh.listen((token) async => sendTokenToServer(token));

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

  ///! Send the FCM token to the server and save it locally.
  static Future<void> sendTokenToServer(String token) async {
    // Persist locally so the token is available even after an app restart
    await getIt<SharedPreferencesService>().saveFcmToken(token);
  }
}

