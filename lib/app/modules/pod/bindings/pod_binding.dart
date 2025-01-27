import 'package:get/get.dart';

import '../controllers/pod_controller.dart';

class PodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PodController>(
      () => PodController(),
    );
  }
}
