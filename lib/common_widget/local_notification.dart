// notification_service.dart

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  int downloadNotificationId = 1001;
  String downloadChannelKey = 'download_channel';

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_notification');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

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
          icon: 'ic_notification',
          importance: Importance.max,
          priority: Priority.high,
          color: Colors.white,
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
