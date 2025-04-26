import 'package:get/get.dart';

import 'package:axlpl_delivery/app/modules/add_shipment/controllers/gstcontroller_controller.dart';

import '../controllers/add_shipment_controller.dart';

class AddShipmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GstcontrollerController>(
      () => GstcontrollerController(),
    );
    Get.lazyPut<AddShipmentController>(
      () => AddShipmentController(),
    );
  }
}
