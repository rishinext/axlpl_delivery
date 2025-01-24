import 'package:get/get.dart';

import '../controllers/shipnow_controller.dart';

class ShipnowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShipnowController>(
      () => ShipnowController(),
    );
  }
}
