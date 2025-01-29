import 'package:get/get.dart';

import '../controllers/running_delivery_details_controller.dart';

class RunningDeliveryDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RunningDeliveryDetailsController>(
      () => RunningDeliveryDetailsController(),
    );
  }
}
