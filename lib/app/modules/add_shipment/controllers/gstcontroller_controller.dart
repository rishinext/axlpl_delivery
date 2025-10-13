import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GstcontrollerController extends GetxController {
  //TODO: Implement GstcontrollerController

  var amountController = TextEditingController();
  var gstAmount = 0.0.obs;
  var totalAmount = 0.0.obs;

  void calculateGST() {
    final text = amountController.text.trim();
    if (text.isNotEmpty) {
      final amount = double.tryParse(text) ?? 0.0;
      const gstRate = 18.0; // 18% GST
      final gst = (amount * gstRate) / 100;
      final total = amount + gst;

      gstAmount.value = gst;
      totalAmount.value = total;
    } else {
      gstAmount.value = 0.0;
      totalAmount.value = 0.0;
    }
  }

  @override
  void onClose() {
    // amountController.dispose();
    super.onClose();
  }
}
