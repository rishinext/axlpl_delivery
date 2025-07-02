import 'package:axlpl_delivery/app/data/networking/data_state.dart';
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
import 'package:axlpl_delivery/common_widget/show_delivery_dialog.dart';
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
    return CommonScaffold(
      appBar: commonAppbar('Delivery'),
      body: Padding(
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
                    var scannedValue = await Utils().scanAndPlaySound(context);
                    if (scannedValue != null && scannedValue != '-1') {
                      deliveryController.pincodeController.text = scannedValue;
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
              SizedBox(
                height: 505.h,
                child: Obx(
                  () {
                    if (deliveryController.isDeliveryLoading.value ==
                        Status.loading) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (deliveryController.isDeliveryLoading.value ==
                            Status.error ||
                        deliveryController.filteredDeliveryList.isEmpty) {
                      return Center(
                        child: Text(
                          'No Delivery Data Found!',
                          style: themes.fontSize14_500,
                        ),
                      );
                    } else if (deliveryController.isDeliveryLoading.value ==
                        Status.success) {
                      return ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          height: 1.h,
                        ),
                        itemCount:
                            deliveryController.filteredDeliveryList.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data =
                              deliveryController.filteredDeliveryList[index];
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
                                runningController
                                    .makingPhoneCall(data.mobile.toString());
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
                                        data.subPaymentMode == '0' ||
                                                data.subPaymentMode == ''
                                            ? 'Select Payment Mode'
                                            : data.subPaymentMode,
                                        'Delivery',
                                        () {},
                                      )
                                    : showOtpDialog(() async {
                                        pickupController.uploadPickup(
                                          data.shipmentId.toString(),
                                          'Picked up',
                                          data.date.toString(),
                                          // data.totalCharges,
                                          '',
                                          '',
                                          pickupController.otpController.text,
                                        );
                                      }, pickupController.otpController);

                                await pickupController
                                    .getOtp(data.shipmentId.toString());
                              },
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
    );
  }
}
