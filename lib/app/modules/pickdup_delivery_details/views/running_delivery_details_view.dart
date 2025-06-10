import 'dart:developer';

import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/pickup/controllers/pickup_controller.dart';
import 'package:axlpl_delivery/app/modules/profile/controllers/profile_controller.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
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
    final String? shipmentID = Get.arguments['shipmentID'] as String?;
    final String? status = Get.arguments['status'] as String?;
    final String? invoicePath = Get.arguments['invoicePath'] as String?;

    final profileController = Get.put(ProfileController());
    final pickupController = Get.put(PickupController());

    return CommonScaffold(
      appBar: commonAppbar('Pickup Delivery Detail'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(child: Obx(
          () {
            final senderData = controller.senderData;
            final receiverData = controller.receiverData;

            final trackingStatus = controller.trackingStatus;
            final details = controller.shipmentDetail.value;
            if (controller.isTrackingLoading.value == Status.loading) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (controller.isTrackingLoading.value == Status.error) {
              return Center(
                child: Text('No Tracking Data Found'),
              );
            } else if (controller.isTrackingLoading.value == Status.success) {
              String formattedDate = trackingStatus.isNotEmpty
                  ? DateFormat('dd-MM-yyyy HH:mm')
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
                        Expanded(
                          child: Text(
                            'Shipment ID: ${shipmentID.toString()}',
                            style: themes.fontSize14_500.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12.sp),
                            overflow: TextOverflow.ellipsis,
                          ),
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
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: themes.blueGray,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            status.toString(),
                            style: themes.fontSize14_500
                                .copyWith(color: themes.darkCyanBlue),
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
                                        fontSize: 13.sp),
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
                                child: _infoCard('Parcel Details',
                                    details?.parcelDetail ?? 'N/A')),
                            SizedBox(width: 12),
                            Expanded(
                                child: _infoCard('Net Weight',
                                    '${details?.netWeight ?? "N/A"}g')),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                                child: _infoCard('Gross Weight',
                                    '${details?.grossWeight ?? "N/A"}g')),
                            SizedBox(width: 12),
                            Expanded(
                                child: _infoCard('Payment Mode',
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
                        _infoRow('Insurance Value',
                            details?.insuranceValue?.toString() ?? 'N/A'),
                        Divider(),
                        SizedBox(height: 8),
                        _infoRow('Insurance Charges',
                            details?.insuranceCharges?.toString() ?? 'N/A'),
                        // Divider(),
                        // SizedBox(height: 8),
                        // _infoRow('Total Charges',
                        //     details?.totalCharges?.toString() ?? 'N/A'),
                        Divider(),
                        SizedBox(height: 12),
                        _infoRow(
                          'Insurance Type',
                          details?.axlplInsurance == '1'
                              ? 'Yes Axlpl Insurance'
                              : 'No Axlpl Insurance',
                        ),
                        Divider(),
                        SizedBox(height: 8),
                        _infoRow(
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
                        _infoRow('Gst ',
                            details?.insuranceValue?.toString() ?? 'N/A'),
                        Divider(),
                        SizedBox(height: 8),
                        _infoRow('Total Charges',
                            details?.insuranceCharges?.toString() ?? 'N/A'),
                        // Divider(),
                        // SizedBox(height: 8),
                        // _infoRow('Total Charges',
                        //     details?.totalCharges?.toString() ?? 'N/A'),
                        Divider(),

                        // SizedBox(height: 15.h),
                        // Divider(),
                      ],
                    ),
                  ),
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
                              Text('Invoice Details',
                                  style: themes.fontSize16_400
                                      .copyWith(fontWeight: FontWeight.bold)),
                              _infoRow('Invoice Value',
                                  details?.invoiceValue?.toString() ?? 'N/A'),
                              Divider(),
                              SizedBox(height: 8),
                              _infoRow(
                                  'Invoice Number',
                                  details?.invoiceCharges?.toString() == ''
                                      ? 'N/A'
                                      : '' ?? 'N/A'),
                              Divider(),
                              invoicePath != null || invoicePath != ''
                                  ? Image.network(
                                      invoicePath.toString(),
                                      fit: BoxFit.cover,
                                      height: 120,
                                      width: 120,
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            OutlinedButton(
                                              onPressed: () {
                                                controller.pickImage(
                                                    ImageSource.gallery,
                                                    (file) {
                                                  controller.setImage(
                                                      shipmentID.toString(),
                                                      file);
                                                });
                                              },
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide(
                                                    color: themes.grayColor,
                                                    width: 1.w),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.w,
                                                    vertical: 8.h),
                                              ),
                                              child: Text(
                                                'Choose',
                                                style: themes.fontSize14_500
                                                    .copyWith(
                                                        color: themes
                                                            .darkCyanBlue),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    themes.darkCyanBlue,
                                                foregroundColor:
                                                    themes.whiteColor,
                                              ),
                                              onPressed: () {
                                                final file =
                                                    controller.getImage(
                                                        shipmentID.toString());
                                                if (file != null) {
                                                  controller.uploadInvoice(
                                                      shipmentID:
                                                          shipmentID.toString(),
                                                      file: file);
                                                }
                                              },
                                              child: Text('UPLOAD'),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 12.h),
                                        Obx(() {
                                          final file = controller
                                              .getImage(shipmentID.toString());
                                          if (file == null) return SizedBox();

                                          return Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.file(file,
                                                    width: 120,
                                                    height: 120,
                                                    fit: BoxFit.cover),
                                              ),
                                              Positioned(
                                                top: 4,
                                                right: 4,
                                                child: GestureDetector(
                                                  onTap: () => controller
                                                      .removeImage(shipmentID
                                                          .toString()),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.black54,
                                                        shape: BoxShape.circle),
                                                    child: Icon(Icons.close,
                                                        size: 20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
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
                                OutlinedButton(
                                  onPressed: () {
                                    showTransferDialog(
                                      () {
                                        final messengerId = pickupController
                                            .selectedMessenger.value
                                            .toString();
                                        if (messengerId.isNotEmpty) {
                                          pickupController.transferShipment(
                                            shipmentID.toString(),
                                            messengerId, // Pass selected messenger ID
                                          );
                                          Get.back();
                                        } else {
                                          Get.snackbar(
                                            'Error',
                                            'Please select a messenger',
                                            colorText: themes.whiteColor,
                                            backgroundColor: themes.redColor,
                                          );
                                          Get.back();
                                        }
                                      },
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        color: themes.darkCyanBlue, width: 1.w),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 8.h),
                                  ),
                                  child: Text(
                                    'Transfer',
                                    style: themes.fontSize18_600.copyWith(
                                      fontSize: 14.sp,
                                      color: themes.darkCyanBlue,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
Widget _infoCard(String label, String value) {
  return Column(
    spacing: 8,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.grey[700])),
      Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              value,
              style: themes.fontSize14_500.copyWith(fontSize: 12.sp),
            ),
          )),
    ],
  );
}

// Helper widget for two-column rows in insurance details
Widget _infoRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
      Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
    ],
  );
}
