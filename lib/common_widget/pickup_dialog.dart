import 'package:axlpl_delivery/app/data/models/payment_mode_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/pickup/controllers/pickup_controller.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class PickDialog extends StatelessWidget {
  final shipmentID;
  final date;
  final amt;
  final TextEditingController amountController;
  final TextEditingController chequeNumberController;
  final TextEditingController otpController;
  final Rxn<PaymentMode> selectedSubPaymentMode;
// add them to constructor and require them
  final dropdownHintTxt;
  final btnTxt;
  final VoidCallback onConfirmCallback;
  final VoidCallback? onSendOtpCallback;

  const PickDialog({
    required this.shipmentID,
    required this.date,
    required this.amt,
    required this.dropdownHintTxt,
    required this.btnTxt,
    required this.onConfirmCallback,
    this.onSendOtpCallback,
    super.key,
    required this.amountController,
    required this.chequeNumberController,
    required this.otpController,
    required this.selectedSubPaymentMode,
  });

  @override
  Widget build(BuildContext context) {
    final pickupController = Get.find<PickupController>();

    // Pre-fill the amount
    // pickupController.amountController.text = amt.toString();
    pickupController.chequeNumberController.clear();
    pickupController.otpController.clear();
    final selectedSubPaymentMode =
        pickupController.getSelectedSubPaymentMode(shipmentID);
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

    // Build dialog content
    Widget dialogContent = SizedBox(
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
          ),
          dropdownText('Sub Payment Mode'),
          Obx(() {
            if (pickupController.isLoadingPayment.value) {
              return const Center(child: CircularProgressIndicator());
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
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<PaymentMode>(
                  hint: Text(dropdownHintTxt),
                  value: selectedSubPaymentMode.value,
                  items: pickupController.subPaymentModes.map((mode) {
                    return DropdownMenuItem(
                      value: mode,
                      child: Text(mode.name),
                    );
                  }).toList(),
                  onChanged: (value) => pickupController
                      .setSelectedSubPaymentMode(shipmentID, value),
                ),
              ),
            );
          }),
          Obx(() {
            final selectedMode = selectedSubPaymentMode.value;
            if (selectedMode?.id != 'cash') {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  dropdownText(
                    selectedMode?.id == 'cheque'
                        ? 'Cheque Number'
                        : 'Transaction ID',
                  ),
                  CommonTextfiled(
                    controller: chequeNumberController,
                    hintTxt: selectedMode?.id == 'cheque'
                        ? 'Enter Cheque Number'
                        : 'Enter Transaction ID',
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
              const Text('Enter OTP'),
              Obx(() {
                final loading =
                    pickupController.isOtpLoading.value == Status.loading;
                final canResend = pickupController.canResend.value;
                final secs = pickupController.secondsLeft.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Send / Resend button
                    SizedBox(
                      height: 44,
                      child: loading
                          ? const Center(
                              child: CircularProgressIndicator.adaptive())
                          : TextButton(
                              onPressed: canResend
                                  ? () => pickupController.getOtp(shipmentID)
                                  : null, // disabled during cooldown
                              child: Text(
                                canResend ? 'Send OTP' : 'Resend in ${secs}s',
                                style: themes.fontSize14_500
                                    .copyWith(color: themes.darkCyanBlue),
                              ),
                            ),
                    ),
                  ],
                );
              })
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
    );

    // Return dialog without platform-specific handling
    return AlertDialog(
      backgroundColor: themes.whiteColor,
      title: Text('Enter Payment Details', style: themes.fontReboto16_600),
      content: SingleChildScrollView(
        child: dialogContent,
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
            onConfirmCallback.call();
          },
          child: Text(btnTxt),
        ),
      ],
    );
  }
}

/// Helper function to show pickup dialog
void showPickupDialog({
  required dynamic shipmentID,
  required dynamic date,
  required dynamic amt,
  required TextEditingController amountController,
  required TextEditingController chequeNumberController,
  required TextEditingController otpController,
  required Rxn<PaymentMode> selectedSubPaymentMode,
  required String dropdownHintTxt,
  required String btnTxt,
  required VoidCallback onConfirmCallback,
  VoidCallback? onSendOtpCallback,
}) {
  BuildContext context = Get.context!;

  showDialog(
    context: context,
    builder: (_) => PickDialog(
      shipmentID: shipmentID,
      date: date,
      amt: amt,
      amountController: amountController,
      chequeNumberController: chequeNumberController,
      otpController: otpController,
      selectedSubPaymentMode: selectedSubPaymentMode,
      dropdownHintTxt: dropdownHintTxt,
      btnTxt: btnTxt,
      onConfirmCallback: onConfirmCallback,
      onSendOtpCallback: onSendOtpCallback,
    ),
  );
}
