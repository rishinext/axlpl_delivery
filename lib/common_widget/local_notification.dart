// notification_service.dart

import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  int downloadNotificationId = 1001;
  String downloadChannelKey = 'download_channel';
  LocalStorage storage = LocalStorage();
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

    // Create pickup notification channel (with actions)
    const AndroidNotificationChannel pickupChannel = AndroidNotificationChannel(
      'pickup_channel',
      'Pickup Notifications',
      description:
          'Notifications for pickup requests with accept/reject actions',
      importance: Importance.high,
    );

    // Create delivery status channel (no actions)
    const AndroidNotificationChannel deliveryStatusChannel =
        AndroidNotificationChannel(
      'delivery_status_channel',
      'Delivery Status Notifications',
      description: 'Notifications for delivery status updates',
      importance: Importance.high,
    );

    final androidPlugin =
        _notificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.createNotificationChannel(pickupChannel);
    await androidPlugin?.createNotificationChannel(deliveryStatusChannel);
  }

  // Pickup notification with accept/reject buttons (for messengers)
  static void showPickupNotification(RemoteMessage message) {
    final data = message.data;
    final title =
        data['title'] ?? message.notification?.title ?? 'New Pickup Request';
    final body = data['body'] ??
        message.notification?.body ??
        'Do you accept this pickup?';

    _notificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'pickup_channel',
          'Pickup Notifications',
          icon: 'ic_notification',
          importance: Importance.max,
          priority: Priority.high,
          color: Colors.orange,
          actions: <AndroidNotificationAction>[
            AndroidNotificationAction('accept', 'Accept',
                showsUserInterface: true),
            AndroidNotificationAction('reject', 'Reject',
                showsUserInterface: true),
          ],
        ),
      ),
      payload: 'pickup',
    );
  }

  // Out for delivery notification - no action buttons
  static void showOutForDeliveryNotification(RemoteMessage message) {
    final data = message.data;
    final title =
        data['title'] ?? message.notification?.title ?? 'Out for Delivery';
    final body = data['body'] ??
        message.notification?.body ??
        'Your package is out for delivery';

    _notificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000 + 2, // Different ID
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'delivery_status_channel',
          'Delivery Status Notifications',
          icon: 'ic_notification',
          importance: Importance.max,
          priority: Priority.high,
          color: Colors.green,
          // No actions for out for delivery notifications
        ),
        iOS: DarwinNotificationDetails(
          categoryIdentifier: 'out_for_delivery',
        ),
      ),
      payload: 'out_for_delivery',
    );
  }

  // Customer notification - only title and message (no action buttons)
  static void showCustomerNotification(RemoteMessage message) {
    final data = message.data;
    final title =
        data['title'] ?? message.notification?.title ?? 'Delivery Update';
    final body = data['body'] ??
        message.notification?.body ??
        'Your delivery status has been updated';

    _notificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000 + 1, // Different ID
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'delivery_status_channel',
          'Delivery Status Notifications',
          icon: 'ic_notification',
          importance: Importance.max,
          priority: Priority.high,
          color: Colors.blue,
          // No actions - only title and message for customers
        ),
        iOS: DarwinNotificationDetails(
          categoryIdentifier: 'customer_delivery',
        ),
      ),
      payload: 'customer_notification',
    );
  }

  // Smart notification method based on message data
  static void showNotificationByType(RemoteMessage message) {
    final data = message.data;
    final notificationType = data['type'] ?? '';
    final status = data['status'] ?? '';
    final title = data['title'] ?? message.notification?.title ?? '';

    // Check title for notification type
    if (title.toLowerCase().contains('out for delivery') ||
        notificationType == 'out_for_delivery' ||
        status == 'out_for_delivery') {
      showOutForDeliveryNotification(message);
    } else if (title.toLowerCase().contains('pickup') ||
        notificationType == 'pickup' ||
        status == 'pickup') {
      showPickupNotification(message);
    } else if (title.toLowerCase().contains('delivered') ||
        notificationType == 'customer' ||
        status == 'delivered') {
      showCustomerNotification(message);
    } else {
      // Default to pickup notification for backward compatibility
      showPickupNotification(message);
    }
  }

  // Keep the original method for backward compatibility
  static void showNotification(RemoteMessage message) {
    // Use the smart method to determine notification type
    showNotificationByType(message);
  }
}
