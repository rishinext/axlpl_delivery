import 'dart:developer';

import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/auth_repo.dart';
import 'package:axlpl_delivery/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController
  final AuthRepo _authRepo = AuthRepo();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    keepLogin();
  }

  void keepLogin() {
    Future.delayed(Duration(seconds: 3), () async {
      final userData = await LocalStorage().getUserLocalData();

      if (userData == null || userData.messangerdetail == null) {
        Get.offAllNamed(Routes.AUTH);
        return;
      }

      final String? token = userData.messangerdetail!.token;
      if (token != null && token.isNotEmpty) {
        Get.offAllNamed(Routes.BOTTOMBAR);
        log(' 🤩 Login success 🤩 ');
      } else {
        Get.offAllNamed(Routes.AUTH);
      }
    });
  }
}
