import 'dart:async';
import 'dart:convert';

import 'package:MatchIn/core/services/services_locator.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// [LocalNotificationService] is a class that handles local notifications
/// It will show a basic notification with an optional image
class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final StreamController<NotificationResponse> streamController =
      StreamController<NotificationResponse>.broadcast();

  /// handle notification taps
  static void onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);

    //TODO: handle notification navigation from here
    // Navigator.push(context, route);
  }

  /// initialize the local notification plugin
  static Future<void> init() async {
    const InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    // initialize the local notification plugin and handle notification taps
    await flutterLocalNotificationsPlugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  /// show a basic notification with an optional image
  static Future<void> showBasicNotification(RemoteMessage message) async {
    final String? imageUrl = message.notification?.android?.imageUrl;

    BigPictureStyleInformation? bigPictureStyleInformation;

    if (imageUrl != null && imageUrl.isNotEmpty) {
      final Response<List<int>> response = await getIt<Dio>().get<List<int>>(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200 && response.data != null) {
        final String imageBase64 = base64Encode(response.data!);

        bigPictureStyleInformation = BigPictureStyleInformation(
          ByteArrayAndroidBitmap.fromBase64String(imageBase64),
          largeIcon: ByteArrayAndroidBitmap.fromBase64String(imageBase64),
        );
      }
    }

    final AndroidNotificationDetails android = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation,
      playSound: true,
      sound: const RawResourceAndroidNotificationSound(
        'long_notification_sound',
      ),
    );

    final NotificationDetails details = NotificationDetails(android: android);

    await flutterLocalNotificationsPlugin.show(
      id: 0,
      title: message.notification?.title,
      body: message.notification?.body,
      notificationDetails: details,
    );
  }
}
