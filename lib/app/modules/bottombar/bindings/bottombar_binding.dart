import 'package:get/get.dart';

import '../controllers/bottombar_controller.dart';

class BottombarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottombarController>(
      () => BottombarController(),
    );
  }
}
