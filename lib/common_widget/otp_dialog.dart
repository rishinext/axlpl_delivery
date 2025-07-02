import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

void showOtpDialog(
  VoidCallback? onConfirmCallback,
  final controller,
) {
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
    onConfirm: onConfirmCallback,
    textConfirm: 'Enter OTP',
    buttonColor: themes.darkCyanBlue,
    textCancel: 'Cancel',
    title: "Enter OTP",
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 400.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Pinput(
              length: 4,
              defaultPinTheme: defaultPinTheme,
              controller: controller,
              onCompleted: (pin) {
                // Handle OTP submission
                Utils().log('OTP entered: $pin');
              },
            ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     Get.back();
            //   },
            //   child: const Text('Submit'),
            // ),
          ],
        ),
      ),
    ),
  );
}
