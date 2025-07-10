import 'package:axlpl_delivery/app/data/models/payment_mode_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/delivery/controllers/delivery_controller.dart';
import 'package:axlpl_delivery/app/modules/history/controllers/history_controller.dart';
import 'package:axlpl_delivery/app/modules/pickup/controllers/pickup_controller.dart';
import 'package:axlpl_delivery/common_widget/common_button.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

// void showPickDialog(
//   final shipmentID,
//   final date,
//   final amt,
//   final dropdownHintTxt,
//   final btnTxt,
//   VoidCallback onConfirmCallback,
//   VoidCallback? onSendOtpCallback,
// ) {
//   final _formKey = GlobalKey<FormState>();
//   final pickupController = Get.find<PickupController>();
//   final deliveryController = Get.put(DeliveryController());
//   final historyController = Get.put(HistoryController());

//   final defaultPinTheme = PinTheme(
//     width: 56,
//     height: 60,
//     textStyle: const TextStyle(
//       fontSize: 22,
//       color: Color.fromRGBO(30, 60, 87, 1),
//     ),
//     decoration: BoxDecoration(
//       color: themes.blueGray,
//       borderRadius: BorderRadius.circular(8),
//       border: Border.all(color: Colors.transparent),
//     ),
//   );
//   // Get.defaultDialog(
//   //   title: "Payment Mode",
//   //   buttonColor: themes.darkCyanBlue,
//   //   content: Form(
//   //     key: _formKey,
//   //     child: Padding(
//   //       padding: const EdgeInsets.all(8.0),
//   //       child: SizedBox(
//   //         width: 400.w,
//   //         child:
//   //         Column(
//   //           spacing: 10,
//   //           crossAxisAlignment: CrossAxisAlignment.start,
//   //           children: [
//   //             const SizedBox(height: 10),
//   //             CommonTextfiled(
//   //               controller: pickupController.amountController,
//   //               obscureText: false,
//   //               hintTxt: 'Enter Amount',
//   //               lableText: 'Enter Amount',
//   //               keyboardType: TextInputType.number,
//   //               validator: (value) {
//   //                 if (value == null || value.isEmpty) {
//   //                   return 'Please enter an amount';
//   //                 }
//   //                 final amount = int.tryParse(value);
//   //                 if (amount == null) {
//   //                   return 'Please enter a valid number';
//   //                 }
//   //                 if (amount < 1) {
//   //                   return 'Amount must be at least 1';
//   //                 }
//   //                 return null;
//   //               },
//   //             ),
//   //             dropdownText('Sub Payment Mode'),
//   //             Obx(() {
//   //               if (pickupController.isLoadingPayment.value) {
//   //                 return Center(child: CircularProgressIndicator());
//   //               }

//   //               return Container(
//   //                 width: double.infinity,
//   //                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//   //                 decoration: BoxDecoration(
//   //                   borderRadius: BorderRadius.circular(12),
//   //                   border: Border.all(color: Colors.grey.shade400, width: 1),
//   //                   color: Colors.white,
//   //                   boxShadow: [
//   //                     BoxShadow(
//   //                       color: Colors.grey.shade200,
//   //                       blurRadius: 6,
//   //                       offset: Offset(0, 2),
//   //                     ),
//   //                   ],
//   //                 ),
//   //                 child: DropdownButtonHideUnderline(
//   //                   child: DropdownButton<PaymentMode>(
//   //                     hint: Text(dropdownHintTxt),
//   //                     value: pickupController.selectedSubPaymentMode.value,
//   //                     items: pickupController.subPaymentModes
//   //                         .map((mode) => DropdownMenuItem(
//   //                               value: mode,
//   //                               child: Text(mode.name),
//   //                             ))
//   //                         .toList(),
//   //                     onChanged: (value) =>
//   //                         pickupController.setSelectedSubPaymentMode(value),
//   //                   ),
//   //                 ),
//   //               );
//   //             }),
//   //             dropdownText('Cheque Number'),
//   //             CommonTextfiled(
//   //               controller: pickupController.chequeNumberController,
//   //               obscureText: false,
//   //               hintTxt: 'Enter Cheque Number',
//   //               lableText: 'Enter Cheque Number',
//   //               keyboardType: TextInputType.text,
//   //             ),
//   //             dropdownText('Enter OTP'),
//   //             SizedBox(
//   //               width: double.infinity,
//   //               child: Pinput(
//   //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                 hapticFeedbackType: HapticFeedbackType.lightImpact,
//   //                 length: 4,
//   //                 controller: pinController,
//   //                 defaultPinTheme: defaultPinTheme,
//   //                 focusedPinTheme: defaultPinTheme.copyWith(
//   //                   decoration: defaultPinTheme.decoration!.copyWith(
//   //                     border: Border.all(
//   //                       color: themes.darkCyanBlue,
//   //                     ),
//   //                   ),
//   //                 ),
//   //                 errorPinTheme: defaultPinTheme.copyWith(
//   //                   decoration: BoxDecoration(
//   //                     color: Colors.red.shade50,
//   //                     borderRadius: BorderRadius.circular(8),
//   //                   ),
//   //                 ),
//   //               ),
//   //             ),
//   //             const SizedBox(height: 16),
//   //           ],
//   //         ),
//   //       ),
//   //     ),
//   //   ),
//   //   radius: 10,
//   //   textConfirm: btnTxt,
//   //   textCancel: "Cancel",
//   //   confirmTextColor: themes.whiteColor,
//   //   onConfirm: onConfirmCallback,
//   // );
//   BuildContext context = Get.context!;
//   showDialog(
//     context: context,
//     builder: (_) => AlertDialog(
//       backgroundColor: themes.whiteColor,
//       title: Text(
//         'Enter Payment Details',
//         style: themes.fontReboto16_600,
//       ),
//       content: SingleChildScrollView(
//         child: SizedBox(
//           width: 400.w,
//           child: Column(
//             spacing: 10,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 10),
//               CommonTextfiled(
//                 controller: pickupController.amountController,
//                 obscureText: false,
//                 hintTxt: 'Enter Amount',
//                 lableText: 'Enter Amount',
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter an amount';
//                   }
//                   final amount = int.tryParse(value);
//                   if (amount == null) {
//                     return 'Please enter a valid number';
//                   }
//                   if (amount < 1) {
//                     return 'Amount must be at least 1';
//                   }
//                   return null;
//                 },
//               ),
//               dropdownText('Sub Payment Mode'),
//               Obx(() {
//                 if (pickupController.isLoadingPayment.value) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 return Container(
//                   width: double.infinity,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.grey.shade400, width: 1),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.shade200,
//                         blurRadius: 6,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton<PaymentMode>(
//                       hint: Text(dropdownHintTxt),
//                       value: pickupController.selectedSubPaymentMode.value,
//                       items: pickupController.subPaymentModes.map((mode) {
//                         return DropdownMenuItem(
//                           value: mode,
//                           child: Text(mode.name),
//                         );
//                       }).toList(),
//                       onChanged: pickupController.setSelectedSubPaymentMode,
//                     ),
//                   ),
//                 );
//               }),
//               Obx(() {
//                 if (pickupController.selectedSubPaymentMode.value?.name ==
//                     'Cheque') {
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       dropdownText('Cheque Number'),
//                       CommonTextfiled(
//                         controller: pickupController.chequeNumberController,
//                         hintTxt: 'Enter Cheque Number',
//                         keyboardType: TextInputType.text,
//                       ),
//                     ],
//                   );
//                 } else {
//                   return const SizedBox.shrink();
//                 }
//               }),
//               Row(
//                 // crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Enter OTP'),
//                   Obx(() {
//                     return pickupController.isOtpLoading.value == Status.loading
//                         ? Center(child: CircularProgressIndicator.adaptive())
//                         : TextButton(
//                             onPressed: onSendOtpCallback,
//                             child: Text(
//                               'Send OTP',
//                               style: themes.fontSize14_500
//                                   .copyWith(color: themes.darkCyanBlue),
//                             ),
//                           );
//                   })
//                 ],
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 child: Pinput(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   hapticFeedbackType: HapticFeedbackType.lightImpact,
//                   length: 4,
//                   controller: pickupController.otpController,
//                   defaultPinTheme: defaultPinTheme,
//                   focusedPinTheme: defaultPinTheme.copyWith(
//                     decoration: defaultPinTheme.decoration!.copyWith(
//                       border: Border.all(
//                         color: themes.darkCyanBlue,
//                       ),
//                     ),
//                   ),
//                   errorPinTheme: defaultPinTheme.copyWith(
//                     decoration: BoxDecoration(
//                       color: Colors.red.shade50,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),
//       actions: [
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             foregroundColor: themes.darkCyanBlue,
//             backgroundColor: themes.whiteColor,
//             side: BorderSide(color: themes.darkCyanBlue),
//           ),
//           onPressed: () => Get.back(),
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//               backgroundColor: themes.darkCyanBlue,
//               foregroundColor: themes.whiteColor),
//           onPressed: () {
//             // if (pickupController.pincodeController.length != 4) {
//             //   Get.snackbar('Invalid OTP', 'Please enter all 4 digits.',
//             //       colorText: themes.whiteColor,
//             //       backgroundColor: themes.redColor);
//             //   return;
//             // }

//             onConfirmCallback.call();
//           },
//           child: Text(btnTxt),
//         ),
//       ],
//     ),
//   );
// }
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
    final deliveryController = Get.put(DeliveryController());
    final historyController = Get.put(HistoryController());

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

    return AlertDialog(
      backgroundColor: themes.whiteColor,
      title: Text('Enter Payment Details', style: themes.fontReboto16_600),
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
                    return pickupController.isOtpLoading.value == Status.loading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive())
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
            onConfirmCallback.call();
          },
          child: Text(btnTxt),
        ),
      ],
    );
  }
}
