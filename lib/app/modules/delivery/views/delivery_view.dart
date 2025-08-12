import 'dart:io';

import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/history/controllers/history_controller.dart';
import 'package:axlpl_delivery/app/modules/pickdup_delivery_details/controllers/running_delivery_details_controller.dart';
import 'package:axlpl_delivery/app/modules/pickup/controllers/pickup_controller.dart';
import 'package:axlpl_delivery/app/routes/app_pages.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/container_textfiled.dart';
import 'package:axlpl_delivery/common_widget/otp_dialog.dart';
import 'package:axlpl_delivery/common_widget/pickup_widget.dart';
import 'package:axlpl_delivery/common_widget/delivery_dialog.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';

import '../controllers/delivery_controller.dart';

class DeliveryView extends GetView<DeliveryController> {
  const DeliveryView({super.key});

  String formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return '';
    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('dd MMM yy').format(date); // Format as "12 Aug 25"
    } catch (e) {
      return dateString; // Return original if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    final deliveryController = Get.put(DeliveryController());
    final pickupController = Get.put(PickupController());
    final runningController = Get.put(RunningDeliveryDetailsController());
    final historyController = Get.put(HistoryController());
    return CommonScaffold(
      appBar: commonAppbar('Delivery'),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15.h,
              children: [
                // ContainerTextfiled(
                //   hintText: '   Enter your pin code',
                //   controller: deliveryController.pincodeController,
                //   onChanged: (value) {
                //     deliveryController.filterByPincode(value!);
                //     return null;
                //   },
                //   suffixIcon: Icon(
                //     CupertinoIcons.search,
                //     color: themes.grayColor,
                //   ),
                // ),
                Platform.isIOS
                    ? SizedBox(
                        height: 5.h,
                      )
                    : const SizedBox.shrink(),
                ContainerTextfiled(
                  controller: deliveryController.pincodeController,
                  hintText: 'Search Here',
                  onChanged: (value) {
                    deliveryController.filterByPincode(value!);
                    return null;
                  },
                  suffixIcon: Icon(CupertinoIcons.search),
                  prefixIcon: InkWell(
                    onTap: () async {
                      var scannedValue =
                          await Utils().scanAndPlaySound(context);
                      if (scannedValue != null && scannedValue != '-1') {
                        deliveryController.pincodeController.text =
                            scannedValue;
                        Get.dialog(
                          const Center(
                              child: CircularProgressIndicator.adaptive()),
                          barrierDismissible: false,
                        );

                        await runningController.fetchTrackingData(scannedValue);
                        Get.back(); // Close the dialog
                        Get.toNamed(
                          Routes.RUNNING_DELIVERY_DETAILS,
                          arguments: {
                            'shipmentID': scannedValue,
                            // 'status': data.status.toString(),
                            // 'invoicePath': data.invoicePath,
                            // 'invoicePhoto': data.invoiceFile,
                            // 'paymentMode': data.paymentMode,
                            // 'date': data.date,
                            // 'cashAmt': data.totalCharges
                          },
                        );
                      }
                    },
                    child: Icon(CupertinoIcons.qrcode_viewfinder),
                  ),
                ),
                // Text(
                //   'Recent Selected Pin code',
                //   style: themes.fontSize14_500,
                // ),
                Obx(
                  () => Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            deliveryController.selectedContainer(0);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: deliveryController.isSelected.value == 0
                                    ? themes.darkCyanBlue
                                    : themes.whiteColor,
                                borderRadius: BorderRadius.circular(
                                  15.r,
                                ),
                                border: Border.all(
                                  color:
                                      deliveryController.isSelected.value == 0
                                          ? themes.whiteColor
                                          : themes.grayColor,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Delivery",
                                textAlign: TextAlign.center,
                                style: themes.fontSize14_500.copyWith(
                                    color:
                                        deliveryController.isSelected.value == 0
                                            ? themes.whiteColor
                                            : themes.grayColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            deliveryController.selectedContainer(1);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: deliveryController.isSelected.value == 1
                                    ? themes.darkCyanBlue
                                    : themes.whiteColor,
                                borderRadius: BorderRadius.circular(
                                  15.r,
                                ),
                                border: Border.all(
                                  color:
                                      deliveryController.isSelected.value == 1
                                          ? themes.whiteColor
                                          : themes.grayColor,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Delivered',
                                textAlign: TextAlign.center,
                                style: themes.fontSize14_500.copyWith(
                                    color:
                                        deliveryController.isSelected.value == 1
                                            ? themes.whiteColor
                                            : themes.grayColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                deliveryController.isSelected.value == 0
                    ? SizedBox(
                        height: 505.h,
                        child: Obx(
                          () {
                            if (deliveryController.isDeliveryLoading.value ==
                                Status.loading) {
                              return Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            } else if (deliveryController
                                        .isDeliveryLoading.value ==
                                    Status.error ||
                                deliveryController
                                    .filteredDeliveryList.isEmpty) {
                              return Center(
                                child: Text(
                                  'No Delivery Data Found!',
                                  style: themes.fontSize14_500,
                                ),
                              );
                            } else if (deliveryController
                                    .isDeliveryLoading.value ==
                                Status.success) {
                              return RefreshIndicator.adaptive(
                                onRefresh: () async {
                                  await deliveryController.getDeliveryData();
                                },
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 1.h,
                                  ),
                                  itemCount: deliveryController
                                      .filteredDeliveryList.length,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final deliveryData = deliveryController
                                        .filteredDeliveryList[index];
                                    return Container(
                                      margin: EdgeInsets.all(8.w),
                                      padding: EdgeInsets.all(10.w),
                                      decoration: BoxDecoration(
                                        color: themes.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4.r,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: PickupWidget(
                                        onTap: () {
                                          runningController.fetchTrackingData(
                                              deliveryData.shipmentId
                                                  .toString());
                                          Get.toNamed(
                                            Routes.RUNNING_DELIVERY_DETAILS,
                                            arguments: {
                                              'shipmentID': deliveryData
                                                  .shipmentId
                                                  .toString(),
                                              // 'status': data.status.toString(),
                                              // 'invoicePath': data.invoicePath,
                                              // 'invoicePhoto': data.invoiceFile,
                                              // 'paymentMode': data.paymentMode,
                                              // 'date': data.date,
                                              // 'cashAmt': data.totalCharges
                                            },
                                          );
                                        },
                                        isShowPaymentType: true,
                                        companyName:
                                            deliveryData.companyName.toString(),
                                        date: formatDate(
                                            deliveryData.date.toString()),
                                        status: deliveryData.status.toString(),
                                        messangerName: '',
                                        address:
                                            deliveryData.address1.toString(),
                                        shipmentID:
                                            deliveryData.shipmentId.toString(),
                                        cityName:
                                            deliveryData.cityName.toString(),
                                        mobile: deliveryData.mobile.toString(),
                                        paymentType: deliveryData.paymentMode,
                                        statusColor: themes.redColor,
                                        statusDotColor: themes.redColor,
                                        showPickupBtn: true,
                                        showTrasferBtn: false,
                                        showDivider: true,
                                        openDialerTap: () {
                                          runningController.makingPhoneCall(
                                              deliveryData.mobile.toString());
                                        },
                                        openMapTap: () {
                                          pickupController.openMapWithAddress(
                                              deliveryData.companyName
                                                  .toString(),
                                              deliveryData.address1.toString(),
                                              deliveryData.pincode.toString());
                                        },
                                        pickUpTap: () async {
                                          final amountController =
                                              deliveryController
                                                  .getAmountController(
                                                      deliveryData.shipmentId
                                                          .toString());

                                          final chequeController =
                                              deliveryController
                                                  .getAccountController(
                                                      deliveryData.shipmentId
                                                          .toString());

                                          final otpController =
                                              deliveryController
                                                  .getOtpController(deliveryData
                                                      .shipmentId
                                                      .toString());

                                          if (deliveryData.paymentMode ==
                                              'topay') {
                                            showDialog(
                                              context: context,
                                              builder: (_) => DeliveryDialog(
                                                shipmentID: deliveryData
                                                    .shipmentId
                                                    .toString(),
                                                date: deliveryData.date
                                                    .toString(),
                                                amountController:
                                                    amountController,
                                                chequeNumberController:
                                                    chequeController,
                                                otpController: otpController,
                                                dropdownHintTxt:
                                                    'Select Payment Mode',
                                                btnTxt: 'Delivery',
                                                onConfirmCallback: () async {
                                                  // Get the selected sub payment mode inside the callback
                                                  final subPaymentMode =
                                                      deliveryController
                                                          .getSelectedSubPaymentMode(
                                                              deliveryData
                                                                  .shipmentId
                                                                  .toString())
                                                          .value
                                                          ?.id;

                                                  deliveryController
                                                      .uploadDelivery(
                                                    deliveryData.shipmentId,
                                                    'Delivered',
                                                    deliveryController
                                                        .currentUserId.value,
                                                    deliveryData.date,
                                                    deliveryData.totalCharges
                                                        .toString(),
                                                    amountController.text,
                                                    deliveryData.paymentMode,
                                                    subPaymentMode,
                                                    otpController.text,
                                                    chequeNumber:
                                                        chequeController.text,
                                                  );
                                                },
                                                onSendOtpCallback: () async {
                                                  await pickupController.getOtp(
                                                      deliveryData.shipmentId
                                                          .toString());
                                                },
                                              ),
                                            );
                                          } else {
                                            showOtpDialog(
                                              () async {
                                                try {
                                                  await deliveryController
                                                      .uploadDelivery(
                                                    deliveryData.shipmentId
                                                        .toString(),
                                                    'Delivered',
                                                    deliveryController
                                                        .currentUserId.value,
                                                    deliveryData.date,
                                                    deliveryData.totalCharges
                                                        .toString(),
                                                    0,
                                                    deliveryData.paymentMode,
                                                    0,
                                                    otpController.text,
                                                    chequeNumber: '0',
                                                  );
                                                } catch (e) {
                                                  // Close dialog even if there's an error
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                              () async {
                                                await pickupController.getOtp(
                                                    deliveryData.shipmentId
                                                        .toString());
                                              },
                                              otpController,
                                            );
                                          }
                                        },
                                        transferBtnColor: null,
                                        transferTextColor: themes.darkCyanBlue,
                                        trasferTap: () {},
                                        transferBorderColor:
                                            themes.darkCyanBlue,
                                        pickupTxt: 'Delivery',
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Center(
                                child: Text(
                                  'No Delivery Data Found!',
                                  style: themes.fontSize18_600,
                                ),
                              );
                            }
                          },
                        ),
                      )
                    : SizedBox(
                        height: 505.h,
                        child: Obx(
                          () {
                            if (historyController.isDeliveredLoading.value ==
                                Status.loading) {
                              return Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            } else if (historyController
                                        .isDeliveredLoading.value ==
                                    Status.error ||
                                historyController.historyList.isEmpty) {
                              return Center(
                                child: Text(
                                  'No Delivered Data Found!',
                                  style: themes.fontSize14_500,
                                ),
                              );
                            } else if (historyController
                                    .isDeliveredLoading.value ==
                                Status.success) {
                              return RefreshIndicator.adaptive(
                                onRefresh: () =>
                                    historyController.getDeliveryHistory(),
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 1.h,
                                  ),
                                  itemCount:
                                      historyController.historyList.length,
                                  shrinkWrap: true,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final data =
                                        historyController.historyList[index];

                                    return Container(
                                      margin: EdgeInsets.all(8.w),
                                      padding: EdgeInsets.all(10.w),
                                      decoration: BoxDecoration(
                                        color: themes.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4.r,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: InkWell(
                                        child: PickupWidget(
                                          onTap: () {
                                            runningController.fetchTrackingData(
                                                data.shipmentId.toString());
                                            Get.toNamed(
                                              Routes.RUNNING_DELIVERY_DETAILS,
                                              arguments: {
                                                'shipmentID':
                                                    data.shipmentId.toString(),
                                                // 'status': data.status.toString(),
                                                // 'invoicePath': data.invoicePath,
                                                // 'invoicePhoto': data.invoiceFile,
                                                // 'paymentMode': data.paymentMode,
                                                // 'date': data.date,
                                                // 'cashAmt': data.totalCharges
                                              },
                                            );
                                            // Get.to(
                                            //   RunningDeliveryDetailsView(
                                            //     isShowInvoice: true,
                                            //     isShowTransfer: true,
                                            //   ),
                                            //   arguments: {
                                            //     'shipmentID': data.shipmentId.toString(),
                                            //     'status': data.status.toString(),
                                            //     'invoicePath': data.invoicePath,
                                            //     'invoicePhoto': data.invoiceFile,
                                            //     'paymentMode': data.paymentMode,
                                            //     'date': data.date,
                                            //     'cashAmt': data.totalCharges
                                            //   },
                                            // );
                                          },
                                          isShowPaymentType: false,
                                          companyName:
                                              data.companyName.toString(),
                                          date:
                                              formatDate(data.date.toString()),
                                          status: data.status.toString(),
                                          messangerName: '',
                                          address: data.address1.toString(),
                                          shipmentID:
                                              data.shipmentId.toString(),
                                          cityName: data.cityName.toString(),
                                          mobile: data.mobile.toString(),
                                          paymentType: data.paymentMode,
                                          statusColor: themes.greenColor,
                                          statusDotColor: themes.greenColor,
                                          showPickupBtn: false,
                                          showTrasferBtn: false,
                                          showDivider: false,
                                          openDialerTap: () {
                                            runningController.makingPhoneCall(
                                                data.mobile.toString());
                                          },
                                          openMapTap: () {
                                            pickupController.openMapWithAddress(
                                                data.companyName.toString(),
                                                data.address1.toString(),
                                                data.pincode.toString());
                                          },
                                          pickUpTap: () async {},
                                          transferBtnColor: null,
                                          transferTextColor:
                                              themes.darkCyanBlue,
                                          trasferTap: () {},
                                          transferBorderColor:
                                              themes.darkCyanBlue,
                                          pickupTxt: 'Delivery',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Center(
                                child: Text(
                                  'No Delivery Data Found!',
                                  style: themes.fontSize18_600,
                                ),
                              );
                            }
                          },
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
