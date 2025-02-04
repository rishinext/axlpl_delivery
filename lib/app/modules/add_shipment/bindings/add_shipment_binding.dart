import 'package:get/get.dart';

import '../controllers/add_shipment_controller.dart';

class AddShipmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddShipmentController>(
      () => AddShipmentController(),
    );
  }
}
