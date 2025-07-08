import 'dart:developer';

import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/auth_repo.dart';
import 'package:axlpl_delivery/app/routes/app_pages.dart';
import 'package:axlpl_delivery/common_widget/awsome_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController
  final AuthRepo _authRepo = AuthRepo();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('🔔 Received a foreground message!');
      log('Title: ${message.notification?.title}');
      log('Body: ${message.notification?.body}');
      log('Data: ${message.data}');

      // Optional: show a local notification
      NotificationService.showNotification(message);
    });
    keepLogin();
  }

  void keepLogin() {
    Future.delayed(const Duration(seconds: 3), () async {
      final userData = await LocalStorage().getUserLocalData();
      final role = await storage.read(key: LocalStorage().userRole);
      final token = await storage.read(
          key: LocalStorage().tokenKey); // ✅ check secure token

      if (userData == null || role == null) {
        Get.offAllNamed(Routes.AUTH);
        return;
      }

      if (role == "messanger") {
        Get.offAllNamed(Routes.BOTTOMBAR, arguments: userData);
        log('🤩 Messenger Login success 🤩');
      } else if (role == "customer") {
        Get.offAllNamed(Routes.BOTTOMBAR, arguments: userData);
        log('🤩 Customer Login success 🤩');
      } else {
        Get.offAllNamed(Routes.AUTH);
      }
    });
  }
}
