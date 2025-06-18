import 'package:axlpl_delivery/app/modules/pickdup_delivery_details/views/customer_tracking_details_view.dart';
import 'package:get/get.dart';

import '../controllers/running_delivery_details_controller.dart';

class RunningDeliveryDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RunningDeliveryDetailsController>(
      () => RunningDeliveryDetailsController(),
    );
    Get.lazyPut<CustomerTrackingDetailsView>(
      () => CustomerTrackingDetailsView(),
    );
  }
}
