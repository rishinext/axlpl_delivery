import 'package:axlpl_delivery/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration(seconds: 3), () {
      // Navigate to the home page after the delay
      Get.offAllNamed(Routes.AUTH);
    });
  }
}
