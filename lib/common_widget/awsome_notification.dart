// notification_service.dart
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  int downloadNotificationId = 1001;
  String downloadChannelKey = 'download_channel';

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        print("Action clicked: ${response.actionId}");

        if (response.actionId == 'accept') {
          print("✅ ACCEPTED");
          // Handle accept logic here
        } else if (response.actionId == 'reject') {
          print("❌ REJECTED");
        }
      },
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static void showNotification(RemoteMessage message) {
    final data = message.data;
    final title = data['title'] ?? message.notification?.title ?? 'New Request';
    final body = data['body'] ?? message.notification?.body ?? 'Do you accept?';

    _notificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          importance: Importance.max,
          priority: Priority.high,
          actions: <AndroidNotificationAction>[
            AndroidNotificationAction('accept', 'Accept',
                showsUserInterface: true),
            AndroidNotificationAction('reject', 'Reject',
                showsUserInterface: true),
          ],
        ),
      ),
      payload: 'default',
    );
  }
}
