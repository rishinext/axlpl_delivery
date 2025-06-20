import 'package:get/get.dart';

import '../controllers/shipment_record_controller.dart';

class ShipmentRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShipmentRecordController>(
      () => ShipmentRecordController(),
    );
  }
}
