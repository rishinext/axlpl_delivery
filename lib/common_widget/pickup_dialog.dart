import 'dart:developer';

import 'package:axlpl_delivery/app/data/models/payment_mode_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/pickup/controllers/pickup_controller.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showPickDialog() {
  final _formKey = GlobalKey<FormState>();
  final pickupController = Get.find<PickupController>();
  Get.defaultDialog(
    title: "Payment Mode",
    content: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            CommonTextfiled(
              controller: pickupController.amountController,
              obscureText: true,
              hintTxt: 'Enter Amount',
              keyboardType: TextInputType.number,
              // validator: (value) =>
              //     value == null || value.length < 6 ? "Min 6 characters" : null,
            ),
            dropdownText('Payment Mode'),
            Obx(() => CommonDropdown(
                  hint: 'Select Payment',
                  selectedValue: pickupController.selectedPay.value,
                  isLoading:
                      pickupController.isPickupLoading.value == Status.loading,
                  items:
                      pickupController.paymentModes.map((e) => e.id!).toList(),
                  itemLabel: (id) {
                    final payment = pickupController.paymentModes.firstWhere(
                      (e) => e.id == id,
                      orElse: () => PaymentMode(),
                    );
                    return payment.name ?? 'Unknown';
                  },
                  itemValue: (m) => m,
                  onChanged: (val) {
                    log(val.toString());
                    pickupController.selectedPay.value = val;
                  },
                )),
            const SizedBox(height: 16),
          ],
        ),
      ),
    ),
    radius: 10,
    textConfirm: "Submit",
    textCancel: "Cancel",
    confirmTextColor: themes.whiteColor,
    onConfirm: () {
      if (_formKey.currentState?.validate() == true) {}
    },
  );
}
