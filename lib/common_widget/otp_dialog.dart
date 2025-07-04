import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/pickup/controllers/pickup_controller.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

void showOtpDialog(
  VoidCallback? onConfirmCallback,
  VoidCallback? onOtpCallback,
  final controller,
) {
  final pickupController = Get.find<PickupController>();
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
            Obx(() {
              return pickupController.isOtpLoading.value == Status.loading
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : TextButton(
                      onPressed: onOtpCallback,
                      child: Text(
                        'Send OTP',
                        style: themes.fontSize14_500
                            .copyWith(color: themes.darkCyanBlue),
                      ),
                    );
            })
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
