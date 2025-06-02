import 'package:axlpl_delivery/app/data/models/stepper_model.dart';
import 'package:axlpl_delivery/app/modules/pickdup_delivery_details/controllers/running_delivery_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildCustomStep(DeliveryStep step, int index) {
  final controller = Get.put(RunningDeliveryDetailsController());
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      // Timeline line
      Text('data')
    ],
  );
}
