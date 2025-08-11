import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/pickup/controllers/pickup_controller.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/invoice_image_dialog.dart';
import 'package:axlpl_delivery/common_widget/otp_dialog.dart';
import 'package:axlpl_delivery/common_widget/pickup_dialog.dart';
import 'package:axlpl_delivery/common_widget/tracking_info_widget.dart';
import 'package:axlpl_delivery/common_widget/transfer_dialog.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../controllers/running_delivery_details_controller.dart';

class RunningDeliveryDetailsView
    extends GetView<RunningDeliveryDetailsController> {
  // final RunningPickUp? runningPickUp;
  final isShowInvoice;
  final isShowTransfer;
  RunningDeliveryDetailsView({
    this.isShowInvoice = true,
    this.isShowTransfer = false,
    super.key,
    // this.runningPickUp,
  });
  @override
  Widget build(BuildContext context) {
    StepperType type = StepperType.horizontal;
    final args = Get.arguments as Map<String, dynamic>?;

    final String? shipmentID = args?['shipmentID']?.toString();
    final String? messengerId = args?['messangerId']?.toString();

    final String? invoicePath = args?['invoicePath'] as String?;
    // final String? enableTransfer = Get.arguments['enableTransfer'] as String?;

    final String? date = args?['date'] as String?;

    final String? invoicePhoto = args?['invoicePhoto'] as String?;

    final pickupController = Get.put(PickupController());

    return CommonScaffold(
      appBar: commonAppbar('Tracking Detail'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(child: Obx(
          () {
            final senderData = controller.senderData;
            final receiverData = controller.receiverData;

            final trackingStatus = controller.trackingStatus;
            final details = controller.shipmentDetail.value;
            print(details?.invoiceNumber.toString() ?? 'N/A');
            if (controller.isTrackingLoading.value == Status.loading) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (controller.isTrackingLoading.value == Status.error) {
              return Center(
                child: Text(
                  'No Tracking Data Found',
                  style: themes.fontReboto16_600,
                ),
              );
            } else if (controller.isTrackingLoading.value == Status.success) {
              String formattedDate = trackingStatus.isNotEmpty
                  ? DateFormat('dd-MM-yyyy hh:mm a') //

                      .format(trackingStatus[0].dateTime)
                  : 'No date available';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top container with order and status
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: themes.whiteColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        // CircleAvatar(
                        //   backgroundColor: themes.blueGray,
                        //   child: Image.asset(shopingIcon, width: 20.w),
                        // ),
                        // SizedBox(width: 12),
                        Text(
                          'Shipment ID: \n${details?.shipmentId ?? 'N/A'}',
                          style: themes.fontSize14_500.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 12.sp),
                          overflow: TextOverflow.ellipsis,
                        ),
                        IconButton(
                            onPressed: () {
                              Clipboard.setData(new ClipboardData(
                                  text: shipmentID.toString()));
                            },
                            icon: Icon(
                              Icons.copy,
                              size: 18,
                            )),
                        Spacer(),
                        Flexible(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: themes.blueGray,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              overflow: TextOverflow.fade,
                              details?.shipmentStatus.toString() ?? 'N/A',
                              style: themes.fontSize14_500
                                  .copyWith(color: themes.darkCyanBlue),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Sender & Receiver Section
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: themes.whiteColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Sender
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.my_location, color: themes.darkCyanBlue),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    senderData.isNotEmpty
                                        ? senderData[0].senderName ??
                                            'No sender name'
                                        : 'No sender name',
                                    style: themes.fontSize16_400.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '${senderData.isNotEmpty ? senderData[0].address1 ?? '' : ''}, ${senderData.isNotEmpty ? senderData[0].state ?? '' : ''}',
                                    style: themes.fontSize14_400.copyWith(
                                      color: themes.grayColor,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        // Receiver
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.location_on_outlined,
                                color: themes.darkCyanBlue),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    receiverData.isNotEmpty
                                        ? receiverData[0].receiverName ??
                                            'No receiver name'
                                        : 'No receiver name',
                                    style: themes.fontSize16_400.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '${receiverData.isNotEmpty ? receiverData[0].address1 ?? '' : ''}, ${receiverData.isNotEmpty ? receiverData[0].state ?? '' : ''}',
                                    style: themes.fontSize14_400.copyWith(
                                        color: themes.grayColor,
                                        fontSize: 13.sp),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    receiverData.isNotEmpty
                                        ? receiverData[0].mobile ?? 'N/A'
                                        : 'N/A',
                                    style: themes.fontSize14_400.copyWith(
                                        color: themes.grayColor,
                                        fontSize: 13.sp),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Parcel & Weight + Payment Mode Cards
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: themes.whiteColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: infoCard('Parcel Details',
                                    details?.parcelDetail ?? 'N/A')),
                            SizedBox(width: 12),
                            Expanded(
                                child: infoCard('Net Weight',
                                    '${details?.netWeight ?? "N/A"}g')),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                                child: infoCard('Gross Weight',
                                    '${details?.grossWeight ?? "N/A"}g')),
                            SizedBox(width: 12),
                            Expanded(
                                child: infoCard('Payment Mode',
                                    details?.paymentMode ?? 'N/A')),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Insurance Details Section
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: themes.whiteColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Insurance Details',
                            style: themes.fontSize16_400
                                .copyWith(fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10.h,
                        ),
                        infoRow('Insurance Value',
                            details?.insuranceValue?.toString() ?? 'N/A'),
                        Divider(),
                        SizedBox(height: 8),
                        infoRow('Insurance Charges',
                            details?.insuranceCharges?.toString() ?? 'N/A'),
                        // Divider(),
                        // SizedBox(height: 8),
                        // _infoRow('Total Charges',
                        //     details?.totalCharges?.toString() ?? 'N/A'),
                        Divider(),
                        SizedBox(height: 12),
                        infoRow(
                          'Insurance Type',
                          details?.axlplInsurance == '1'
                              ? 'Yes Axlpl Insurance'
                              : 'No Axlpl Insurance',
                        ),
                        Divider(),
                        SizedBox(height: 8),
                        infoRow(
                          'Policy Details',
                          details?.policyNo?.isEmpty == true
                              ? 'No Policy'
                              : details!.policyNo!,
                        ),
                        // SizedBox(height: 15.h),
                        // Divider(),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: themes.whiteColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Charges Details',
                            style: themes.fontSize16_400
                                .copyWith(fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10.h,
                        ),
                        infoRow('Gst ', details?.tax?.toString() ?? 'N/A'),
                        Divider(),
                        SizedBox(height: 8),
                        infoRow('Total Charges',
                            details?.totalCharges?.toString() ?? 'N/A'),
                        // Divider(),
                        // SizedBox(height: 8),
                        // _infoRow('Total Charges',
                        //     details?.totalCharges?.toString() ?? 'N/A'),
                        Divider(),
                        SizedBox(height: 8),
                        infoRow('Grand Total',
                            details?.grandTotal?.toString() ?? 'N/A'),
                        // SizedBox(height: 15.h), c c
                        // Divider(),
                      ],
                    ),
                  ),
                  controller.hasCashCollectionData
                      ? Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: themes.whiteColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Collection Details',
                                  style: themes.fontSize16_400
                                      .copyWith(fontWeight: FontWeight.bold)),
                              SizedBox(height: 10.h),
                              Column(
                                children: [
                                  ...controller.cashCollectionData
                                      .map((cashLog) {
                                    return Column(
                                      children: [
                                        infoRow(
                                            'Collected Date',
                                            DateFormat('dd MMM yy')
                                                .format(cashLog.createdDate!)),
                                        Divider(),
                                        SizedBox(height: 6),
                                        infoRow('Payment Mode',
                                            cashLog.subPaymentMode ?? 'N/A'),
                                        Divider(),
                                        SizedBox(height: 6),
                                        infoRow('Collected By',
                                            cashLog.colletedBy ?? 'N/A'),
                                        Divider(),
                                        SizedBox(height: 6),
                                        infoRow('Collected Amount',
                                            '₹${cashLog.cashamount?.toString() ?? cashLog.amount?.toString() ?? 'N/A'}'),
                                      ],
                                    );
                                  }).toList(),
                                ],
                              )
                            ],
                          ),
                        )
                      : SizedBox.shrink(),
                  isShowInvoice == true
                      ? Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: themes.whiteColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              Text('Invoice Details',
                                  style: themes.fontSize16_400
                                      .copyWith(fontWeight: FontWeight.bold)),
                              infoRow('Invoice Value',
                                  details?.invoiceValue?.toString() ?? 'N/A'),
                              Divider(),
                              SizedBox(height: 8),
                              infoRow(
                                'Invoice Number',
                                details?.invoiceNumber.toString() ?? 'N/A',
                              ),
                              // Divider(),
                              // SizedBox(height: 8),
                              // infoRow(
                              //     'Invoice Charges',
                              //     details?.invoiceCharges?.toString() == ''
                              //         ? 'N/A'
                              //         : '' ?? 'N/A'),
                              Divider(),
                              details?.invoicePhoto != ''
                                  ? InvoiceImagePopup(
                                      invoicePath:
                                          details?.invoicePath.toString() ??
                                              invoicePath ??
                                              '',
                                      invoicePhoto:
                                          details?.invoicePhoto.toString() ??
                                              invoicePhoto ??
                                              '',
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 8.h),
                                        Obx(() {
                                          final file = controller
                                              .getImage(shipmentID.toString());

                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              if (file ==
                                                  null) // No image selected, show upload icon
                                                InkWell(
                                                  onTap: () {
                                                    controller.pickImage(
                                                        ImageSource.gallery,
                                                        (file) {
                                                      controller.setImage(
                                                          shipmentID.toString(),
                                                          file);
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.upload_file,
                                                    color: themes.darkCyanBlue,
                                                    size: 60.sp,
                                                  ),
                                                )
                                              else // Image selected, show preview with remove button
                                                Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.file(
                                                        file,
                                                        width: 120,
                                                        height: 120,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 4,
                                                      right: 4,
                                                      child: GestureDetector(
                                                        onTap: () => controller
                                                            .removeImage(
                                                                shipmentID
                                                                    .toString()),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Colors.black54,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(4),
                                                          child: Icon(
                                                            Icons.close,
                                                            size: 20,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      themes.darkCyanBlue,
                                                  foregroundColor:
                                                      themes.whiteColor,
                                                ),
                                                onPressed: file == null
                                                    ? null
                                                    : () {
                                                        controller
                                                            .uploadInvoice(
                                                          shipmentID: details
                                                                  ?.shipmentId
                                                                  .toString() ??
                                                              '0',
                                                          file: file,
                                                        );
                                                      },
                                                child: Text('UPLOAD'),
                                              ),
                                            ],
                                          );
                                        }),
                                        // SizedBox(height: 12.h),
                                        // Obx(() {
                                        //   final file = controller
                                        //       .getImage(shipmentID.toString());
                                        //   if (file == null) return SizedBox();

                                        //   return Stack(
                                        //     children: [
                                        //       ClipRRect(
                                        //         borderRadius:
                                        //             BorderRadius.circular(8),
                                        //         child: Image.file(file,
                                        //             width: 120,
                                        //             height: 120,
                                        //             fit: BoxFit.cover),
                                        //       ),
                                        //       Positioned(
                                        //         top: 4,
                                        //         right: 4,
                                        //         child: GestureDetector(
                                        //           onTap: () => controller
                                        //               .removeImage(shipmentID
                                        //                   .toString()),
                                        //           child: Container(
                                        //             decoration: BoxDecoration(
                                        //                 color: Colors.black54,
                                        //                 shape: BoxShape.circle),
                                        //             child: Icon(Icons.close,
                                        //                 size: 20,
                                        //                 color: Colors.white),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   );
                                        // }),
                                      ],
                                    ),
                            ],
                          ),
                        )
                      : SizedBox(),
                  isShowTransfer
                      ? Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: themes.whiteColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () {
                                    final userId =
                                        pickupController.currentUserId.value;
                                    final enableTransfer =
                                        messengerId.toString() == userId;
                                    return ElevatedButton(
                                      onPressed: enableTransfer
                                          ? () {
                                              showTransferDialog(
                                                () {
                                                  final messengerId =
                                                      pickupController
                                                          .selectedMessenger
                                                          .value
                                                          .toString();
                                                  if (messengerId.isNotEmpty) {
                                                    pickupController
                                                        .transferShipment(
                                                      shipmentID.toString(),
                                                      messengerId, // Pass selected messenger ID
                                                    );
                                                    Get.back();
                                                  } else {
                                                    Get.snackbar(
                                                      'Error',
                                                      'Please select a messenger',
                                                      colorText:
                                                          themes.whiteColor,
                                                      backgroundColor:
                                                          themes.redColor,
                                                    );
                                                    Get.back();
                                                  }
                                                },
                                              );
                                            }
                                          : null,
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: enableTransfer
                                            ? themes.whiteColor
                                            : themes.blueGray,
                                        foregroundColor: enableTransfer
                                            ? themes.darkCyanBlue
                                            : themes.grayColor,
                                        side: BorderSide(
                                            color: enableTransfer
                                                ? themes.darkCyanBlue
                                                : themes.grayColor,
                                            width: 1.w),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 8.h),
                                      ),
                                      child: Text(
                                        'Transfer',
                                        style: themes.fontSize18_600.copyWith(
                                          fontSize: 14.sp,
                                          color: enableTransfer
                                              ? themes.darkCyanBlue
                                              : themes.grayColor,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    final amountController =
                                        pickupController.getAmountController(
                                            shipmentID.toString());
                                    final chequeController =
                                        pickupController.getChequeController(
                                            shipmentID.toString());
                                    final otpController =
                                        pickupController.getOtpController(
                                            shipmentID.toString());
                                    final selectedSubPaymentMode =
                                        pickupController
                                            .getSelectedSubPaymentMode(
                                                shipmentID.toString());

                                    if (details?.paymentMode.toString() !=
                                        'topay') {
                                      showOtpDialog(
                                        () async {
                                          pickupController.uploadPickup(
                                            shipmentID,
                                            'Picked up',
                                            date,
                                            amountController.text,
                                            details?.paymentMode.toString() ??
                                                'N/A',
                                            selectedSubPaymentMode.value?.id,
                                            otpController.text,
                                          );
                                        },
                                        () async {
                                          await pickupController
                                              .getOtp(shipmentID);
                                        },
                                        otpController,
                                      );
                                    } else {
                                      showPickupDialog(
                                        shipmentID: shipmentID,
                                        date: date,
                                        amt: details?.totalCharges,
                                        dropdownHintTxt: selectedSubPaymentMode
                                                .value?.name ??
                                            'Select Payment Mode',
                                        btnTxt: 'Pickup',
                                        amountController: amountController,
                                        chequeNumberController:
                                            chequeController,
                                        otpController: otpController,
                                        selectedSubPaymentMode:
                                            selectedSubPaymentMode,
                                        onConfirmCallback: () {
                                          pickupController.uploadPickup(
                                            shipmentID,
                                            'Picked up',
                                            date,
                                            amountController.text,
                                            details?.paymentMode.toString() ??
                                                'N/A',
                                            selectedSubPaymentMode.value?.id,
                                            otpController.text,
                                            chequeNumber: chequeController.text,
                                          );
                                        },
                                        onSendOtpCallback: () async {
                                          await pickupController
                                              .getOtp(shipmentID);
                                        },
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: themes.whiteColor,
                                    backgroundColor: themes.darkCyanBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30.w, vertical: 8.h),
                                  ),
                                  child: Text('Pickup',
                                      style: TextStyle(fontSize: 13.sp)),
                                )
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                  // Your stepper container remains unchanged

                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: themes.whiteColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: EnhanceStepper(
                        physics: ClampingScrollPhysics(),
                        stepIconSize: 40, // Adjust size if needed
                        stepIconBuilder: (stepIndex, stepState) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: stepState == StepState.complete
                                ? themes
                                    .blueGray // ✅ Change completed step color
                                : Colors
                                    .grey[300], // ✅ Change pending step color
                          ),
                          padding: EdgeInsets.all(
                              10), // Adjust spacing inside circle
                          child: Icon(
                            Icons.gps_fixed,
                            color: themes.darkCyanBlue,
                            size: 20,
                          ),
                        ),
                        type: StepperType.vertical,
                        currentStep: controller.currentStep.value,
                        // onStepTapped: (index) =>
                        //     controller.currentStep.value = index,
                        steps: controller.trackingStatus.map((step) {
                          return EnhanceStep(
                            isActive: true,
                            state: StepState.complete,
                            title: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    step.status,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  formattedDate,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   trackingStatus[0].status,
                                //   style: TextStyle(color: Colors.grey),
                                // ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    // CircleAvatar(
                                    //   // backgroundImage:
                                    //   //     AssetImage(step["driverImage"]),
                                    //   radius: 20,
                                    // ),
                                    SizedBox(width: 8),
                                    // Column(
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: [
                                    //     Text(
                                    //       "Driver",
                                    //       style: TextStyle(color: Colors.grey),
                                    //     ),
                                    //     Text(
                                    //       'driver name',
                                    //       style: TextStyle(
                                    //           fontWeight: FontWeight.bold),
                                    //     ),
                                    //   ],
                                    // ),
                                    Spacer(),
                                    // InkWell(
                                    //   onTap: () {
                                    //     // controller.makingPhoneCall();
                                    //   },
                                    //   child: Container(
                                    //     padding: EdgeInsets.symmetric(
                                    //         horizontal: 12.w, vertical: 5.h),
                                    //     decoration: BoxDecoration(
                                    //       color: Colors.blue[100],
                                    //       borderRadius:
                                    //           BorderRadius.circular(20),
                                    //     ),
                                    //     child: Row(
                                    //       children: [
                                    //         Image.asset(
                                    //           phoneIcon,
                                    //           width: 15.w,
                                    //         ),
                                    //         SizedBox(width: 5),
                                    //         Text('driver number',
                                    //             style: themes.fontSize14_500
                                    //                 .copyWith(
                                    //                     fontSize: 14.sp,
                                    //                     color: themes
                                    //                         .darkCyanBlue)),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        controlsBuilder: (context, details) =>
                            SizedBox(), // Hide buttons
                      )

                      // Hide buttons
                      ),

                  SizedBox(height: 20),
                ],
              );
            } else {
              return Center(
                child: Text('No Track Data Found!'),
              );
            }
          },
        )),
      ),
    );
  }
}

Widget buildDetailSection(String title, String mainInfo, String secondaryInfo,
        {String? extraInfo}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: themes.fontSize18_600
                .copyWith(color: themes.grayColor, fontSize: 16.sp)),
        SizedBox(height: 4),
        Text(mainInfo, style: themes.fontSize14_500.copyWith(fontSize: 15.sp)),
        if (secondaryInfo.trim().isNotEmpty)
          Text(secondaryInfo,
              style: themes.fontSize14_500.copyWith(color: themes.grayColor)),
        if (extraInfo != null)
          Text(extraInfo,
              style: themes.fontSize14_500.copyWith(color: themes.grayColor)),
      ],
    );
