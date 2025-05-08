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
      print('🔔 Received a foreground message!');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      print('Data: ${message.data}');

      // Optional: show a local notification
      NotificationService.showNotification(message);
    });
    keepLogin();
  }

  void keepLogin() {
    Future.delayed(Duration(seconds: 3), () async {
      final userData = await LocalStorage().getUserLocalData();
      final role = await storage.read(key: LocalStorage().userRole);

      if (userData == null || role == null) {
        Get.offAllNamed(Routes.AUTH);
        return;
      }

      if (role == "messanger") {
        final token = userData.messangerdetail?.token;
        if (token != null && token.isNotEmpty) {
          Get.offAllNamed(Routes.BOTTOMBAR);
          log('🤩 Messenger Login success 🤩');
          return;
        }
      } else if (role == "customer") {
        final token = userData.customerdetail?.token;
        if (token != null && token.isNotEmpty) {
          Get.offAllNamed(Routes.BOTTOMBAR);
          log('🤩 Customer Login success 🤩');
          return;
        }
      }

      // fallback
      Get.offAllNamed(Routes.AUTH);
    });
  }
}
