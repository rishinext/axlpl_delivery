import 'dart:developer';

import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    keepLogin();
  }

  keepLogin() {
    Future.delayed(Duration(seconds: 3), () async {
      bool isLoggedIn = await LocalStorage().readToken();
      if (isLoggedIn) {
        Get.offAllNamed(Routes.BOTTOMBAR);
        log(' 🤩 Login success 🤩 ');
      } else {
        Get.offAllNamed(Routes.AUTH);
      }
      // Navigate to the home page after the delay
    });
  }
}
