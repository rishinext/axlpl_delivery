import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/history/controllers/history_controller.dart';
import 'package:axlpl_delivery/app/modules/pickdup_delivery_details/controllers/running_delivery_details_controller.dart';
import 'package:axlpl_delivery/app/modules/pickup/controllers/pickup_controller.dart';
import 'package:axlpl_delivery/app/routes/app_pages.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/container_textfiled.dart';
import 'package:axlpl_delivery/common_widget/otp_dialog.dart';
import 'package:axlpl_delivery/common_widget/pickup_dialog.dart';
import 'package:axlpl_delivery/common_widget/pickup_widget.dart';
import 'package:axlpl_delivery/common_widget/delivery_dialog.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/delivery_controller.dart';

class DeliveryView extends GetView<DeliveryController> {
  const DeliveryView({super.key});
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
                                    final data = deliveryController
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
                                              data.shipmentId.toString());
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
                                        isShowPaymentType: true,
                                        companyName:
                                            data.companyName.toString(),
                                        date: data.date.toString(),
                                        status: data.status.toString(),
                                        messangerName: '',
                                        address: data.address1.toString(),
                                        shipmentID: data.shipmentId.toString(),
                                        cityName: data.cityName.toString(),
                                        mobile: data.mobile.toString(),
                                        paymentType: data.paymentMode,
                                        statusColor: data.status == 'Picked up'
                                            ? themes.greenColor
                                            : themes.redColor,
                                        statusDotColor: themes.darkCyanBlue,
                                        showPickupBtn: true,
                                        showTrasferBtn: false,
                                        showDivider: true,
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
                                        pickUpTap: () async {
                                          data.paymentMode == 'topay'
                                              ? showDeliveryDialog(
                                                  data.shipmentId.toString(),
                                                  data.date.toString(),
                                                  deliveryController
                                                      .amountController.text,
                                                  deliveryController
                                                      .selectedSubPaymentMode
                                                      .value
                                                      ?.id,
                                                  'Delivery',
                                                  () async {
                                                    deliveryController
                                                        .uploadDelivery(
                                                      data.shipmentId,
                                                      'Delivered',
                                                      deliveryController
                                                          .currentUserId.value,
                                                      data.date,
                                                      data.totalCharges
                                                          .toString(),
                                                      deliveryController
                                                          .amountController
                                                          .text,
                                                      data.paymentMode,
                                                      deliveryController
                                                          .selectedSubPaymentMode
                                                          .value
                                                          ?.id,
                                                      deliveryController
                                                          .otpController.text,
                                                      chequeNumber:
                                                          deliveryController
                                                              .chequeNumberController
                                                              .text,
                                                    );
                                                  },
                                                  () async {
                                                    await pickupController
                                                        .getOtp(data.shipmentId
                                                            .toString());
                                                  },
                                                )
                                              : showOtpDialog(() async {
                                                  deliveryController
                                                      .uploadDelivery(
                                                    data.shipmentId.toString(),
                                                    'Delivered',
                                                    data.messangerId,
                                                    data.date,
                                                    data.totalCharges
                                                        .toString(),
                                                    0,
                                                    data.paymentMode,
                                                    data.subPaymentMode ==
                                                                '0' ||
                                                            data.subPaymentMode ==
                                                                ''
                                                        ? 'Select Payment Mode'
                                                        : data.subPaymentMode,
                                                    deliveryController
                                                        .otpController.text,
                                                    chequeNumber:
                                                        deliveryController
                                                            .chequeNumberController
                                                            .text,
                                                  );
                                                }, () async {
                                                  await pickupController.getOtp(
                                                      data.shipmentId
                                                          .toString());
                                                },
                                                  pickupController
                                                      .otpController);
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
                              return ListView.separated(
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 1.h,
                                ),
                                itemCount: historyController.historyList.length,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final data = deliveryController
                                      .filteredDeliveryList[index];
                                  return Container(
                                    margin: EdgeInsets.all(8.w),
                                    padding: EdgeInsets.all(10.w),
                                    decoration: BoxDecoration(
                                      color: themes.whiteColor,
                                      borderRadius: BorderRadius.circular(15.r),
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
                                            data.shipmentId.toString());
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
                                      isShowPaymentType: true,
                                      companyName: data.companyName.toString(),
                                      date: data.date.toString(),
                                      status: data.status.toString(),
                                      messangerName: '',
                                      address: data.address1.toString(),
                                      shipmentID: data.shipmentId.toString(),
                                      cityName: data.cityName.toString(),
                                      mobile: data.mobile.toString(),
                                      paymentType: data.paymentMode,
                                      statusColor: data.status == 'Picked up'
                                          ? themes.greenColor
                                          : themes.redColor,
                                      statusDotColor: themes.darkCyanBlue,
                                      showPickupBtn: true,
                                      showTrasferBtn: false,
                                      showDivider: true,
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
                                      transferTextColor: themes.darkCyanBlue,
                                      trasferTap: () {},
                                      transferBorderColor: themes.darkCyanBlue,
                                      pickupTxt: 'Delivery',
                                    ),
                                  );
                                },
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
