import 'package:get/get.dart';

import '../controllers/myorders_controller.dart';

class MyordersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyordersController>(
      () => MyordersController(),
    );
  }
}
