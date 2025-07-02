import 'package:axlpl_delivery/app/data/models/payment_mode_model.dart';
import 'package:axlpl_delivery/app/modules/delivery/controllers/delivery_controller.dart';
import 'package:axlpl_delivery/app/modules/history/controllers/history_controller.dart';
import 'package:axlpl_delivery/app/modules/pickup/controllers/pickup_controller.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

void showDeliveryDialog(
  final shipmentID,
  final date,
  final amt,
  final dropdownHintTxt,
  final btnTxt,
  VoidCallback? onConfirmCallback,
) {
  final _formKey = GlobalKey<FormState>();
  final pickupController = Get.find<PickupController>();
  final deliveryController = Get.put(DeliveryController());
  final historyController = Get.put(HistoryController());
  TextEditingController pinController = TextEditingController();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      color: themes.blueGray,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.transparent),
    ),
  );
  Get.defaultDialog(
    buttonColor: themes.darkCyanBlue,
    title: "Payment Mode",
    content: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 400.w,
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
              ),

/*dropdownText('Payment Mode'),
              Obx(() {
                if (pickupController.isLoadingPayment.value) {
                  return Center(child: CircularProgressIndicator());
                }

                return Container(
                  width: double.infinity,
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
                      hint: Text('Payment Mode'),
                      value: pickupController.selectedPaymentMode.value,
                      items: pickupController.paymentModes
                          .map((mode) => DropdownMenuItem(
                                value: mode,
                                child: Text(mode.name),
                              ))
                          .toList(),
                      onChanged: (value) =>
                          pickupController.setSelectedPaymentMode(value),
                    ),
                  ),
                );
              }),*/
              dropdownText('Sub Payment Mode'),
              Obx(() {
                if (deliveryController.isLoadingPayment.value) {
                  return Center(child: CircularProgressIndicator());
                }

                return Container(
                  width: double.infinity,
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
                      hint: Text(dropdownHintTxt),
                      value: deliveryController.selectedSubPaymentMode.value,
                      items: deliveryController.subPaymentModes
                          .map((mode) => DropdownMenuItem(
                                value: mode,
                                child: Text(mode.name),
                              ))
                          .toList(),
                      onChanged: (value) =>
                          deliveryController.setSelectedSubPaymentMode(value),
                    ),
                  ),
                );
              }),
              dropdownText('Enter OTP'),
              SizedBox(
                width: double.infinity,
                child: Pinput(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  length: 4,
                  controller: pinController,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(
                        color: themes.darkCyanBlue,
                      ),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyWith(
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ),
    radius: 10,
    textConfirm: btnTxt,
    textCancel: "Cancel",
    confirmTextColor: themes.whiteColor,
    onConfirm: onConfirmCallback,
  );
}
