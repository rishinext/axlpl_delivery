import 'package:get/get.dart';

import '../controllers/consignment_controller.dart';

class ConsignmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConsignmentController>(
      () => ConsignmentController(),
    );
  }
}
