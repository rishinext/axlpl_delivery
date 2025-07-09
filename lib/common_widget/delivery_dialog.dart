import 'package:axlpl_delivery/app/data/models/payment_mode_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
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

class DeliveryDialog extends StatelessWidget {
  final String shipmentID;
  final String date;
  final TextEditingController amountController;
  final TextEditingController chequeNumberController;
  final TextEditingController accountNumberController;
  final TextEditingController onlineNumberController;
  final TextEditingController otpController;
  final String dropdownHintTxt;
  final String btnTxt;
  final VoidCallback? onConfirmCallback;
  final VoidCallback? onSendOtpCallback;

  DeliveryDialog({
    required this.shipmentID,
    required this.date,
    required this.amountController,
    required this.chequeNumberController,
    required this.otpController,
    required this.dropdownHintTxt,
    required this.btnTxt,
    this.onConfirmCallback,
    this.onSendOtpCallback,
    required this.accountNumberController,
    required this.onlineNumberController,
  });

  final deliveryController = Get.put(DeliveryController());
  final pickupController = Get.find<PickupController>();
  final historyController = Get.put(HistoryController());

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

  @override
  Widget build(BuildContext context) {
    final selectedSubPaymentMode =
        deliveryController.getSelectedSubPaymentMode(shipmentID);
    return AlertDialog(
      backgroundColor: themes.whiteColor,
      title: Text(
        'Payment Details',
        style: themes.fontSize18_600.copyWith(color: themes.darkCyanBlue),
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 400.w,
          child: Column(
            spacing: 10.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              CommonTextfiled(
                controller: amountController,
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
                    border: Border.all(color: Colors.grey.shade400),
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
                      value: selectedSubPaymentMode.value,
                      items: deliveryController.subPaymentModes
                          .map((mode) => DropdownMenuItem(
                                value: mode,
                                child: Text(mode.name),
                              ))
                          .toList(),
                      onChanged: (val) => deliveryController
                          .setSelectedSubPaymentMode(shipmentID, val),
                    ),
                  ),
                );
              }),
              Obx(() {
                final selectedMode = selectedSubPaymentMode.value;

                if (selectedMode?.id == 'account') {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dropdownText('Transaction ID'),
                      CommonTextfiled(
                        controller: accountNumberController,
                        hintTxt: 'Enter Transaction ID',
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              }),
              Obx(() {
                final selectedMode = selectedSubPaymentMode.value;

                if (selectedMode?.id == 'online') {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dropdownText('Transaction ID'),
                      CommonTextfiled(
                        controller: onlineNumberController,
                        hintTxt: 'Enter Transaction ID',
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              }),
              Obx(() {
                final selectedMode = selectedSubPaymentMode.value;

                if (selectedMode?.id == 'cheque') {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dropdownText('Cheque Number'),
                      CommonTextfiled(
                        controller: chequeNumberController,
                        hintTxt: 'Enter Cheque Number',
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Enter OTP'),
                  Obx(() {
                    return pickupController.isOtpLoading.value == Status.loading
                        ? Center(child: CircularProgressIndicator.adaptive())
                        : TextButton(
                            onPressed: onSendOtpCallback,
                            child: Text(
                              'Send OTP',
                              style: themes.fontSize14_500
                                  .copyWith(color: themes.darkCyanBlue),
                            ),
                          );
                  }),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: Pinput(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  length: 4,
                  controller: otpController,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: themes.darkCyanBlue),
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
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: themes.darkCyanBlue,
            backgroundColor: themes.whiteColor,
            side: BorderSide(color: themes.darkCyanBlue),
          ),
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: themes.darkCyanBlue,
            foregroundColor: themes.whiteColor,
          ),
          onPressed: () {
            if (otpController.text.length != 4) {
              Get.snackbar('Invalid OTP', 'Please enter all 4 digits.',
                  colorText: themes.whiteColor,
                  backgroundColor: themes.redColor);
              return;
            }

            onConfirmCallback?.call();
          },
          child: Text(btnTxt),
        ),
      ],
    );
  }
}
