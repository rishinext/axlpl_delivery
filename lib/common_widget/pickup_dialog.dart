import 'dart:developer';

import 'package:axlpl_delivery/app/data/models/payment_mode_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/history/controllers/history_controller.dart';
import 'package:axlpl_delivery/app/modules/pickup/controllers/pickup_controller.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showPickDialog(final shipmentID, final date) {
  final _formKey = GlobalKey<FormState>();
  final pickupController = Get.find<PickupController>();
  final historyController = Get.find<HistoryController>();
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
              obscureText: false,
              hintTxt: 'Enter Amount',
              lableText: 'Enter Amount',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                final amount = int.tryParse(value);
                if (amount == null) {
                  return 'Please enter a valid number';
                }
                if (amount < 1) {
                  return 'Amount must be at least 1';
                }
                return null;
              },
              // validator: (value) =>
              //     value == null || value.length < 6 ? "Min 6 characters" : null,
            ),
            dropdownText('Payment Mode'),
            /*    Obx(() => CommonDropdown(
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
                )),*/
            Obx(() {
              if (pickupController.isLoadingPayment.value) {
                return Center(child: CircularProgressIndicator());
              }

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade400, width: 1),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<PaymentMode>(
                    isExpanded: true,
                    hint: Text(
                      'Select Payment Mode',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    value: pickupController.selectedPaymentMode.value,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.blueGrey),
                    items: pickupController.paymentModes.map((mode) {
                      return DropdownMenuItem<PaymentMode>(
                        value: mode,
                        child: Text(
                          mode.name,
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                    onChanged: (PaymentMode? newValue) {
                      pickupController.setSelectedPaymentMode(newValue);
                    },
                  ),
                ),
              );
            }),
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
      if (_formKey.currentState?.validate() == true) {
        pickupController.uploadPickup(
          shipmentID,
          'Picked up',
          date,
          pickupController.amountController,
          'prepaid',
        );
        // pickupController.getPickupData();
        // historyController.getPickupHistory();
        Get.back();
      }
    },
  );
}
