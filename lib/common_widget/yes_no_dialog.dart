import 'package:flutter/material.dart';
import 'package:get/get.dart';

void yesNoDialog(
  VoidCallback? onConfirm,
  // VoidCallback? onCancel,
) {
  Get.defaultDialog(
    textConfirm: 'Yes',
    textCancel: 'No',
    title: 'Pickup',
    middleText: 'Do You want this Pickup?',
    onConfirm: onConfirm,
  );
}
